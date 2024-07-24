local M = {}

local function encode_json(obj)
	local json = vim.fn.json_encode(obj)

	return json
end

local function api_call(messages, callback)
	-- Construct the API request
	local api_key = vim.env.GROQ_API_KEY
	local model = "llama-3.1-70b-versatile" -- or any other model you want to use
	local url = "https://api.groq.com/openai/v1/chat/completions"
	local headers = string.format('-H "Content-Type: application/json" -H "Authorization: Bearer %s"', api_key)

	local messages_json = encode_json(messages)
	local data = string.format('{"model": "%s", "messages": %s}', model, messages_json)

	-- Create a temporary file to store the JSON data
	local tmp_file = os.tmpname()
	local f = io.open(tmp_file, "w")
	f:write(data)
	f:close()

	-- Construct the curl command
	local cmd = string.format(
		'curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer %s" -d @%s "%s"',
		api_key,
		tmp_file,
		url
	)

	local response_chunks = {}
	local error_chunks = {}

	vim.fn.jobstart(cmd, {
		on_stdout = function(_, data)
			if data and #data > 1 then
				for _, chunk in ipairs(data) do
					if chunk ~= "" then
						table.insert(response_chunks, chunk)
					end
				end
			end
		end,
		on_stderr = function(_, data)
			if data and #data > 1 then
				for _, chunk in ipairs(data) do
					if chunk ~= "" then
						table.insert(error_chunks, chunk)
					end
				end
			end
		end,
		on_exit = function()
			local response = table.concat(response_chunks)
			local error_msg = table.concat(error_chunks)

			if #error_chunks > 0 then
				callback("Error: " .. error_msg)
			else
				local success, decoded = pcall(vim.json.decode, response)
				if success and decoded.choices and decoded.choices[1] and decoded.choices[1].message then
					callback(decoded.choices[1].message.content)
				else
					callback("Error: Unable to parse API response\n" .. response)
				end
			end
		end,
	})
end

function M.process_instruction()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local current_line = cursor[1]

	-- Get all lines from the buffer
	local all_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Separate the instruction (current line) from the context
	local instruction = all_lines[current_line]
	local context = table.concat(all_lines, "")

	-- Prepare messages for the API
	local messages = {
		{
			role = "system",
			content = "You are an experienced software engineer who has worked on all parts of the stack. Only ever reply with valid runnable code. DO NOT EVER wrap the code with any backtick characters. DO NOT EVER answer with markdown or any markdown like syntax. Only output code. Try to fit your code into the existing context, dont write a program from scratch. Strive for simplicity. The code you write will be inserted right after the instruction. The following is the context of the code already written:"
				.. context,
		},
		{ role = "user", content = instruction },
	}

	-- Call the API (mocked for now) with a callback
	api_call(messages, function(api_response)
		print(api_response)
		-- Insert the API response below the current line
		vim.schedule(function()
			-- Insert the API response below the current line
			vim.api.nvim_buf_set_lines(bufnr, current_line, current_line, false, vim.split(api_response, "\n"))

			-- Move the cursor to the first line of the inserted response
			vim.api.nvim_win_set_cursor(0, { current_line + 1, 0 })
		end)
	end)
end

-- Set up a command to call the function
vim.api.nvim_create_user_command("Ai", M.process_instruction, {})

return M

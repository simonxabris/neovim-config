local M = {}

local function find_fixture_definition(fixture_name)
	-- Use ast-grep or another tool to search for the fixture definition
	-- For simplicity, let's assume we use a shell command with ast-grep
	local command = string.format("ast-grep --pattern 'function %s()'", fixture_name)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	-- Parse the result to get the file path and line number
	local file_path, line_number = result:match("(%S+):(%d+)")
	return file_path, tonumber(line_number)
end

function M.goto_fixture_definition()
	-- Get the word under the cursor
	local fixture_name = vim.fn.expand("<cword>")

	-- Find the fixture definition
	local file_path, line_number = find_fixture_definition(fixture_name)
	if not file_path or not line_number then
		vim.notify("Fixture definition not found: " .. fixture_name, vim.log.levels.ERROR)
		return
	end

	-- Open the file and move the cursor to the definition
	vim.cmd("edit " .. file_path)
	vim.fn.cursor({ line_number, 1 })
end

-- Create a command to trigger the functionality
vim.api.nvim_create_user_command("GotoFixture", M.goto_fixture_definition, {})

return M

local M = {}

-- setup
function M.setup(opts)
  -- dummy
end
-- Helper to find the absolute path of the python script
local function get_python_script_path()
	local info = debug.getinfo(1, "S").source:sub(2)
	-- This assumes the structure: lua/docgen/init.lua
	-- We go up two levels to reach the root, then into python/sc.py
	return vim.fn.fnamemodify(info, ":h:h:h") .. "/python/codebot"
end

function M.run_sc_on_function()
	local ts_utils = require("nvim-treesitter.ts_utils")

	-- 1. Find the current node (function)
	local node = ts_utils.get_node_at_cursor()
	while node do
		if node:type() == "function_definition" or node:type() == "method_definition" then
			break
		end
		node = node:parent()
	end

	if not node then
		print("No function found at cursor!")
		return
	end

	-- 2. Get the text of the function
	local bufnr = vim.api.nvim_get_current_buf()
	local start_row, start_col, end_row, end_col = node:range()
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)
	local input_text = table.concat(lines, "\n")

	-- 3. Run the python script
	local script_path = get_python_script_path()
	local output = vim.fn.system("python3 " .. vim.fn.shellescape(script_path), input_text)

	-- 4. Replace the old function with the new output
	local new_lines = vim.split(output, "\n")
	vim.api.nvim_buf_set_lines(bufnr, start_row, end_row, false, new_lines)
end

return M

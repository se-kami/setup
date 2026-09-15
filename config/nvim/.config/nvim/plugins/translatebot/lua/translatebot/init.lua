local utils = require("translatebot.utils")

local M = {}

local function Translate()
	-- get text
	local selection = utils.get_visual_selection()
  local row_start = selection[1]
  local row_end = selection[2]
  local lines = selection[3]
  local text = table.concat(lines, "\n")

	-- run command
	local handle = io.popen("translate ko en \"" .. text .. "\"")
	if handle == nil then
		return
	end
	local result = handle:read("*a")
	handle:close()
	local result = vim.split(result, "\n", {})

	-- fill in lines
	for i = row_start, row_end do
		vim.api.nvim_buf_set_lines(0, row_start - 1, row_start, false, {}) -- clear lines
	end
	for i, line in ipairs(result) do
		vim.api.nvim_buf_set_lines(0, row_start + i - 2, row_start + i - 2, false, { line }) -- write text
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)
end

M.setup = function(opts)
	opts = opts or {}
	vim.keymap.set("v", "<Leader>tra", Translate, { noremap = true, silent = true })
end

return M

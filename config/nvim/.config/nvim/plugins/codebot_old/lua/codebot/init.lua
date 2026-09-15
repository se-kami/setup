local utils = require("codebot.utils")

local M = {}

local function Docstringmaker()
	local row_start = vim.fn.getpos("v")[2] -- last start
	local row_end = vim.fn.getcurpos()[2] -- last end
	if row_start > row_end then
		row_start, row_end = row_end, row_start
	end

	-- get text
	local text = vim.api.nvim_buf_get_lines(0, row_start, row_end, false)
	local split_text = table.concat(text, "\n")

	-- run command
	-- local handle = io.popen("docstringmaker " .. split_text)
	local handle = io.popen("/home/skm/.config/nvim/plugins/codebot/script/codebot " .. split_text)
	if handle == nil then
		return
	end
	local result = handle:read("*a")
	handle:close()
	local lines = vim.split(result, "\n", {})

	-- fill in lines
	for i = row_start, row_end do
		vim.api.nvim_buf_set_lines(0, row_start - 1, row_start, false, {}) -- clear lines
	end
	for i, line in ipairs(lines) do
		vim.api.nvim_buf_set_lines(0, row_start + i - 2, row_start + i - 2, false, { line }) -- write text
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)
end

local function Docstringmakerr()
	local row_start = vim.fn.getpos("v")[2] -- last start
	local row_end = vim.fn.getcurpos()[2] -- last end
	if row_start > row_end then
		row_start, row_end = row_end, row_start
	end

	-- get text
	local text = vim.api.nvim_buf_get_lines(0, row_start - 1, row_end, false)
	local split_text = table.concat(text, "\n")
  local lines = vim.split(split_text, "\n", {})

	-- fill in lines
	for i = row_start, row_end do
		vim.api.nvim_buf_set_lines(0, row_start - 1, row_start, false, {}) -- clear lines
	end
	for i, line in ipairs(lines) do
		vim.api.nvim_buf_set_lines(0, row_start + i - 2, row_start + i - 2, false, { "# " .. line }) -- write text
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)

end

M.setup = function(opts)
	opts = opts or {}
	vim.keymap.set("v", "<Leader>doc", Docstringmakerr, { noremap = true, silent = true })
end

return M

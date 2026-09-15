local M = {}

function M.get_visual_selection()
	local row_start = vim.fn.getpos("v")[2] -- last start

	local row_end = vim.fn.getcurpos()[2] -- last end
	if row_start > row_end then
		row_start, row_end = row_end, row_start
	end
	local lines = vim.api.nvim_buf_get_lines(0, row_start - 1, row_end, false)
  return {row_start, row_end, lines}

	-- local s_start = vim.fn.getpos("'<")
	-- local s_end = vim.fn.getpos("'>")
	-- local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	-- lines[1] = string.sub(lines[1], s_start[3], -1)
	-- if n_lines == 1 then
	-- 	lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	-- else
	-- 	lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	-- end
	-- return table.concat(lines, "\n")

end

return M

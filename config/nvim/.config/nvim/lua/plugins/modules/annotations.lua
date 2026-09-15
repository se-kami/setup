local M = {
	"danymat/neogen",
	config = function()
  require('neogen').setup({})
		vim.api.nvim_set_keymap("n", "<Leader>neo", ":Neogen<CR>", { noremap = true, silent = true })
	end,
}

return M

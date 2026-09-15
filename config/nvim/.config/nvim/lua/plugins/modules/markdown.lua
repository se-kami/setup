local M = {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"dbridges/vim-markdown-runner",
		config = function()
			local keymap = vim.keymap
			keymap.set(
				"n",
				"<leader>mr",
				":MarkdownRunner<CR>",
				{ noremap = true, silent = true, desc = "Run markdown cell." }
			)
		end,
	},
}

return M

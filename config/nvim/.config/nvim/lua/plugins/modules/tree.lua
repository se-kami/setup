-- tree
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		-- OR setup with some options
		nvimtree.setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
				relativenumber = true,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				group_empty = true,
				icons = {
					glyphs = {
						folder = {
							arrow_closed = ">",
							arrow_open = "_",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				dotfiles = true,
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- keymap
		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>") -- toggle
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>") -- find files
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>") -- collapse
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>") -- refresh
	end,
}

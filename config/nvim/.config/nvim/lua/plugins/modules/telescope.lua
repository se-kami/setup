-- telescope - move between files
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-file-browser.nvim",
		-- "folke/todo-comments.nvim",
		-- {
		-- 'nvim-telescope/telescope-media-files.nvim',
		-- dependencies = { 'nvim-lua/popup.nvim' },
		-- },
	},
	config = function()
		-- local telescope = require("telescope")
		-- local actions = require("telescope.actions")

		-- check for updates for telescope, replace function for tab drop with "select_tab_drop"
		local actions = require("telescope.actions.set")
		local fb_actions = require("telescope").extensions.file_browser.actions
		require("telescope").setup({

			-- defaults = {
			--     prompt_prefix = " ",
			--     selection_caret = " ",
			--     path_display = { "smart" },

			--     mappings = {
			--       i = {
			--         ["<C-n>"] = actions.cycle_history_next,
			--         ["<C-p>"] = actions.cycle_history_prev,
			--         ["<C-j>"] = actions.move_selection_next,
			--         ["<C-k>"] = actions.move_selection_previous,
			--         ["<C-c>"] = actions.close,
			--         ["<Down>"] = actions.move_selection_next,
			--         ["<Up>"] = actions.move_selection_previous,
			--         ["<CR>"] = actions.select_default,
			--         ["<C-x>"] = actions.select_horizontal,
			--         ["<C-v>"] = actions.select_vertical,
			--         ["<C-t>"] = actions.select_tab,
			--         ["<C-u>"] = actions.preview_scrolling_up,
			--         ["<C-d>"] = actions.preview_scrolling_down,
			--         ["<PageUp>"] = actions.results_scrolling_up,
			--         ["<PageDown>"] = actions.results_scrolling_down,
			--         ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
			--         ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			--         ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			--         ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			--         ["<C-l>"] = actions.complete_tag,
			--         ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			--       },
			--       n = {
			--         ["<esc>"] = actions.close,
			--         ["<CR>"] = actions.select_default,
			--         ["<C-x>"] = actions.select_horizontal,
			--         ["<C-v>"] = actions.select_vertical,
			--         ["<C-t>"] = actions.select_tab,
			--         ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
			--         ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			--         ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			--         ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			--         ["j"] = actions.move_selection_next,
			--         ["k"] = actions.move_selection_previous,
			--         ["H"] = actions.move_to_top,
			--         ["M"] = actions.move_to_middle,
			--         ["L"] = actions.move_to_bottom,
			--         ["<Down>"] = actions.move_selection_next,
			--         ["<Up>"] = actions.move_selection_previous,
			--         ["gg"] = actions.move_to_top,
			--         ["G"] = actions.move_to_bottom,
			--         ["<C-u>"] = actions.preview_scrolling_up,
			--         ["<C-d>"] = actions.preview_scrolling_down,
			--         ["<PageUp>"] = actions.results_scrolling_up,
			--         ["<PageDown>"] = actions.results_scrolling_down,

			--         ["?"] = actions.which_key,
			--       },
			--     },
			-- },
			pickers = {
				find_files = {
					follow = true, -- follow symlinks
					mappings = {
						i = {
							--["<CR>"] = "select_tab_drop",
							--["<CR>"] = "select_tab",
							["<CR>"] = function(bufnr)
								actions.edit(bufnr, "tab drop")
							end,
							["<C-o>"] = "select_default",
						},
					},
				},
				git_files = {
					mappings = {
						i = {
							--["<CR>"] = "select_tab_drop",
							--["<CR>"] = "select_tab",
							["<CR>"] = function(bufnr)
								actions.edit(bufnr, "tab drop")
							end,
							["<C-o>"] = "select_default",
						},
					},
				},
				buffers = {
					mappings = {
						i = {
							--["<CR>"] = "select_tab_drop",
							["<CR>"] = "select_tab",
							["<C-o>"] = "select_default",
							["<C-d>"] = require("telescope.actions").delete_buffer,
						},
					},
				},
				live_grep = {
          additional_args = {
            "-L", -- follow symlinks
          },
					mappings = {
						i = {
							["<CR>"] = function(bufnr)
								actions.edit(bufnr, "tab drop")
							end,
							["<C-o>"] = "select_default",
						},
					},
				},
			},

			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				file_browser = {
					theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						["i"] = {
							-- ["<C-w>"] = false, -- disable ctrl - w
							-- your custom insert mode mappings
						},
						["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
							-- your custom normal mode mappings
						},
					},
				},
				--   media_files = {
				--       -- filetypes whitelist
				--       -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				--       filetypes = {"png", "webp", "jpg", "jpeg"},
				--       find_cmd = "rg" -- find command (defaults to `fd`)
				--     }
			},
		})

		-- keymaps
		local builtin = require("telescope.builtin")
		local opts = { noremap = true, silent = true }
		-- search files
		vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
		-- vim.keymap.set('n', '<C-p>', builtin.find_files(require('telescope.themes').get_dropdown({previewer=false})), {})
		-- opened buffers
		vim.keymap.set("n", "<C-o>", builtin.buffers, opts)
		-- grep
		vim.keymap.set("n", "<C-g>", builtin.live_grep, opts)
		-- ctrl - w -- open vimwiki
		vim.keymap.set("n", "<C-w>", function()
			builtin.find_files({ search_dirs = { "~/docs/wiki" } })
		end, opts)
		-- builtin.help_tags, keymaps, find_files, builtin, grep_string, live_grep, diagnostics, resume, oldfiles, buffers
    opts.desc = "Search keymaps."
		vim.keymap.set("n", "<leader>key", builtin.keymaps, opts)
    opts.desc = "Search help tags."
		vim.keymap.set("n", "<leader>the", builtin.help_tags, opts)

		-- search config files
    opts.desc = "Search nvim config files."
		vim.keymap.set("n", "<leader>tc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, opts)

    opts.desc = "Telescope treesitter."
		vim.keymap.set("n", "<leader>ts", function()
			builtin.treesitter()
		end, opts)

		-- vim.keymap.set('n', '<leader>ff', <cmd>Telescope find_files<cr>, ) -- find files
		-- vim.keymap.set('n', '<leader>ff', <cmd>Telescope oldfiles<cr>, ) -- find old files
		-- vim.keymap.set('n', '<leader>ff', <cmd>Telescope live_grep<cr>, ) -- grep
		-- vim.keymap.set('n', '<leader>ff', <cmd>Telescope grep_string<cr>, ) -- grep string under cursor
		-- vim.keymap.set('n', '<leader>ft', <cmd>TodoTelescope<cr>, ) -- todo list

		-- vim.keymap.set('n', '<C-f>', "<cmd>Telescope lsp_references theme=ivy<cr>", {}) -- change theme
		-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		-- vim.keymap.set('n', '<C-g>', function()
		-- builtin.grep_string({ search = vim.fn.input("Grep > ") });
		-- end)

		-- media extension
		-- require('telescope').load_extension('media_files')
		-- fzf
		require("telescope").load_extension("fzf")
		-- tree
		require("telescope").load_extension("file_browser")
	end,
}

-- dark
vim.o.background = "dark"

-- transparent
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- gruvbox
local M = {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {},
		config = function()
			require("gruvbox").setup({
				contrast = "hard", -- can be "hard", "soft" or empty string
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
				-- terminal_colors = true, -- add neovim terminal colors
				-- undercurl = true,
				-- underline = true,
				-- bold = true,
				-- italic = {
				--   strings = true,
				--   emphasis = true,
				--   comments = true,
				--   operators = false,
				--   folds = true,
				-- },
				-- strikethrough = true,
				-- invert_selection = false,
				-- invert_signs = false,
				-- invert_tabline = false,
				-- invert_intend_guides = false,
				-- inverse = true, -- invert background for search, diffs, statuslines and errors
				-- dim_inactive = false,
				-- transparent_mode = false,
				-- palette_overrides = {
				--     bright_green = "#990000",
				-- },
				-- overrides = {
				--     SignColumn = {bg = "#ff9900"}
				-- ["@lsp.type.method"] = { bg = "#ff9900" },
				-- ["@comment.lua"] = { bg = "#000000" },
				-- },
			})

			vim.cmd.colorscheme("gruvbox") -- last

			-- transparent (after colorscheme)
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
	{
		"RRethy/vim-hexokinase",
		build = "make hexokinase",
		config = function()
			-- hexokinase
			vim.g.Hexokinase_highlighters = { "backgroundfull" }
			vim.g.Hexokinase_optInPatterns = { "full_hex", "rgb", "rgba", "hsl", "hsla" }
		end,
	},
	{ "tjdevries/colorbuddy.nvim" },
}

return M

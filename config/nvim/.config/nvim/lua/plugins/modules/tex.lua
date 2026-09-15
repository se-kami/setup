return {
	"lervag/vimtex",
	config = function()
		-- conceal
		vim.g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
		vim.g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
		vim.g.tex_conceal_frac = 1
		vim.g.tex_conceal = "abdmg"

		-- latex
		vim.g.tex_flavor = "latexmk -pdf"
		vim.g.vimtex_compiler_latexmk = {
			out_dir = "build",
			callback = 1,
			continuous = 1,
			options = {
				"-pdf",
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull \\hbox (badness",
			"Overfull \\hbox",
		}
		vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
		vim.g.vimtex_toc_config = {
			name = "TOC",
			layers = { "content", "todo", "include" },
			resize = 1,
			split_width = 30,
			todo_sorted = 0,
			show_help = 1,
			show_numbers = 1,
			mode = 2,
		}

		-- viewer
		vim.g.vimtex_view_general_viewer = "zathura"
		vim.g.vimtex_view_automatic = 0
	end,
}

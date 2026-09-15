-- format
return {
	"stevearc/conform.nvim",
	opts = {},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = {
					"isort",
					"black",
					-- "docformatter",
					-- "yapf",
					-- "darker",
					-- "autoflake",
					-- "autopep8",
					-- "ast-grep",
					-- "blue",
					-- "pycln",
					-- "ruff",
				},
				java = { "clang_format", "ast-grep" },
				c = { "clang_format", },
				cpp = { "clang_format", "ast-grep" },
				-- shell
				sh = { "beautysh", "shellharden", "shfmt" },
				bash = { "beautysh", "shellharden" },
				zsh = { "beautysh" },
				csh = { "beautysh" },
				-- tex
				tex = { "bibtex-tidy", "latexindent" },
				-- md
				markdown = { "prettier" },
				-- xml
				xml = { "xmlformatter" },
				-- web
				javascript = { "biome" },
				javascriptreact = { "biome" },
				typescript = { "biome" },
				html = { "ast-grep", "prettier", "prettierd" },
				css = { "ast-grep", "prettier", "prettierd" },
				-- asm = { "asmfmt" },
        json = { "fixjson" },
			},
			notify_on_error = true,
		})

		vim.keymap.set({ "n", "v" }, "<leader>fo", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format file or range" })

		-- formatter
		-- local util = require "formatter.util"
		-- require("formatter").setup {
		--   logging = true,
		--   log_level = vim.log.levels.WARN,
		--   filetype = {
		--     python = {
		--       require("formatter.filetypes.python").black,
		--     },
		--   }
		-- }
	end,
}

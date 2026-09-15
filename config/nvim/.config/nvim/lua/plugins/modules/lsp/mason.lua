local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		mason.setup({
			-- ui = {
			-- icons = {
			-- package_uninstalled = "X"
			-- }
			-- }
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				-- "lua_ls",          -- lua
				-- "rust_analyzer", -- rust -- install in system
				-- "pylsp",           -- python -- install in system
				"clangd", -- c, cpp
				-- "jdtls", -- java -- install in system
				-- "jsonls", -- json
				-- 'jedi_language_server' -- python
			},
			-- handlers = {
			-- default_setup,
			-- lua_ls = function()
			-- local lua_opts = nvim_lua_ls()
			-- require('lspconfig').lua_ls.setup(lua_opts)
			-- end,
			-- },
		})
	end,
}

return M

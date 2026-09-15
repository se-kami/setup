return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			-- config
			ls.config.setup({
				updateevents = "TextChanged,TextChangedI",
			})

			-- keymaps
			vim.keymap.set({ "i" }, "<C-K>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				ls.jump(-1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-H>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	-- {
	-- "rafamadriz/friendly-snippets",        -- useful snippets
	-- config = {
	--   function()
	--   -- require("luasnip.loaders.from_vscode").lazy_load() -- friendly snippets
	--   end
	-- },
	-- },
}

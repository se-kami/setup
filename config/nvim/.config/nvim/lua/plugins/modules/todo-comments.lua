return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		local todo_comments = require("todo-comments")
		local keymap = vim.keymap
		keymap.set("n", "]t", function()
			todo_comments.jump_next()
		end, { desc = "Next todo comment" })

		keymap.set("n", "[t", function()
			todo_comments.jump_prev()
		end, { desc = "Previous todo comment" })

		todo_comments.setup()
		-- -- You can also specify a list of valid jump keywords
		--
		-- vim.keymap.set("n", "]t", function()
		--   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
		-- end, { desc = "Next error/warning todo comment" })
	end,
}

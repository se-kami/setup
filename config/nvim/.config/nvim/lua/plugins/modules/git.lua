-- git
local M = {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup()
		vim.keymap.set("n", "<leader>gs", "vim.cmd.Git")
	end,
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "-" },
			changedelete = { text = "~" },
		},
		on_attach = function(buf)
			local gs = package.loaded.gitsigns
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
			end
			map("n", "]h", gs.next_hunk, "Next hunk")
			-- gs.toggle_current_line_blame
			-- gs.diffthis
			-- gs.stage_buffer
		end,
	},
}

return {}

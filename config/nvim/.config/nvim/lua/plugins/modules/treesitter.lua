-- treesitter - syntax highlight
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local configs = require("nvim-treesitter.config")
		configs.setup({
			ensure_installed = {
        "python",
			},
			sync_install = false,
			-- ignore_install = { "" }, -- List of parsers to ignore installing
			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "" }, -- list of language that will be disabled
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true, disable = { "yaml" } },
			incremental_selection = {
			  enable = true,
			  keymaps = {
			    init_selection = "<C-space>",
			    node_incremental = "<C-space>",
			    scope_incremental = false,
			    node_decremental = "<C-a>",
			  }
			}
		})

		-- Custom
		-- local api = vim.api
		-- local ts = vim.treesitter
		-- local ts_utils = require("nvim-treesitter.ts_utils")
		--
		-- function get_function_at_cursor()
		-- 	local current_node = ts_utils.get_node_at_cursor()
		-- 	if not current_node then
		-- 		return ""
		-- 	end
		--
		-- 	local expr = current_node
		--
		-- 	while expr do
		-- 		if expr:type() == "function_definition" then
		-- 			break
		-- 		end
		-- 		expr = expr:parent()
		-- 	end
		--
		-- 	if not expr then
		-- 		return ""
		-- 	end
		--
		-- 	-- text
		-- 	local function_text = ts.get_node_text(expr, 0)
		-- 	-- body start
		-- 	local start_row, start_col, end_row, end_col = expr:named_child(2):range()
		-- 	-- insert comment
		-- 	local command = "docstringmaker '" .. function_text .. "'"
		-- 	local text = io.popen(command):read("*a")
		-- 	local lines = vim.split(text, "\n")
		-- 	for i, line in ipairs(lines) do
		-- 		-- make empty line
		-- 		api.nvim_buf_set_lines(0, start_row + i - 1, start_row + i - 1, false, { string.rep(" ", start_col) })
		-- 		-- input line
		-- 		api.nvim_buf_set_text(0, start_row + i - 1, start_col, start_row + i - 1, start_col, { line })
		-- 	end
		-- end
		--
		-- api.nvim_set_keymap("n", "<leader>do", ":lua get_function_at_cursor()<CR>", { noremap = true, silent = true })

    -- folding
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = { "norg", "neorg" },
    --   callback = function()
    --     if pcall(vim.treesitter.start) then
    --       vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    --       vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --     end
    --   end,
    -- })

	end,
}

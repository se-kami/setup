-- completion
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- to enable also add them to after/plugin/lsp.lua in cmp setup
		"hrsh7th/cmp-nvim-lsp", -- lsp completions
		"hrsh7th/cmp-buffer", -- buffer
		"hrsh7th/cmp-path", -- path
		"hrsh7th/cmp-cmdline", -- command line
		"hrsh7th/cmp-nvim-lsp-signature-help", -- signatures
		"hrsh7th/cmp-nvim-lua", -- nvim lua
		"saadparwaiz1/cmp_luasnip", -- luasnip
		-- "onsails/lspkind.nvim", -- vscode-like pictograms
	},
	config = function()
		local cmp = require("cmp")
		-- local cmp_select = {behavior = cmp.SelectBehavior.Select}

		-- local kind_icons = {
		--   Text = "󰊄",
		--   Method = "m",
		--   Function = "󰊕",
		--   Constructor = "",
		--   Field = "",
		--   Variable = "󰫧",
		--   Class = "",
		--   Interface = "",
		--   Module = "",
		--   Property = "",
		--   Unit = "",
		--   Value = "",
		--   Enum = "",
		--   Keyword = "󰌆",
		--   Snippet = "",
		--   Color = "",
		--   File = "",
		--   Reference = "",
		--   Folder = "",
		--   EnumMember = "",
		--   Constant = "",
		--   Struct = "",
		--   Event = "",
		--   Operator = "",
		--   TypeParameter = "󰉺",
		-- }

		local function cmp_format()
			return {
				fields = { "abbr", "menu", "kind" },
				format = function(entry, item)
          local label = item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, 20)
          if truncated_label ~= label then
            item.abbr = truncated_label .. "..."
          elseif string.len(label) < 20 then
            local padding = string.rep(" ", 20 - string.len(label))
            item.abbr = label .. padding
          end

					local n = entry.source.name
					if n == "nvim_lsp" then
						item.menu = "[LSP]"
					elseif n == "nvim_lua" then
						item.menu = "[nvim]"
					else
						item.menu = string.format("[%s]", n)
					end
					return item
				end,
			}
		end
		-- cmp setup
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "cmdline" },
			},

			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm selection
				["<C-a>"] = cmp.mapping.complete(), -- trigger menu
				-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				-- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				-- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				-- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
				-- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}),
				-- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}),
				-- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				-- super tab
				-- ["<Tab>"] = cmp.mapping(function(fallback)
				--   if cmp.visible() then
				--     cmp.select_next_item()
				--   elseif luasnip.expandable() then
				--     luasnip.expand()
				--   elseif luasnip.expand_or_jumpable() then
				--     luasnip.expand_or_jump()
				--   elseif check_backspace() then
				--     fallback()
				--   else
				--     fallback()
				--   end
				-- end, {
				--   "i",
				--   "s",
				-- }),
				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
				--   if cmp.visible() then
				--     cmp.select_prev_item()
				--   elseif luasnip.jumpable(-1) then
				--     luasnip.jump(-1)
				--   else
				--     fallback()
				--   end
				-- end, {
				--   "i",
				--   "s",
				-- }),
			}),
			completion = {
				-- completeopt = 'menu,menuone,preview,noselect'
				autocomplete = false,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = cmp_format(),
			-- formatting = {
			--   fields = { "kind", "abbr", "menu" },
			--   format = function(entry, vim_item)
			--     -- Kind icons
			--     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			--     -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			--     vim_item.menu = ({
			--       luasnip = "[Snippet]",
			--       buffer = "[Buffer]",
			--       path = "[Path]",
			--     })[entry.source.name]
			--     return vim_item
			--   end,
			-- },
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "nvim_lsp", max_item_count = 6 },
				{ name = "buffer", max_item_count = 6 },
				{ name = "luasnip" },
				{ name = "path", max_item_count = 6 },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
		-- sql
		cmp.setup.filetype({ "sql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})

		vim.opt.ph = 15 -- height of the cmp window
	end,
}

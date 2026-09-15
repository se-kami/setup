local function FileCheckOpen(filename)
	-- check if file is open in a buffer
	local n_buffers = vim.fn.bufnr("$")
	local tbl = {}
	for i = 1, n_buffers do
		local bufname = vim.fn.bufname(i)
		if bufname ~= "" and vim.fn.filereadable(bufname) then
			if vim.fn.expand(bufname) == vim.fn.expand(filename) then
        if vim.fn.getbufinfo(i)[1]["loaded"] == 1 then
          return true
        end
			end
		end
	end
	return false
end

local function GetAllOpenBuffers()
	-- check if file is open in a buffer
	local n_buffers = vim.fn.bufnr("$")
	local tbl = {}
	for i = 1, n_buffers do
		local bufname = vim.fn.bufname(i)
		table.insert(tbl, bufname)
  end
	return tbl
end

local M = {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			-- {"antosha417/nvim-lsp-file-operations", config=true},
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			-- lsp config
			-- local lspconfig = require("lspconfig")
			-- mason config
			-- local mason_lspconfig = require("mason-lspconfig")
			-- cmp
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- keymaps
			local keymap = vim.keymap
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					opts.desc = "Show LSP references"
					keymap.set("n", "<leader>gR", "<cmd>Telescope lsp_references<CR>", opts)

					opts.desc = "Go to defition"
					-- keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					-- keymap.set("n", "<leader>gd", function(options)
					-- 	if options == nil then
					-- 		options = {}
					-- 	end
					-- 	local on_list = function(opts)
					-- 		local filename = opts["items"][1]["filename"]
     --          local file_is_open = FileCheckOpen(filename)
     --          return file_is_open
     --          -- print(table.concat(GetAllOpenBuffers(), ","))
					-- 	end
					--
					-- 	local result = vim.lsp.buf.definition({ on_list = on_list })
     --        print(result)
					-- 	return result
					-- end, opts)
					-- require("telescope.builtin").lsp_definitions, lsp_references, lsp_implementations, lsp_type_definitions, lsp_docuemnt_symbols, lsp_dynamic_workspace_symbols,

					opts.desc = "Go to declaration"
					keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)

					opts.desc = "Show implentations"
					keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_type_definitions<CR>", opts)

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

					opts.desc = "Code action"
					keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			-- mason
			-- mason_lspconfig.setup_handlers({
			--   function(server_name)
			--     lspconfig[server_name].setup({capabilities = capablities, })
			--   end
			-- ["pylsp"] = function()
			-- lspconfig["pylsp"].setup({capabilites = capabilities, })
			-- end
			-- })

			-- start language servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				-- keybindings
				local opts = { noremap = true, silent = true }

				-- local opts = { buffer = ev.buf , remap=false}
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- signature on shift-k
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
				-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
				-- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
				-- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
				-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
				-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
				-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
				-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
				-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
				-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
				-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

				-- highlight
				-- if client.server_capabilities.documentHighlight then
				--   vim.api.nvim_exec(
				--     [[
				--     augroup lsp_document_highlight
				--       autocmd! * <buffer>
				--       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				--       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
				--     augroup END
				--   ]],
				--     false
				--   )
				-- end
			end
			-- pylsp
			vim.lsp.config("pylsp", {
				settings = {
					pylsp = {
						plugins = {
							-- pycodestyle = {
							-- 	maxLineLength = 80,
							-- },
							-- formatter options
							black = { enabled = false }, -- set in formatter
							autopep8 = { enabled = false }, -- set in formatter
							yapf = { enabled = false }, -- set in formatter
							-- linter options
							pylint = { enabled = false, executable = "pylint" }, -- set in linter
							pyflakes = { enabled = false }, -- set in linter
							pycodestyle = { enabled = false }, -- set in linter
							-- type checker
							pylsp_mypy = { enabled = false },
							-- auto-completion options
							jedi_completion = { fuzzy = true, enabled = true }, --
							-- import sorting
							pyls_isort = { enabled = false },
						},
					},
				},
				-- flags = {
				-- debounce_text_changes = 200,
				-- },
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
				-- on_attach = custom_attach,
			})
			-- lua ls
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			require("neodev").setup({})
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						-- workspace = {
						-- checkThirdParty = false,
						-- library = {
						-- "/usr/share/nvim/runtime/lua"
						-- vim.env.VIMRUNTIME,
						-- },
						-- },
					},
				},
			})
			-- clangd
			vim.lsp.config("clangd", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- java
			vim.lsp.config("jdtls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- json
			vim.lsp.config("jsonls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- shell, bash
			vim.lsp.config("bashls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- xml
			vim.lsp.config("lemminx", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- html
			vim.lsp.config("html", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- css
			vim.lsp.config("cssls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- typescript
			vim.lsp.config("ts_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- latex
			vim.lsp.config("ltex", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "latex" },
			})
      -- markdown
			vim.lsp.config("marksman", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "markdown" },
			})
      -- assembly
    --   lspconfig.asm_lsp.setup({
				-- on_attach = on_attach,
				-- capabilities = capabilities,
    --   })
			-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
			-- vim.api.nvim_create_autocmd('LspAttach', {
			-- group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			-- callback = function(ev)
			-- Buffer local mappings.
			-- local opts = { buffer = ev.buf , remap=false}
			-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- signature on shift-k
			-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
			-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
			-- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
			-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
			-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
			-- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
			-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
			-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
			-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

			-- end,
			-- })

			--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			--     border = "rounded",
			--   })

			--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			--     border = "rounded",
			--   })

			-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
			-- vim.lsp.handlers.hover, {
			-- Use a sharp border with `FloatBorder` highlights
			-- border = "single",
			-- add the title in hover float window
			-- title = "hover"
			-- }
			-- )
			-- local function skip_setup(name)
			--   if type(name) == 'string' then
			--     state.exclude[name] = true
			--   end
			-- end

			-- local function setup(name, opts)
			--   if type(name) ~= 'string' or state.exclude[name] then
			--     return false
			--   end

			--   if type(opts) ~= 'table' then
			--     opts = {}
			--   end

			--   skip_setup(name)

			--   local lsp = require('lspconfig')[name]

			--   if lsp.manager then
			--     return false
			--   end

			--   local ok = pcall(lsp.setup, opts)

			--   return true
			-- end

			-- local function default_setup(name)
			--     setup(name, {})
			-- end

			-- local function nvim_workspace(opts)
			--   local runtime_path = vim.split(package.path, ';')
			--   table.insert(runtime_path, 'lua/?.lua')
			--   table.insert(runtime_path, 'lua/?/init.lua')

			--   local config = {
			--     settings = {
			--       Lua = {
			--         -- Disable telemetry
			--         telemetry = {enable = false},
			--         runtime = {
			--           -- Tell the language server which version of Lua you're using
			--           -- (most likely LuaJIT in the case of Neovim)
			--           version = 'LuaJIT',
			--           path = runtime_path,
			--         },
			--         diagnostics = {
			--           -- Get the language server to recognize the `vim` global
			--           globals = {'vim'}
			--         },
			--         workspace = {
			--           checkThirdParty = false,
			--           library = {
			--             -- Make the server aware of Neovim runtime files
			--             vim.fn.expand('$VIMRUNTIME/lua'),
			--             vim.fn.stdpath('config') .. '/lua'
			--           }
			--         }
			--       }
			--     }
			--   }

			--   return vim.tbl_deep_extend('force', config, opts or {})
			-- end

			-- local function nvim_lua_ls(opts)
			--   return require('lsp-zero.server').nvim_workspace(opts)
			-- end
		end,
	},
}

return M

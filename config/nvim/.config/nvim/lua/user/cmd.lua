-- syntax
-- vim.cmd('syntax enable')

-- Remove trailing whitespace before writing the buffer to a file
vim.cmd([[
  augroup RemoveTrailingWhitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
  augroup END
]])

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight text on yank",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- auto hashbang
vim.api.nvim_create_autocmd("BufNewFile", {
	desc = "Hashbang on file enter",
	group = vim.api.nvim_create_augroup("hashbang_on_enter_python", { clear = true }),
	callback = function(opts)
		if vim.bo[opts.buf].filetype == "python" then
			vim.cmd("startinsert")
			vim.api.nvim_put({ "Hello" }, "", true, true)
			vim.api.nvim_notify("Hello msg")
			vim.fn.append(1, "")
			vim.fn.cursor(2, 0)
		end
	end,
})

-- auto hashbagn
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = { "*.py" },
	desc = "Hashbang on file enter",
	callback = function()
		-- local pos = vim.api.nvim_win_get_cursor(0)[2]
		-- local line = vim.api.nvim_get_current_line()
		-- local nline = line:sub(0, pos) .. "hello" .. line:sub(pos + 1)
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/usr/bin/env python", "# -*- coding: utf-8 -*-", "" })
		-- lua local luasnip = require('luasnip') -- get some snippet -- mind the filetype, you'll hardcode it or switch to FileType event local snip = luasnip.get_snippets(vim.bo.ft)[1] -- and expand it luasnip.snip_expand(snip)
	end,
})
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = { "*.sh" },
	desc = "Hashbang on file enter",
	callback = function()
		-- local pos = vim.api.nvim_win_get_cursor(0)[2]
		-- local line = vim.api.nvim_get_current_line()
		-- local nline = line:sub(0, pos) .. "hello" .. line:sub(pos + 1)
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/usr/bin/env sh", "# -*- coding: utf-8 -*-", "" })
		-- lua local luasnip = require('luasnip') -- get some snippet -- mind the filetype, you'll hardcode it or switch to FileType event local snip = luasnip.get_snippets(vim.bo.ft)[1] -- and expand it luasnip.snip_expand(snip)
	end,
})

-- treesitter
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local lang = vim.bo.filetype

        -- 1. Quick Exit for ignored types
        local ignore_ft = { "trouble", "qf", "help", "nogrit", "NvimTree", "cmp_menu" }
        if vim.tbl_contains(ignore_ft, lang) or lang == "" then
            return
        end

        -- 2. Validate the language name and parser availability
        -- We use pcall on get_lang to ensure Neovim recognizes the filetype as a TS lang
        local has_lang = pcall(vim.treesitter.language.add, lang)
        if not has_lang then
            return
        end

        -- 3. Final check: Can we actually create a parser?
        -- We wrap the start call itself in a pcall to prevent the error window
        pcall(vim.treesitter.start)
    end,
})

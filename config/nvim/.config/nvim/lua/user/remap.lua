---- Modes
----   normal_mode = "n",
----   insert_mode = "i",
----   visual_mode = "v",
----   visual_block_mode = "x",
----   term_mode = "t",
----   command_mode = "c",

-- alias for shorter calling
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- keymap("", "<Space>", "<Nop>", opts) -- space
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Define undo breakpoints for specific punctuation in insert mode
keymap("i", ",", ",<C-g>u", { noremap = true })
keymap("i", ".", ".<C-g>u", { noremap = true })
keymap("i", "!", "!<C-g>u", { noremap = true })
keymap("i", "?", "?<C-g>u", { noremap = true })

-- Clear search highlighting and refresh screen with Ctrl+S
opts.desc = "Clear search highlight."
keymap("n", "<C-s>", ":nohlsearch<CR><C-L>", opts)

-- keep cursor in the middle
opts.desc = "Next"
keymap("n", "n", "nzzzv", opts)
opts.desc = "Previous"
keymap("n", "N", "Nzzzv", opts)
opts.desc = "Down"
keymap("n", "<C-d>", "<C-d>zz", opts)
opts.desc = "Up"
keymap("n", "<C-u>", "<C-u>zz", opts)

-- open splits
opts.desc = "Vertical split."
keymap("n", "<leader>sv", "<C-w>v", opts) -- vertical split
opts.desc = "Horizontal split."
keymap("n", "<leader>sh", "<C-w>s", opts) -- horizontal split
opts.desc = "Make splits equal."
keymap("n", "<leader>se", "<C-w>=", opts) -- make split equal
opts.desc = "Close split."
keymap("n", "<leader>sx", "<cmd>close<CR>", opts) -- close

---- Better window/split navigation
opts.desc = "Go to split - left"
keymap("n", "<C-h>", "<C-w>h", opts)
opts.desc = "Go to split - down"
keymap("n", "<C-j>", "<C-w>j", opts)
opts.desc = "Go to split - up"
keymap("n", "<C-k>", "<C-w>k", opts)
opts.desc = "Go to split - right"
keymap("n", "<C-l>", "<C-w>l", opts)

---- Resize with arrows
opts.desc = "Horizontal resize - bigger"
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
opts.desc = "Horizontal resize - smaller"
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
opts.desc = "Vertical resize - bigger"
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
opts.desc = "Vertical resize - smaller."
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

---- Navigate buffers
opts.desc = "Go to next buffer."
keymap("n", "<A-l>", ":bnext<CR>", opts)
opts.desc = "Go to previous buffer."
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Navigate tabs
keymap("n", "<A-j>", ":tabnext<CR>", { noremap = true, desc = "Go to next tab."}) -- next tab
keymap("n", "<A-k>", ":tabprevious<CR>", { noremap = true, desc = "Go to previous tab." }) -- prev tab
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { noremap = true, desc = "Open new tab." }) -- new tab
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { noremap = true, desc = "Close tab." }) -- close tab
keymap("n", "<leader>tk", "<cmd>tabprevious<CR>", { noremap = true, desc = "Go to previous tab." }) -- previous tab
keymap("n", "<leader>tj", "<cmd>tabnext<CR>", { noremap = true, desc = "Go to next tab." }) -- next tab
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { noremap = true, desc = "Open current buffer in new tab." }) -- current buffer in new tab

-- leader - number --> switch to numbered tab
-- Function to switch to a specific tab or buffer
local function tab_buf_switch(index)
	if index <= vim.fn.tabpagenr("$") then
		vim.cmd("tabnext " .. index)
	else
		vim.cmd(index .. "b")
	end
end
-- Map leader + number keys to switch to a specific tab or buffer
for i = 1, 9 do
	keymap(
		"n",
		"<leader>" .. i,
		":lua tab_buf_switch(" .. i .. ")<CR>",
		{ noremap = true, desc = "Go to buffer " .. tostring(i) }
	)
end
-- Map leader + number keys to switch to a specific tab
for i = 1, 9 do
	keymap("n", "<leader>" .. i, i .. "gt", { noremap = true, desc = "Go to tab " .. tostring(i) })
end
-- last tab
keymap("n", "<leader>0", ":tablast<CR>", { noremap = true, desc = "Go to last tab." })

-- Folds
keymap("n", "<leader>mf", ":set foldmethod=marker<CR>", { noremap = true, desc = "Set foldmethod marker." })
keymap("n", "<leader>mi", ":set foldmethod=indent<CR>", { noremap = true, desc = "Set foldmethod indent." })

---- Move text up and down
keymap("n", "J", "mzJ'z", { noremap = true, desc = "Merge lines below." }) -- merge lines
keymap("n", "<leader>kk", ":m .-2<CR>==", { noremap = true, desc = "Swap line above." }) -- swap line above
keymap("n", "<leader>jj", ":m .+1<CR>==", { noremap = true, desc = "Swap line below." }) -- swap line below
opts.desc = ""
keymap("v", "<J>", ":move .+1<CR>==", opts) -- move block down
opts.desc = ""
keymap("v", "<K>", ":move .-2<CR>==", opts) -- move block up
opts.desc = ""
keymap("x", "<J>", ":move '>+1<CR>gv-gv", opts) -- move block down
opts.desc = ""
keymap("x", "<K>", ":move '<-2<CR>gv-gv", opts) -- move block up

---- Stay in visual mode while indenting
opts.desc = ""
keymap("v", "<", "<gv", opts)
opts.desc = ""
keymap("v", ">", ">gv", opts)

-- Yanking
-- keymap('v', '<C-y>', '"+y', { noremap = true }) -- Map Ctrl + y in visual mode to yank text to the system clipboard
opts.desc = ""
keymap("v", "p", '"_dP', opts)
-- vim.keymap.set("x", "<leader>p", "\"_dP") -- yank to void buffer

---- Terminal --
---- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Disable arrows
keymap("n", "<Left>", ':echoe "Use h"<CR>', { noremap = true })
keymap("n", "<Right>", ':echoe "Use l"<CR>', { noremap = true })
keymap("n", "<Up>", ':echoe "Use k"<CR>', { noremap = true })
keymap("n", "<Down>", ':echoe "Use j"<CR>', { noremap = true })

---- Insert --
---- Press jk fast to enter
--keymap("i", "jk", "<ESC>", opts)

-- Command line mode
keymap("c", "<C-a>", "<C-e>", { noremap = true })

-- spell check
-- local function toggle_spellcheck()
--     vim.wo.spell = not vim.wo.spell -- Toggle spellcheck for the current window
--     if vim.wo.spell then
--         vim.wo.spelllang = 'en_us' -- Set spellcheck language if spellcheck is enabled
--     end
-- end
-- keymap('n', '<F7>', ':lua toggle_spellcheck()<CR>', { noremap = true })

-- file open
-- urlview
-- vim.api.nvim_set_keymap('n', '<leader>u', ':w<Home>silent <End> !urlview<CR>', { noremap = true })

-- Open files
-- csv opener, first field
-- vim.api.nvim_set_keymap('n', '<leader>f', [[:exec '!nsxiv "$(echo ' .. vim.fn.shellescape(vim.fn.getline('.')) .. ' \| cut -d, -f1)" 2>/dev/null' <CR><CR>]], { noremap = true })
-- whole line in feh
-- vim.api.nvim_set_keymap('n', '<leader>pl', [[:exec '!nsxiv ' .. vim.fn.shellescape(vim.fn.getline('.'))) <CR><CR>]], { noremap = true })
-- word in feh
--- vim.api.nvim_set_keymap('n', '<leader>pw', [[:exec '!nsxiv ' .. vim.fn.shellescape(vim.fn.expand('<cWORD>'))) <CR><CR>]], { noremap = true })
-- line in mpv
-- vim.api.nvim_set_keymap('n', '<leader>ml', [[:exec '!mpv ' .. vim.fn.shellescape(vim.fn.getline('.'))) <CR><CR>]], { noremap = true })
-- word in mpv
-- vim.api.nvim_set_keymap('n', '<leader>mw', [[:exec '!mpv ' .. vim.fn.shellescape(vim.fn.expand('<cWORD>'))) <CR><CR>]], { noremap = true })
-- line in zat
-- vim.api.nvim_set_keymap('n', '<leader>za', [[:exec '!zathura ' .. vim.fn.shellescape(vim.fn.getline('.'))) <CR><CR>]], { noremap = true })
-- echo line
-- vim.api.nvim_set_keymap('n', '<leader>me', [[:exec '.!echo ' .. vim.fn.shellescape(vim.fn.getline('.')) .. '&& youtube-dl --skip-download --get-title -- ' .. vim.fn.shellescape(vim.fn.getline('.'))) <CR><CR>J]], { noremap = true })

-- format json
-- vim.api.nvim_set_keymap('n', '<leader>q', ':!jq .<CR>', { noremap = true })

-- run whole file
keymap("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

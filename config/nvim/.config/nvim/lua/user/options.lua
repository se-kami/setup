-- -- set options -- :help options
vim.opt.encoding = "utf-8"                      -- encoding
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.scriptencoding = "utf-8"                    -- script encoding
vim.opt.fileformat = 'unix'                     -- file format
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = true                      -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- space in the neovim command line for displaying messages
vim.opt.completeopt = { "menu", "preview" }     -- completion menu
vim.opt.title = false                           -- title
vim.opt.conceallevel = 2                        -- conceal
vim.opt.fsync = true                            -- write changes to disk, otherwise on system crash files are empty
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.incsearch = true                        -- search preview
vim.opt.inccommand = "nosplit"                  -- command preview
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 15                          -- pop up menu height
vim.opt.showmode = true                         -- show mode
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case (search)
vim.opt.autoindent = true                       -- auto indent
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.splitkeep = "cursor"                    -- keep cursor position on split
vim.opt.swapfile = true                         -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation (>> <<)
vim.opt.tabstop = 4                             -- insert 4 spaces for a tab (<Tab>)
vim.opt.smarttab = true                         -- smart tab
vim.opt.breakindent = false                     -- wrapped line will continue visually indented
vim.opt.softtabstop = 4                         -- soft tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.cursorcolumn = false                    -- highlight the current column
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 4
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 5                           -- show lines vertically when scrolling
vim.opt.sidescrolloff = 5                       -- show columns horizontallly when scrolling
vim.opt.visualbell = true                       -- visual bell instead of beep
vim.opt.hidden = true                           -- enable hidden - reuse windows
vim.opt.confirm = true                          -- confirm instead of error on no write
vim.opt.startofline = false                     -- disable startofline option
vim.opt.backspace = 'indent,eol,start'          -- Allow backspacing over autoindent, line breaks and start of insert action
vim.opt.wildmenu = true                         -- Enables a better completion menu
vim.opt.omnifunc = 'syntaxcomplete#Complete'    -- Sets omnifunc for syntax-based completion
vim.opt.autoindent = true                       -- Enable auto-indentation
vim.opt.ruler = true                            -- Enable the 'ruler' option
vim.opt.showcmd = true                          -- Enable the 'showcmd' option
vim.opt.laststatus = 2                          -- Always display the status line, even if only one window is displayed
vim.opt.shell = "zsh"                           -- shell

-- shortmess
vim.opt.shortmess = 'Il'   -- I - no intro, l - BL instead of bytes, lines

-- keywords
vim.cmd [[set iskeyword-=-]]                    -- treat abc-abc as one word
vim.cmd [[set iskeyword-=_]]                    -- treat abc_abc as two words

-- colors
if vim.fn.has("termguicolors") == 1 then
    vim.opt.termguicolors = true  -- Enables true color support in the terminal if available
end

-- netrw
vim.cmd("let g:netrw_liststyle = 3")

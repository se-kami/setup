-- Create the keymap: <leader>doc
vim.keymap.set('n', '<leader>com', function()
    require('codebot').run_sc_on_function()
end, { desc = "Run codebot on current function" })

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', "folke/todo-comments.nvim", },
  config = function()
    -- diagnostics
    -- local signs = {
    --   { name = "DiagnosticSignError", text = "" },
    --   { name = "DiagnosticSignWarn", text = "" },
    --   { name = "DiagnosticSignHint", text = "" },
    --   { name = "DiagnosticSignInfo", text = "" },
    -- }
    --- disable virtual text
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = false,
      float = { border = "single" },
      -- signs = {
      --   active = signs,
      -- },
      -- update_in_insert = true,
      -- underline = true,
      -- severity_sort = true,
      -- float = {
      --   focusable = false,
      --   style = "minimal",
      --   border = "rounded",
      --   source = "always",
      --   header = "",
      --   prefix = "",
      -- },
    })

    -- keybindings
    -- diagnostic all
    vim.api.nvim_set_keymap('n', '<leader>tt', ':Trouble diagnostics<CR>', { noremap = true, silent = true, desc = "Diagnostics toggle"})
    -- diagnostic line
    vim.api.nvim_set_keymap('n', '<leader>tl', '<Cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
      { noremap = true, silent = true, desc = "Diagnostics open float."})
    -- <cmd>TroubleToggle<CR>
    -- <cmd>TroubleToggle workspace_diagnostics<CR>
    -- <cmd>TroubleToggle document_diagnostics<CR>
    -- <cmd>TroubleToggle quickfix<CR>
    -- <cmd>TroubleToggle loclist<CR>
    -- <cmd>TodoTrouble<CR>

    -- trouble plugin
    require('trouble').setup({
      position = "bottom",
      auto_preview = false,
    })
  end
}

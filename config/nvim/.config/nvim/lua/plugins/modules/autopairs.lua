-- writing - auto pairs
return {
  "windwp/nvim-autopairs",
  event = {"InsertEnter"},
  config = function()
    require('nvim-autopairs').setup({
      -- check_ts = true,
      -- ts_config = {
      --   lua = {"string"},
      --   javascript = {"template_string"},
      --   java = false,
      -- },
      disable_filetype = { "TelescopePrompt", "vim" },
      disable_in_macro = true,
      disable_in_replace_mode = true,
    })
    -- completion with auto pairs
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
    -- toggle auto pairs
    toggle_autopairs = function()
      local ok, autopairs = pcall(require, "nvim-autopairs")
      if ok then
        if autopairs.state.disabled then
          autopairs.enable()
          print("Autopairs enabled")
        else
          autopairs.disable()
          print("Autopairs disabled")
        end
      else
        print("Autopairs not available")
      end
    end
    vim.api.nvim_set_keymap('n', '<leader>a', ':lua toggle_autopairs()<CR>', { noremap = true, silent = true })
  end
}

-- writing - comments
local M = {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile", },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring', },
  config = function()
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring")
    local ts_context_commentstring_integration = require("ts_context_commentstring.integrations.comment_nvim")

    comment.setup({
      pre_hook = ts_context_commentstring_integration.create_pre_hook(),
    })
    ts_context_commentstring.setup({
      enable_autocmd = false,
    })
    vim.g.skip_ts_context_commentstring_module = true -- speedup
  end
}

return M

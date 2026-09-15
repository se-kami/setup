local M = {
  "gbprod/substitute.nvim",
  event = {"BufReadPre", "BufNewFile"},
  config = function()
    local subs = require("substitute")
    subs.setup()
    local keymap = vim.keymap
    keymap.set("n", "s", substitute.operator) -- motion
    keymap.set("n", "ss", substitute.line) -- line
    keymap.set("n", "S", substitute.eol) -- eol
    keymap.set("x", "s", substitute.visual) -- visual
  end
}
return {}

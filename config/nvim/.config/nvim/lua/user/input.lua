local function HebrewToggle()
  if not vim.b.hebrew_mode_enabled then
    vim.opt_local.keymap   = "hebrew"
    vim.opt_local.iminsert = 1
    vim.opt_local.imsearch = 1
    vim.opt_local.rightleft = true
    vim.b.hebrew_mode_enabled = true
    vim.notify("Hebrew mode: ON")
  else
    vim.opt_local.keymap   = ""
    vim.opt_local.iminsert = 0
    vim.opt_local.imsearch = 0
    vim.opt_local.rightleft = false
    vim.b.hebrew_mode_enabled = false
    vim.notify("Hebrew mode: OFF")
  end
end

vim.api.nvim_create_user_command("HebrewToggle", HebrewToggle, {})
vim.keymap.set("n", "<leader>hb", function() vim.cmd.HebrewToggle() end,
  { silent = true, desc = "Toggle Hebrew mode (RTL/LTR)" })

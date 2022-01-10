local colorscheme = "gruvbox"

vim.o.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"
vim.g.airline_theme = 'dark'
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end


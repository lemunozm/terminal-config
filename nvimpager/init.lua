-- nvimpager configuration
-- Use catppuccin mocha theme from Neovim's lazy.nvim plugins

-- Disable less-like keybindings, use normal vim cursor movement
nvimpager.maps = false

-- Add catppuccin from lazy.nvim plugins to runtimepath
vim.opt.rtp:prepend(vim.fn.expand("~/.local/share/nvim/lazy/catppuccin"))

-- Setup catppuccin with same settings as main nvim config
require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    mocha = {
      base = "#000000"
    }
  }
})

vim.cmd.colorscheme("catppuccin")

-- Diff colors - more intense green/red
vim.api.nvim_set_hl(0, "diffSubname", { fg = "#8be9fd" })
vim.api.nvim_set_hl(0, "diffAdded", { fg = "#50fa7b" })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = "#ff5555" })
vim.api.nvim_set_hl(0, "diffChanged", { fg = "#f1fa8c" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#ff5555" })
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#50fa7b" })
vim.api.nvim_set_hl(0, "Removed", { fg = "#ff5555" })
vim.api.nvim_set_hl(0, "Added", { fg = "#50fa7b" })

vim.opt.number = false
vim.opt.signcolumn = "no"
vim.opt.termguicolors = true

-- Clipboard settings
vim.opt.clipboard = "unnamedplus"  -- Always use system clipboard
vim.g.mapleader = " "
vim.keymap.set("v", "y", '"+y')    -- Visual yank goes to clipboard
vim.keymap.set("n", "Y", '"+yy')   -- Yank line to clipboard
vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })

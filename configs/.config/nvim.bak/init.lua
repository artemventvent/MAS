-- Включаем номера строк
vim.o.number = true
vim.o.relativenumber = true

-- Отступы
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- Поиск
vim.o.ignorecase = true
vim.o.smartcase = true

-- Копирование в системный буфер
vim.o.clipboard = "unnamedplus"

-- Лидеры
vim.g.mapleader = " "

-- Плагины через lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "nvim-tree/nvim-tree.lua",
    "nvim-lualine/lualine.nvim",
})

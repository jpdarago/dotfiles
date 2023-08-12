vim.cmd 'packadd packer.nvim'

local packer = require 'packer'

function map_key(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'Lokaltog/vim-easymotion'
  use 'anott03/nvim-lspinstall'
  use 'jremmen/vim-ripgrep'
  use 'luukvbaal/nnn.nvim'
  use 'machakann/vim-highlightedyank'
  use 'ms-jpq/coq_nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/popup.nvim'
  use 'ray-x/go.nvim'
  use 'scrooloose/nerdcommenter'
  use 'sheerun/vim-polyglot'
  use 'simrat39/rust-tools.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use {'metalelf0/jellybeans-nvim', requires = {{'rktjmp/lush.nvim'}}}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'}
  use {'nvim-telescope/telescope.nvim', tag = '0.1.2', requires = {{'nvim-lua/plenary.nvim'}} }
  use {'nvim-treesitter/nvim-treesitter'}

  local configs = require 'nvim-treesitter.configs'
  configs.setup {
    ensure_installed = {"c", "cpp", "rust"},
    highlight = {
      enable = true,
    }
  }

  vim.o.autoread = true
  vim.o.expandtab = true
  vim.o.hidden = true
  vim.o.incsearch = true
  vim.o.scrolloff = 1000
  vim.o.shiftwidth = 2
  vim.o.showmode = false
  vim.o.smartcase = true
  vim.o.smarttab = true
  vim.o.softtabstop = 2
  vim.o.syntax = 'on'
  vim.o.tabstop = 2
  vim.o.termguicolors = true
  vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
  vim.o.undofile = true
  vim.o.undolevels=1000
  vim.o.undoreload=10000

  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.signcolumn = 'yes'
  vim.wo.wrap = false

  vim.bo.autoindent = true
  vim.bo.smartindent = true
  vim.bo.swapfile = false

  vim.g.mapleader = ','

  vim.cmd [[
    colorscheme jellybeans-nvim

    highlight ColorColumn ctermbg=darkgrey
    call matchadd('ColorColumn', '\%81v', 100)
  ]]

  map_key('', '<leader>f', ':lua require"telescope.builtin".find_files()<CR>')
  map_key('', '<leader>s', ':lua require"telescope.builtin".live_grep()<CR>')
  map_key('', '<leader>b', ':lua require"telescope.builtin".buffers()<CR>')
end)


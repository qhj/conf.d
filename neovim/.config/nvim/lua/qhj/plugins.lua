local fn, packer_bootstrap = vim.fn, nil
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print 'Installing packer ...'
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.cmd [[call feedkeys(':', 'nx')]]
  print 'Packer installed'
  vim.cmd [[packadd packer.nvim]]
end

local ok, packer = pcall(require, 'packer')
if not ok then
  return
end


packer.init {
  compile_path = require('packer.util').join_paths(vim.fn.stdpath('data'), 'site', 'plugin', 'packer_compiled.lua'),
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
}

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use {
    'catppuccin/nvim', as = 'catppuccin',
    config = function() vim.cmd [[colorscheme catppuccin]] end
  }

  -- completion
  use 'hrsh7th/nvim-cmp'

  -- LSP configurations
  use 'neovim/nvim-lspconfig'

  -- snippet engine
  use { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' }

  -- completion sources
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }

  -- snippets
  use {
    "rafamadriz/friendly-snippets",
    after = 'LuaSnip',
    config = [[require 'qhj.cmp']]
  }

  -- JSON Schema Store
  use { 'b0o/schemastore.nvim', after = 'cmp-nvim-lsp', config = [[require 'qhj.lsp']] }

  -- tree sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- auto pairs
  use { 'windwp/nvim-autopairs', after = 'nvim-cmp', config = [[require'qhj.autopairs']] }

  -- comment
  use { 'numToStr/Comment.nvim', after = 'nvim-treesitter' }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'Comment.nvim',
    config = function ()
      require('qhj.tree-sitter')
      require('qhj.comment')
    end
  }

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = [[require('qhj.nvim-tree')]],
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = [[require('gitsigns').setup()]]
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require("bufferline").setup{}]]
  }

  use { 'jose-elias-alvarez/null-ls.nvim', config = [[require('qhj.null-ls')]] }

  -- notify
  use 'rcarriga/nvim-notify'

  if packer_bootstrap then
    require('packer').sync()
  end
end)


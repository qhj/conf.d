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

return packer.startup(function()
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      vim.cmd [[
        colorscheme catppuccin
      ]]
    end
  }

  -- completion
  use { 'hrsh7th/nvim-cmp', event = { 'InsertEnter *', 'CmdlineEnter *'} }

  -- snippet engine
  use { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' }

  -- completion sources
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
  use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }

  -- snippets
  use {
    "rafamadriz/friendly-snippets",
    after = 'LuaSnip',
    config = [[require 'config.cmp']]
  }

  use 'rcarriga/nvim-notify'


  if packer_bootstrap then
    require('packer').sync()
  end
end)


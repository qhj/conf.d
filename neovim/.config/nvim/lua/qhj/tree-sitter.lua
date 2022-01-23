require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'lua',
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'json',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}


execute 'source ' . stdpath('config') . '/general.vim'
if !exists('g:vscode')
  execute 'source ' . stdpath('config') . '/packages.vim'
  execute 'source ' . stdpath('config') . '/config.vim'
endif

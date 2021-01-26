set clipboard =unnamedplus
set ignorecase

inoremap jk <Esc>
inoremap kj <Esc>
xnoremap p "_dP
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
nnoremap K yyP
nnoremap J yyp

" fcitx5
let g:editing_input_method = 1

if system('fcitx5-remote') != 1
  call system('fcitx5-remote -t')
endif

augroup Fcitx-Switch
  autocmd!
  autocmd FocusGained * call NeovimFocusGained()
  autocmd InsertEnter * call EnterInsert()
  autocmd InsertLeave * call LeaveInsert()
augroup END

function NeovimFocusGained()
  if 1 != system('fcitx5-remote')
    call system('fcitx5-remote -t')
  endif
endfunction

function EnterInsert()
  if g:editing_input_method != system('fcitx5-remote')
    call system('fcitx5-remote -t')
  endif
endfunction

function LeaveInsert()
  let g:editing_input_method = system('fcitx5-remote')
  if 1 != system('fcitx5-remote')
    call system('fcitx5-remote -t')
  endif
endfunction

" General settings
set termguicolors
set number
set relativenumber
set list
set listchars +=space:•
set cursorline
let mapleader = "\<Space>"
let maplocalleader = ","
set mouse =a
set undofile
set shiftround
set splitbelow
set splitright
set clipboard =unnamedplus
xnoremap p "_dP
set ignorecase
set noshowmode

augroup TerminalStuff
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

colorscheme onedark


tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

tnoremap <M-h> <c-\><c-n><c-w>h
tnoremap <M-j> <c-\><c-n><c-w>j
tnoremap <M-k> <c-\><c-n><c-w>k
tnoremap <M-l> <c-\><c-n><c-w>l

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $

" Better tabbing
vnoremap > >gv
vnoremap < <gv


let g:markdown_fenced_languages = [
  \ 'vim',
  \ 'help'
  \]


lua require'colorizer'.setup()


let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 0
"let g:vimtex_quickfix_mode = 0
set conceallevel =1
let g:tex_conceal = 'abdmg'


" fcitx5
let g:editing_input_method = 1

if system('fcitx5-remote') != 1
  call system('fcitx5-remote -t')
endif

augroup Fcitx-Switch
  autocmd!
  autocmd InsertEnter * call EnterInsert()
  autocmd InsertLeave * call LeaveInsert()
augroup END

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


" Plugins

"" lightline
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }


let g:rnvimr_ex_enable = 1


"" startify
let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   Files']},
  \ { 'type': 'dir',       'header': ['   Current Directory ' . getcwd()]},
  \ { 'type': 'sessions',  'header': ['   Sessions']},
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']},
  \ ]

let g:startify_bookmarks = [
  \ '~/.config/nvim/init.vim',
  \ '~/home',
  \ ]

"" which key
call which_key#register('<Space>', "g:which_key_map")

"" Map leader to which_key
nnoremap <silent> <Leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :<C-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}
let g:which_key_sep = '->'
let g:which_key_use_floating_win = 0

highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>
let g:which_key_map['/'] = 'comment'


let g:which_key_map.o = {
  \  'name': '+toggle',
  \  'e': [':CocCommand explorer', 'explorer']
  \}

let g:which_key_map.e = {
  \  'name': '+edit',
  \  'u': ['U'                 , 'upper case'],
  \}

let g:which_key_map.b = {
  \  'name': '+buffer',
  \  'w': [':w'            , 'write to file'],
  \  'n': [':bnext'        , 'next buffer'],
  \  'p': [':bprevious'    , 'previous buffer'],
  \}

let g:which_key_map.w = {
  \  'name': '+windows',
  \  'q': [':q'              , 'quit window'],
  \  'w': ['<C-w>w'          , 'next window'],
  \  'c': ['<C-w>c'          , 'close window'],
  \  's': ['<C-w>s'          , 'split window below'],
  \  'v': ['<C-w>v'          , 'split window right'],
  \  'h': ['<C-w>h'          , 'window left'],
  \  'j': ['<C-w>j'          , 'window below'],
  \  'k': ['<C-w>k'          , 'window above'],
  \  'l': ['<C-w>l'          , 'window right'],
  \  'H': ['<C-w>5<'         , 'decrease width'],
  \  'J': [':resize -5'      , 'decrease height'],
  \  'K': [':resize +5'      , 'increase height'],
  \  'L': ['<C-w>5>'         , 'increase width'],
  \  '=': ['<C-w>='          , 'equal size'],
  \  '?': [':Windows'        , 'search windows'],
  \}


let g:which_key_map.t = {
  \ 'name' : '+terminal' ,
  \ ';' : [':FloatermNew --wintype=popup --height=6'        , 'terminal'],
  \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
  \ 'n' : [':FloatermNew node'                              , 'node'],
  \ 'p' : [':FloatermNew python'                            , 'python'],
  \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
  \ 't' : [':FloatermToggle'                                , 'toggle'],
  \ }

" s is for search
let g:which_key_map.s = {
  \ 'name' : '+search' ,
  \ '/' : [':History/'     , 'history'],
  \ ';' : [':Commands'     , 'commands'],
  \ 'a' : [':Ag'           , 'text Ag'],
  \ 'b' : [':BLines'       , 'current buffer'],
  \ 'B' : [':Buffers'      , 'open buffers'],
  \ 'c' : [':Commits'      , 'commits'],
  \ 'C' : [':BCommits'     , 'buffer commits'],
  \ 'f' : [':Files'        , 'files'],
  \ 'g' : [':GFiles'       , 'git files'],
  \ 'G' : [':GFiles?'      , 'modified git files'],
  \ 'h' : [':History'      , 'file history'],
  \ 'H' : [':History:'     , 'command history'],
  \ 'l' : [':Lines'        , 'lines'] ,
  \ 'n' : [':noh'          , 'pause highlight search'],
  \ 'm' : [':Marks'        , 'marks'] ,
  \ 'M' : [':Maps'         , 'normal maps'] ,
  \ 'p' : [':Helptags'     , 'help tags'] ,
  \ 'P' : [':Tags'         , 'project tags'],
  \ 's' : [':Snippets'     , 'snippets'],
  \ 'S' : [':Colors'       , 'color schemes'],
  \ 't' : [':Rg'           , 'text Rg'],
  \ 'T' : [':BTags'        , 'buffer tags'],
  \ 'w' : [':Windows'      , 'search windows'],
  \ 'y' : [':Filetypes'    , 'file types'],
  \ 'z' : [':FZF'          , 'FZF'],
  \ }

"" Floaterm
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

let g:floaterm_gitcommit  = 'floaterm'
let g:floaterm_autoinsert = 1
let g:floaterm_width      = 0.8
let g:floaterm_height     = 0.8
let g:floaterm_wintitle   = 0
let g:floaterm_autoclose  = 1


"" coc

let g:coc_global_extensions = []
let g:coc_global_extensions += ['coc-vimlsp']
let g:coc_global_extensions += ['coc-emmet']
let g:coc_global_extensions += ['coc-tsserver']
let g:coc_global_extensions += ['coc-omnisharp']
let g:coc_global_extensions += ['coc-json']
let g:coc_global_extensions += ['coc-flutter']
let g:coc_global_extensions += ['coc-html']
let g:coc_global_extensions += ['coc-explorer']
let g:coc_global_extensions += ['coc-snippets']
let g:coc_global_extensions += ['coc-texlab']

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


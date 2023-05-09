
"=================================================
"                    PLUGINS
"=================================================
call plug#begin(stdpath('data') . '/plugged') " Plugins stored in ~/.local/share/nvim/plugged

" Visual plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'guns/xterm-color-table.vim'
"Plug 'mhinz/vim-signify' It's cool but... really I need it?

" IDE plugins
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Adds utilities for fzf in vim
Plug 'zefei/vim-wintabs'
Plug 'godlygeek/tabular' "required for vim-markdown
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/coc-flutter', {'do': 'npm install'}

" Syntax language support
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'aklt/plantuml-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'pboettch/vim-cmake-syntax'
Plug 'rust-lang/rust.vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'dart-lang/dart-vim-plugin'
Plug 'neovimhaskell/haskell-vim'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } "python
Plug 'LnL7/vim-nix'
Plug 'purescript-contrib/purescript-vim'
Plug 'vmchale/dhall-vim'

" Utilities
Plug 'mattn/webapi-vim' "Used by :RustPlay
Plug 'tyru/open-browser.vim' "Used by :PlantumlOpen
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'weirongxu/plantuml-previewer.vim'

" Initialize plugin system
call plug#end()

"=================================================
"                 GENENAL CONFIG
"=================================================
" Sets
set number                        "Show the line numbers
set signcolumn=auto:2             "Show two kind of symbols per line
"set relativenumber                "Show relative numbers in the line number side.
set expandtab                     "Convert tab to space
set tabstop=4                     "Number of space write by a tab
set shiftwidth=4                  "Number of identation spaces (automatic identantion read this)
set autoread                      "Refresh files that havent been edited by vim
set hidden                        "Allows open tabs without safe the current one.
set noswapfile                    "No generate swap files
set nobackup
set nowritebackup
set updatetime=50                 "Time to apply async operations
set cmdheight=1                   "Space to displaying messages
set shortmess+=c                  "Don't give ins-completion-menu messages
set hlsearch                      "Highlight the search

" User 'rg' as grep program: https://github.com/BurntSushi/ripgrep/
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m

" Highlight the language syntax
syntax on
colo lemunozm

" Remove all whitespaces after save
autocmd BufWritePre * :%s/\s\+$//e

"Leader key as space
let mapleader = "\<space>"

" Remove mappings (force to use vim keys)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Esc shortcut (faster than Esc)
inoremap jj <ESC>

" Faster save
map <leader>w :w<CR>

" Faster clipboard copies
vmap <leader>y "+y
vmap <leader>d "+d
map <leader>p "+p
map <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Jump to the end after paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Faster jump to start and end of line
map H ^
map L $

" Swap buffer"
nnoremap <leader><leader> <C-^>

" Faster last command"
nnoremap <leader>r @:

" Disable the highlighted search
nnoremap <silent>B :nohlsearch<Bar>:echo<CR>

" Helper to identify the highlight group under the cursor
map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" 2-size tab for other languages
autocmd FileType html,pug,javascript,css,sass,vue,html.handlebars,dart,yaml,json,haskell setlocal sw=2 ts=2

"=================================================
"                 PLUGIN CONFIG
"=================================================

"-------------------------------------------------
" # fzf
nnoremap <C-S> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore-dir target'   "Use ag instead of grep

" Search the current word and save it in the history
noremap <leader>s :let cmd = "Rg <C-R><C-W>" <bar> :call histadd("cmd", cmd) <bar> :execute cmd<CR>

" Search file (based of jonhoo's config)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

"-------------------------------------------------
" # vim-wintabs
map <C-H> <Plug>(wintabs_previous)
imap <C-H> <ESC><Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
imap <C-L> <ESC><Plug>(wintabs_next)
map <C-C> <Plug>(wintabs_close)
map <C-T> <Plug>(wintabs_undo)
map <C-N> <Plug>(wintabs_move_left)
map <C-M> <Plug>(wintabs_move_right)
map <leader>1 :WintabsGo 1<CR>
map <leader>2 :WintabsGo 2<CR>
map <leader>3 :WintabsGo 3<CR>
map <leader>4 :WintabsGo 4<CR>
map <leader>5 :WintabsGo 5<CR>
map <leader>6 :WintabsGo 6<CR>
map <leader>7 :WintabsGo 7<CR>
map <leader>8 :WintabsGo 8<CR>
map <leader>9 :WintabsGo 9<CR>
let g:wintabs_ui_sep_leftmost = ''
let g:wintabs_ui_sep_inbetween = ''
let g:wintabs_ui_sep_rightmost = ''

"-------------------------------------------------
" # intentLine
let g:indentLine_char = '┆'
let g:indentLine_color_term = 234

"-------------------------------------------------
" # vim-json
let g:vim_json_syntax_conceal = 0   "Disable conceal for json

"-------------------------------------------------
" # vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"-------------------------------------------------
" # markdown-preview
let g:mkdp_auto_close = 0

"-------------------------------------------------
" # rust.vim
let g:rustfmt_autosave = 1
let g:rustfmt_command = 'rustfmt --edition=2018'
autocmd Filetype rust map <F8> :RustTest <CR>

"-------------------------------------------------
" # semshi.vim
let g:semshi#mark_selected_nodes = 0

"-------------------------------------------------
" # coc.nvim

" Extensions
let g:coc_global_extensions = ['coc-json', 'coc-rust-analyzer', 'coc-cmake', 'coc-clangd']

" Disable fade out color
autocmd Filetype rust hi clear CocFadeOut

" Trigger completion and move down in the navigation
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Move up/down in the navigation
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Navigate diagnostic mappings
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-codelens-action)

" Find symbol of current document
nnoremap <silent> <leader>o :CocList outline<cr>

" Implement methods for trait
nnoremap <silent> <leader>i :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <leader>a :CocAction<cr>

" Auto fix
nmap <leader>f <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Mappings for scrolling the coc windows
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" .vimrc
" Updated September 9, 2023

" plug begin
call plug#begin('~/.vim/plugged')

" plugins
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'spengler5000/cosmic_latte'
Plug 'spengler5000/snow'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/vim-auto-save'
Plug 'vim-airline/vim-airline'

" plug end
call plug#end()

" plugin settings

" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '|'
let g:airline_section_z = '%3l %2v'
let g:airline_section_y = '%3p%%'
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tabs = 0

" autosave
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 0

" coc
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-go',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-tsserver',
\]
set updatetime=300
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
fun! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfun
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
fun! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfun
inoremap <silent> <expr> <C-j> coc#pum#visible()
  \ ? coc#pum#next(1) .. coc#pum#next(1) .. coc#pum#next(1) .. coc#pum#prev(1) .. coc#pum#prev(1) : coc#refresh()
inoremap <silent> <expr> <C-k> coc#pum#visible()
  \ ? coc#pum#prev(1) .. coc#pum#prev(1) .. coc#pum#prev(1) .. coc#pum#next(1) .. coc#pum#next(1) : coc#refresh()

" fzf
set rtp+=/usr/local/opt/fzf
let g:fzf_colors =
  \ {'fg': ['fg', 'Normal'],
  \ 'bg': ['bg', 'Normal'],
  \ 'hl': ['fg', 'Comment'],
  \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+': ['fg', 'Statement'],
  \ 'info': ['fg', 'PreProc'],
  \ 'border': ['fg', 'Ignore'],
  \ 'prompt': ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker': ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment'],
\}
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode noruler
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" markdown preview
let g:mkdp_browser = '/Applications/Google Chrome.app'
let g:mkdp_refresh_slow = 1
nmap <C-s> <Plug>MarkdownPreview

" nerdcommenter
nnoremap ' :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap ' :call nerdcommenter#Comment(0,"toggle")<CR>
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'

" nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let g:NERDTreeNodeDelimiter = "\u00a0"
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
  \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
fun NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfun

" general config
set nocompatible
set formatoptions=tcroql
set cb=unnamed
inoremap jj <Esc>
let mapleader = "\<Space>"
set guicursor=
set number
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set cindent
set smarttab
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrap
set noshowmode
set splitbelow
set splitright
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set hidden
set complete=
set autoread
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
filetype plugin on
au FocusGained,BufEnter * checktime" .vimrc
command! -bang Q q<bang>

" search
nnoremap , :noh<CR>
nnoremap <silent> <Esc><Esc> :let @/=''<CR>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>N

" clan up buffers
nnoremap <Leader>b :bufdo e<CR>
nnoremap <Leader>c :bufdo bwipeout<CR>
nnoremap <Leader>g :GitGutter<CR>
nnoremap <Leader>s :do Syntax<CR>

" file navigation, window management
nnoremap <Leader>1 :call NERDTreeToggleAndRefresh()<CR>
nnoremap <Leader>2 :FZF<CR>
nnoremap <Leader>3 :Ag<CR>
nnoremap <Leader>f <C-w>v
nnoremap <Leader>d <C-w>s
nnoremap <Leader>h <C-w>w
nnoremap <Leader>j :bnext<CR>
nnoremap <Leader>k :bprevious<CR>
nnoremap <Leader>l :bd<CR>

" colors, theme, font
if (has('termguicolors'))
  set termguicolors
endif
set guifont=Source\ Code\ Pro:h13
syntax on
let g:airline_theme='adaptive'
let g:go_highlight_trailing_whitespace_error = 0
" tweaks colors for dark snow theme
fun Dark()
  colorscheme snow
  set background=dark
  highlight VertSplit guifg=#363A3E guibg=#363A3E
  highlight LineNr guibg=#363A3E
  highlight StatusLine guifg=#363A3E guibg=#AFB7C0
  highlight WildMenu guifg=#759ABD
  highlight SignColumn guibg=#363A3E
  highlight CursorLineNr guifg=#759ABD guibg=#363A3E
  highlight CocErrorSign guifg=#BE868C guibg=#363A3E
  highlight CocWarningSign guifg=#AB916D guibg=#363A3E
  highlight CocInfoSign guifg=#AB916D guibg=#363A3E
  highlight CocHintSign guifg=#AB916D guibg=#363A3E
  highlight TabLineSel guifg=#363A3E guibg=#759ABD
  highlight Visual guifg=#759ABD guibg=#2C2D30 gui=none
endfun
fun Light()
  colorscheme cosmic_latte
  set background=light
  highlight VertSplit guifg=#EFE4D2 guibg=#EFE4D2
  highlight LineNr guibg=#EFE4D2
  highlight StatusLine guifg=#EFE4D2 guibg=#485A62
  highlight WildMenu guifg=#EFE4D2 guibg=#0075C9
  highlight SignColumn guibg=#EFE4D2
  highlight CursorLineNr guifg=#0075C9 guibg=#EFE4D2
  highlight CocErrorSign guifg=#FF0056 guibg=#EFE4D2
  highlight CocWarningSign guifg=#916D03 guibg=#EFE4D2
  highlight CocInfoSign guifg=#916D03 guibg=#EFE4D2
  highlight CocHintSign guifg=#916D03 guibg=#EFE4D2
  highlight TabLineSel guifg=#EFE4D2 guibg=#0075C9
  highlight Visual guibg=#0075C9 guifg=#FFF8E7 gui=none
endfun
" default to dark snow theme
call Dark()
" bindings to change theme
nnoremap <Leader>0 :call Dark()<CR>
nnoremap <Leader>9 :call Light()<CR>

" move selection up, down, left, right
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-h> <gv
vnoremap <C-l> >gv

" explorer settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:NetrwIsOpen = 0

" wrap lines in markdown and text files
augroup WrapLineInFile
  autocmd!
  autocmd FileType markdown,mkd,text setlocal wrap
augroup END

" trim all trailing whitespace (when exiting insert mode)
fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" better pasting on a Mac
if &term =~ "xterm.*"
  let &t_ti = &t_ti . "\e[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  fun XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfun
  map <expr> <Esc>[200~ XTermPasteBegin("i")
  imap <expr> <Esc>[200~ XTermPasteBegin("")
  vmap <expr> <Esc>[200~ XTermPasteBegin("c")
  cmap <Esc>[200~ <nop>
  cmap <Esc>[201~ <nop>
endif

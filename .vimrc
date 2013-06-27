" Make vim more useful
set nocompatible
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Enable line numbers
set number
" Text width
set tw=80
set nowrap
set fo-=t " don't wrap text while typing
" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
set softtabstop=2 
set shiftwidth=2 
set shiftround 
set expandtab 
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list
" Highlight searches
"set hlsearch
" Ignore case of searches
set ignorecase
set smartcase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Enable backspacing on indent,eol,start
set backspace=2
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting vim
set shortmess=atI
" Show the current mode
set showmode
" Don't show the filename in the window titlebar
set notitle
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
"if exists("&relativenumber")
"	set relativenumber
"	au BufReadPost * set relativenumber
"endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<cr>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<cr>

" Moving between windows and tabs
map <c-j> <c-w>j 
map <c-k> <c-w>k 
map <c-l> <c-w>l 
map <c-h> <c-w>h

" natural move around wrapped text
nnoremap j gj
nnoremap k gk

" switching buffers 
nmap <c-e> :e#<cr>
nnoremap :b :ls<cr>:b<space>

" toggle numbers and paste
nmap <Leader>l :setlocal number!<cr>
nmap <Leader>o :set paste!<cr>

" tab size
nmap <Leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<cr>
nmap <Leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<cr>
nmap <Leader>M :set noexpandtab tabstop=8 shiftwidth=8 softtabstop=4<cr>
nmap <Leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<cr>

" easier moving between tabs
map <Leader>n <esc>:tabprevious<cr>
map <Leader>m <esc>:tabnext<cr>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

" colors
syntax enable
set background=light
"let g:solarized_termtrans = 1
colorscheme hemisu_white
set colorcolumn=80
" force normal text color to white
"hi Normal ctermfg=White

" Setup Pathogen
call pathogen#infect()
let g:pathogen_disabled =['python-mode', 'vim-flake8']

" ctrlp
let g:ctrlp_max_height = 30
let g:ctrlp_map = '<C-b>'

" minibuffer
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapCTabSwitchBufs = 1

" Settings for python-mode
"map <Leader>g :call RopeGotoDefinition()<CR>
"let ropevim_enable_shortcuts = 1
"let g:pymode_rope_goto_def_newwin = 1
"let g:pymode_rope_extended_complete = 1
"let g:pymode_breakpoint = 0
"let g:pymode_syntax = 1
"let g:pymode_syntax_builtin_objs = 0
"let g:pymode_syntax_builtin_funcs = 0
" Disable pylint checking every save
"let g:pymode_lint_write = 0
"let g:pymode_lint_ignore = "E126"
"noremap <leader>pl :PyLint<cr>
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
let g:syntastic_python_checkers=['flake8']
let g:syntastic_quiet_warnings=1

set pastetoggle=<F2>
set completeopt=longest,menuone

" Settings for NERDTree
nmap <Leader>n :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.pyc$', '\.egg-info$', '^build$']
autocmd vimenter * if !argc() | NERDTree | endif

" Abbreviations
" current date-time stamp
iab <expr> idtc strftime("%b %d, %Y %H:%M:%S")
" date stamp
iab <expr> ids strftime("%Y/%m/%d")
" date-time stamp ISO8601 format
iab <expr> isod strftime("%FT%T%z")
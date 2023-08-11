"" Remove compatibility mode.
if &compatible
  set nocompatible
endif

"" Install Vim Plug if not available.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Vim Plug and plugins
call plug#begin('~/.vim/plugged')
Plug 'Lokaltog/vim-easymotion'
Plug 'chaoren/vim-wordmotion'
Plug 'esneider/vim-trailing'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-better-default'
Plug 'machakann/vim-highlightedyank'
Plug 'mcchrish/nnn.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nanotech/jellybeans.vim'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nkrkv/nvim-treesitter-rescript'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'prabirshrestha/async.vim'
Plug 'rescript-lang/vim-rescript'
Plug 'rhysd/vim-clang-format'
Plug 'rhysd/vim-grammarous'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'z0mbix/vim-shfmt'
call plug#end()

" Configuration
let mapleader = ","
let maplocalleader = ","

"" User interface
syntax enable
""" Keep the cursor in the middle of the window.
set scrolloff=1000
""" Set jellybeans as colorscheme.
colorscheme jellybeans

""" Highlight the current cursor line.
set cursorline
set showmatch
set number relativenumber

"" Highlight the 81st column so that we know if we are over the limit.
highlight ColorColumn ctermbg=darkgrey
call matchadd('ColorColumn', '\%81v', 100)

"" General Edition config
"" Set tabs to 4 spaces, expand them always.
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
""" Enable mouse.
set mouse=a
"" Keep closed buffers around when closing them.
set hidden
"" If file changed outside of NVIM, reread it.
set autoread
"" Do not update screen while running macros.
set lazyredraw
"" Do not create swap files.
set noswapfile
"" Keep cursor in same position.
set nostartofline
"" Encode with utf8
set encoding=utf8
"" Split to the right and below when creating splits.
set splitbelow splitright
"" Set automatic indentation of lines, use smart indentation when
"" creating new lines, and copy indentation of
set autoindent smartindent
"" Do not indent when unmatched parenthesis on previous line.
set cino+=(0
"" Set clipboard
set clipboard+=unnamedplus
"" suppress the annoying 'match x of y',
"" 'The only match' and 'Pattern not found' messages
set shortmess+=c
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"" Completion and search
"" Interpret regular expression characters on searches.
set magic
"" Do not expand wildcards on ignored files/folders.
set wildignore=.svn,.git,*.o,*~,*.swp,*.pyc,*.class,*.dSYM
"" Search lowercase words, except if the search has uppercase letters.
set ignorecase smartcase
"" Show incremental edits
set inccommand=nosplit

"" Backups
if exists("&backupdir")
    let backupdir = expand($HOME . "/.vim/backup")
    if !isdirectory(backupdir)
        call mkdir(backupdir,"p")
    endif
    let &backupdir=backupdir
    set backup
endif

"" Persistent undo
if has('persistent_undo')
    let undodir = expand($HOME . "/.vim/undo")
    if !isdirectory(undodir)
        call mkdir(undodir,"p")
    endif
    let &undodir=undodir
    set undofile
    "" Set very large undo levels.
    set undolevels=1000
    set undoreload=10000
endif

"" Commands and macros

"" Plugin configuration

""" coc.nvim
" Use <C-j> for trigger snippet expand.
imap <C-j> <Plug>(coc-snippets-expand)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

""" FZF
if has_key(plugs, 'fzf') && has_key(plugs, 'fzf.vim')
    nmap ;b :Buffers<CR>
    nmap ;f :Files<CR>
end

""" Build
nmap <leader>bb :make check<CR>

""" ClangFormat
au FileType c,cpp let g:clang_format#auto_format='1'

""" Conjure
let g:aniseed#env = v:true
let g:conjure#client#fennel#aniseed#aniseed_module_prefix = "aniseed."

""" Keep Markdown files at 80 characters.
au BufRead,BufNewFile *.md setlocal textwidth=80

""" Turn on plugins.
filetype plugin indent on

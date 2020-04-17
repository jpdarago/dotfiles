"" Remove compatibility mode.
if &compatible
  set nocompatible
endif

"" Vim Plug and plugins
call plug#begin('~/.vim/plugged')
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips'
Plug 'esneider/vim-trailing'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-operator-user'
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'mileszs/ack.vim'
Plug 'msteinert/vim-ragel'
Plug 'nanotech/jellybeans.vim'
Plug 'neomake/neomake'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-syntastic/syntastic'
Plug 'xavierd/clang_complete'
call plug#end()

" Configuration
let mapleader = ","

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

"" Completion and search
"" Interpret regular expression characters on searches.
set magic
"" Do not expand wildcards on ignored files/folders.
set wildignore=.svn,.git,*.o,*~,*.swp,*.pyc,*.class,*.dSYM
"" Search lowercase words, except if the search has uppercase letters.
set ignorecase smartcase

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

"" Autocommands

""" Restore cursor position on reopening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

"" Command configuration

""" FZF
if executable("rg")
    set grepprg=rg
    let g:ackprg = 'rg --vimgrep'
endif
let g:fzf_layout = { 'down': '~10%' }
nmap <leader>s :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>l :Lines<CR>

""" Ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-j>"

""" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_clang_tidy_post_args = ""
let g:syntastic_cpp_checkers = ['clang_tidy']

""" vim-ragel
let g:ragel_default_subtype = "cpp"

""" ClangFormat
autocmd FileType c,cpp,objc ClangFormatAutoEnable
let g:clang_format#command = "/usr/bin/clang-format-8"
let g:clang_format#style_options = {
            \ "IndentWidth" : 2,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

"" Typescript
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

"" Neomake
call neomake#configure#automake('rw', 1000)
let g:neomake_cpp_enabled_makers = ['clang++']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-std=c++17'],
   \ }
let g:neomake_typescript_enabled_makers = ['tslint']

""" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

"" clang_complete
let g:clang_library_path='/usr/lib/llvm-3.8/lib'

""" Terminal mode
tnoremap <Esc> <C-\><C-n>

""" Turn on plugins.
filetype plugin indent on

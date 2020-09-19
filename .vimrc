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
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips'
Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }
Plug 'dense-analysis/ale'
Plug 'esneider/vim-trailing'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-operator-user'
Plug 'leafgarland/typescript-vim'
Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'nanotech/jellybeans.vim'
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
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

"" Show incremental edits (NeoVim only)
if has('nvim')
    set inccommand=nosplit
end

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

""" Copy current filename.
nnoremap <C-f> :let @* = expand("%")<CR>

"" Autocommands

""" Restore cursor position on reopening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

"" Plugin configuration

""" FZF
if has_key(plugs, 'fzf') && has_key(plugs, 'fzf.vim')
    if executable("rg")
        set grepprg=rg
        let g:ackprg = 'rg --vimgrep'
    endif
    let g:fzf_layout = { 'down': '~10%' }

    nmap ; :Buffers<CR>
    nmap <leader>f :Files<CR>
    nmap <leader>l :Lines<CR>
end

""" Ultisnips
if has_key(plugs, 'ultisnips')
    let g:UltiSnipsExpandTrigger = "<c-j>"
    let g:UltiSnipsJumpForwardTrigger = "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<c-j>"
end

""" ClangFormat
if has_key(plugs, 'vim-clang-format')
    let g:clang_format#command = "clang-format"
    let g:clang_format#style_options = {
                \ "IndentWidth" : 2,
                \ "AllowShortIfStatementsOnASingleLine" : "true",
                \ "AlwaysBreakTemplateDeclarations" : "true",
                \ "Standard" : "C++11"}
end

""" Clangd
if executable('clangd') && has_key(plugs, 'vim-lsp')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
    augroup end
end

"" Typescript
if executable('prettier')
    autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
end

""" Deoplete
if has_key(plugs, 'deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
    call deoplete#custom#option({'enable_smart_case': 1})
end

""" Turn on plugins.
filetype plugin indent on

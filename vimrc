set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/a.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'xolox/vim-easytags'
Plugin 'nvie/vim-flake8'
Plugin 'xolox/vim-misc'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'DoxygenToolkit.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
Plugin 'mileszs/ack.vim'
Plugin 'embear/vim-localvimrc'
Plugin 'zah/nim.vim'

call vundle#end()

syntax on

" Spellcheck
set spell spelllang=en_us

" Enable mouse
set mouse=a

" Filetype-dependent settings
filetype plugin indent on

" General settings
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab autoindent
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch

" Custom leader key
let mapleader = "\\"

" Below gets rid of flash on error
set vb t_vb = ""

" Highlight matches
" set hlsearch

" Show trailing spaces
autocmd BufWinEnter * match ErrorMsg '\s\+$'

" Fix tabs for makefiles
autocmd FileType make setlocal noexpandtab

colorscheme evening

" 80 characters per line
set colorcolumn=81
hi ColorColumn ctermbg=1 guibg=Red

" Set working directory to directory of file
set autochdir

" Autocomplete behavior
set completeopt+=longest

" Completion should not search included files because takes too long
set complete-=i

" Wildcard behavior
set wildmode=longest,list
set wildmenu

" Doxygen settings
let g:DoxygenToolkit_authorName="Isaac Hier"

" vim-airline settings
set laststatus=2
let g:airline_detect_paste = 1  " Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1  " Show airline for tabs too

" NERDTree settings
nnoremap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_open_on_gui_startup = 0

" vim-easytags settings
" Where to look for tags files
set tags=.tags;,~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" a.vim
let g:alternateNoDefaultAlternate = 1

" EditorConfig settings
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" YouCompleteMe settings
let g:ycm_extra_conf_globlist = ['~/proj/*']

" ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" vim-localvimrc
let g:localvimrc_whitelist=['/home/ihier/proj', '/Users/isaachier/proj/']

" Tagbar settings
" Open/close tagbar with \b
nnoremap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 500kb
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 500
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif

" ~/.vimrc
" ------------------------------------- vim-plug ---------------------------------------

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation for GitHub; translates to https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/seoul256.vim.git'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Using a non-default branch
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Use 'dir' option to install plugin in a non-default directory
" Plug 'junegunn/fzf', { 'dir': '~/.fzf' }

" Post-update hook: run a shell command after installing or updating the plugin
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Post-update hook can be a lambda expression
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" If the vim plugin is in a subdirectory, use 'rtp' option to specify its path
" Plug 'nsf/gocode', { 'rtp': 'vim' }

" On-demand loading: loaded when the specified command is executed
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" On-demand loading: loaded when a file with a specific file type is opened
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

call plug#end()
" ---------------------------------------------------------------------------------------

set nocompatible " not vi compatible

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them



filetype plugin indent on " enable file type detection
set autoindent

"---------------------
" Basic editing config
"---------------------
set shortmess+=I " disable startup message
set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
set autochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
set mouse=
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
set nofoldenable " disable folding by default

"--------------------
" Misc configurations
"--------------------

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

" disable audible bell
set noerrorbells visualbell t_vb=

set splitbelow
set splitright

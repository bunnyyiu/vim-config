" Vundle Config
set nocompatible               " be iMproved
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'

" JavaScript support
Plugin 'pangloss/vim-javascript'
  let g:html_indent_inctags = "body,head,tbody,ul,li,p"
  "no indent on first line of script"
  let g:html_indent_script1 = "zero"
  "no indent on first line of style"
  let g:html_indent_style1 = "zero"
  au BufNewFile,BufRead *.json set filetype=javascript

" JST support
Plugin 'bunnyyiu/vim-jst'
  let g:indent_jst_block = 0
  au BufNewFile,BufRead *.ejs set filetype=jst

" Go lang support
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'

" Easy navigation
Plugin 'Lokaltog/vim-easymotion'
  let g:EasyMotion_leader_key = "<Leader>"
  let g:EasyMotion_do_mapping = 0 " Disable default mappings

  " Bi-directional find motion
  " Jump to anywhere you want with minimal keystrokes,
  " with just one key binding.
  " `s{char}{label}`
  nmap s <Plug>(easymotion-s)
  " or
  " `s{char}{char}{label}`
  " Need one more keystroke, but on average, it may be more comfortable.
  nmap s <Plug>(easymotion-s2)

  " Turn on case sensitive feature
  let g:EasyMotion_smartcase = 1

  " JK motions: Line motions
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)

" Write HTML faster
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Directory listing
Plugin 'scrooloose/nerdtree'
  "open NERDTree with Ctrl+n
  map <F3> :NERDTreeToggle<CR>
  "open a NERDTree automatically when vim starts up if no files were specified
  "autocmd vimenter * if !argc() | NERDTree | endif

" Groovy syntax
Plugin 'vim-scripts/groovy.vim'
  au BufReadPost Jenkinsfile* set syntax=groovy
  au BufReadPost Jenkinsfile* set filetype=groovy

" Syntax checking hacks for vim
Plugin 'vim-syntastic/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exec = 'eslint'

Plugin 'JamshedVesuna/vim-markdown-preview'
  let vim_markdown_preview_github=1

Plugin 'hashivim/vim-hashicorp-tools'

" For snippets"
" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'bunnyyiu/vim-kubernetes'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
  " Ctrl-P for fzf
  nnoremap <silent> <C-p> :Files<CR>
call plug#end()

" Shortcut
" F2 for toggle linenum
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

inoremap jk <esc>

" Highlight line over 120
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" Highlight line end with whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
2match ExtraWhitespace /\s\+$/

syntax enable                     " Turn on syntax highlighting.
filetype plugin on                " Turn on file type detection.
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set wrap                          " Turn on line wrapping.
set modeline                      " Allow per file config

set fileencodings=ucs-bom,utf-8,cp936,latin1
set ruler
set tabpagemax=50

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

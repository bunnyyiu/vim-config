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

Plugin 'pangloss/vim-javascript'
  let g:html_indent_inctags = "body,head,tbody,ul,li,p"
  "no indent on first line of script"
  let g:html_indent_script1 = "zero"
  "no indent on first line of style"
  let g:html_indent_style1 = "zero"
  au BufNewFile,BufRead *.json set filetype=javascript

Plugin 'bunnyyiu/vim-jst'
  let g:indent_jst_block = 0
  au BufNewFile,BufRead *.ejs set filetype=jst

Plugin 'walm/jshint.vim'
  " Enable error highlight
  let g:JSHintHighlightErrorLine = 1
  " Run JShint after file saved
  autocmd FileType javascript autocmd BufWritePost * JSHint

Plugin 'altercation/vim-colors-solarized'
  syntax enable
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif
  "load color scheme, slient if not found
  :silent! colorscheme solarized

Plugin 'fatih/vim-go'

Plugin 'Valloric/YouCompleteMe'

Plugin 'Lokaltog/vim-easymotion'
  let g:EasyMotion_leader_key = "<Leader>"
  let g:EasyMotion_do_mapping = 0 " Disable default mappings

  " Bi-directional find motion
  " Jump to anywhere you want with minimal keystrokes, with just one key binding.
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

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'scrooloose/nerdtree'
  "open NERDTree with Ctrl+n
  map <F3> :NERDTreeToggle<CR>
  "open a NERDTree automatically when vim starts up if no files were specified
  autocmd vimenter * if !argc() | NERDTree | endif

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

" Shortcut
" F2 for toggle linenum
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Highlight line over 80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Highlight line end wit whitespace
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
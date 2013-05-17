" Vundle Config
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'

Bundle 'Lokaltog/vim-easymotion'
  let g:EasyMotion_leader_key = "<Leader>"

Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

Bundle 'scrooloose/nerdtree'
  "open NERDTree with Ctrl+n
  map <F3> :NERDTreeToggle<CR>
  "open a NERDTree automatically when vim starts up if no files were specified
  autocmd vimenter * if !argc() | NERDTree | endif

Bundle 'pangloss/vim-javascript'
  let g:html_indent_inctags = "body,head,tbody,ul,li,p"
  "no indent on first line of script"
  let g:html_indent_script1 = "zero"
  "no indent on first line of style"
  let g:html_indent_style1 = "zero"
  au BufNewFile,BufRead *.json set filetype=javascript

Bundle 'bunnyyiu/vim-jst'
  let g:indent_jst_block = 0
  au BufNewFile,BufRead *.ejs set filetype=jst

Bundle 'walm/jshint.vim'
  " Enable error highlight
  let g:JSHintHighlightErrorLine = 1

Bundle 'majutsushi/tagbar'
  nmap <F8> :TagbarToggle<CR>
  let g:tagbar_type_javascript = {
  \ 'ctagsbin' : '~/.vim/doctorjs/bin/jsctags.js'
  \ }

  au BufNewFile,BufRead *.go set filetype=go
  let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : '.vim/gotags/bin/gotags',
  \ 'ctagsargs' : '-sort -silent'
  \ }

Bundle 'tpope/vim-surround'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" end Vundle config

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

au BufNewFile,BufRead *.json set filetype=javascript
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead Jenkinsfile* set syntax=groovy
au BufNewFile,BufRead Jenkinsfile* set filetype=groovy

" Plug Config
" Install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --system-libclang
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" Easy navigation
function! SetupEasyMotion()
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
endfunction
Plug 'Lokaltog/vim-easymotion'
call SetupEasyMotion()

" Write HTML faster
Plug 'rstacruz/sparkup', { 'rtp': 'vim/' }

" Directory listing
function! SetupNerdtree()
  "open NERDTree with Ctrl+n
  map <F3> :NERDTreeToggle<CR>
  "open a NERDTree automatically when vim starts up if no files were specified
  "autocmd vimenter * if !argc() | NERDTree | endif
endfunction
Plug 'scrooloose/nerdtree'
call SetupNerdtree()

" Groovy syntax
Plug 'vim-scripts/groovy.vim'

" Syntax checking hacks for vim
function! SetupSyntastic()
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exec = 'eslint'
endfunction
Plug 'vim-syntastic/syntastic'
call SetupSyntastic()

" Markdown Preview
function! SetupMarkdownPreview()
  let vim_markdown_preview_github=1
endfunction
Plug 'JamshedVesuna/vim-markdown-preview'
call SetupMarkdownPreview()

"Hashicorp Tools"
Plug 'hashivim/vim-hashicorp-tools'

" For snippets"
" Track the engine.
Plug 'SirVer/ultisnips'
function! SetupUltisnips()
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
endfunction
call SetupUltisnips()

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'bunnyyiu/vim-kubernetes'

"Fuzzy File Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
function! SetupFzf()
  " Ctrl-P for fzf
  nnoremap <silent> <C-p> :Files<CR>
endfunction
Plug 'junegunn/fzf.vim'
call SetupFzf()

" JavaScript support
function! SetupJavascript()
  let g:html_indent_inctags = "body,head,tbody,ul,li,p"
  "no indent on first line of script"
  let g:html_indent_script1 = "zero"
  "no indent on first line of style"
  let g:html_indent_style1 = "zero"
endfunction
Plug 'pangloss/vim-javascript'
call SetupJavascript()

" JST support
function! SetupJST()
  let g:indent_jst_block = 0
endfunction
Plug 'bunnyyiu/vim-jst'
call SetupJST()

" Go lang support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Groovy indent
Plug 'vim-scripts/groovyindent-unix'

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

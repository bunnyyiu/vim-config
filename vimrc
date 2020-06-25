set nocompatible

" Plug Config
" Install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

function! PlugLoaded(name)
  return (
      \ has_key(g:plugs, a:name) &&
      \ isdirectory(g:plugs[a:name].dir) &&
      \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall | q
endif

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    silent !brew install clang-format
    silent !git submodule update --init --recursive
    silent !python3 ./install.py --clang-completer --go-completer
}
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" Easy navigation
function! SetupEasyMotion(info)
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
Plug 'Lokaltog/vim-easymotion', { 'do': function('SetupEasyMotion') }

" Directory listing
function! SetupNerdtree(info)
  "open NERDTree with Ctrl+n
  map <F3> :NERDTreeToggle<CR>
  "open a NERDTree automatically when vim starts up if no files were specified
  "autocmd vimenter * if !argc() | NERDTree | endif
endfunction
Plug 'scrooloose/nerdtree', { 'do': function('SetupNerdtree') }

" Groovy syntax
Plug 'vim-scripts/groovy.vim'

" Syntax checking hacks for vim
function! SetupSyntastic(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    silent !npm install eslint -g
  endif
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
Plug 'vim-syntastic/syntastic', { 'do': function('SetupSyntastic') }

" Markdown Preview
function! SetupMarkdownPreview(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    silent !brew install grip
  endif
  let vim_markdown_preview_github=1
endfunction
Plug 'JamshedVesuna/vim-markdown-preview', { 'do': function('SetupMarkdownPreview') }

"Hashicorp Tools"
Plug 'hashivim/vim-hashicorp-tools'

" For snippets"
" Track the engine.
function! SetupUltisnips(info)
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
endfunction
Plug 'SirVer/ultisnips', { 'do': function('SetupUltisnips') }

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'bunnyyiu/vim-kubernetes'

"Fuzzy File Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
function! SetupFzf(info)
  " Ctrl-P for fzf
  nnoremap <silent> <C-p> :Files<CR>
endfunction
Plug 'junegunn/fzf.vim', { 'do': function('SetupFzf') }

" JavaScript support
function! SetupJavascript(info)
  let g:html_indent_inctags = "body,head,tbody,ul,li,p"
  "no indent on first line of script"
  let g:html_indent_script1 = "zero"
  "no indent on first line of style"
  let g:html_indent_style1 = "zero"
endfunction
Plug 'pangloss/vim-javascript', { 'do': function('SetupJavascript') }

" Go lang support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

function! InstallGodoctor(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    silent !go get -u github.com/godoctor/godoctor
  endif
endfunction
Plug 'godoctor/godoctor.vim', { 'do': function('InstallGodoctor') }

" Groovy indent
Plug 'vim-scripts/groovyindent-unix'

"Dockerfile support"
Plug 'ekalinin/Dockerfile.vim'

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
function! InstallGoogleJavaFormat(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    silent !mkdir -p ~/.vim/java
    silent !wget https://github.com/google/google-java-format/releases/download/google-java-format-1.7/google-java-format-1.7-all-deps.jar -O ~/.vim/java/google-java-format-1.7-all-deps.jar
  endif
endfunction
Plug 'google/vim-glaive', { 'do': function('InstallGoogleJavaFormat') }

call plug#end()

if PlugLoaded('vim-glaive')
  call glaive#Install()

  Glaive codefmt plugin[mappings]
  Glaive codefmt google_java_executable="java -jar ~/.vim/java/google-java-format-1.7-all-deps.jar"
endif

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd BufNewFile,BufRead Jenkinsfile* set syntax=groovy
  autocmd BufNewFile,BufRead Jenkinsfile* set filetype=groovy
augroup END

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

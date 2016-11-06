" vim:fdm=marker

" General issues solving {{{
" Intuitive backspacing in insert mode
" See: http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start
" }}}

" Editor features
" Set the path {{{
" See: http://vimdoc.sourceforge.net/htmldoc/options.html#'path'
" See: http://vim.wikia.com/wiki/Open_file_under_cursor
set path+=.,~/projects/Eclecticiq,,
" }}}

" File encoding TODO {{{
" unsure if I need those...
" See: http://stackoverflow.com/questions/9310274/how-can-i-use-vim-to-convert-my-file-to-utf8
set bomb
set encoding=utf-8
set fileencoding=utf-8
" }}}

" No backups TODO {{{
" TODO Am I sure I don't want backup?
" See: https://items.sjbach.com/319/configuring-vim-right to configure backup
set nobackup
set nowritebackup
" }}}

" Centralised folder for swp files {{{
" set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" See: https://items.sjbach.com/319/configuring-vim-right
let s:tmpdir = $HOME . "/.vim/tmp"
if exists("*mkdir")
  try
    call mkdir(s:tmpdir)
  catch
  endtry
endif
set directory=~/.vim/tmp,/var/tmp,/tmp
" }}}

" Persistent undo files {{{
" TODO where this flag is defined?
if has('persistent_undo')
  let s:undodir = $HOME . "/.vim/undo"
  if exists("*mkdir")
    try
      call mkdir(s:undodir)
    catch
    endtry
  endif
  execute "set undodir=" . s:undodir
  set undofile
endif
" }}}

" Clipboard as system clipboard TODO {{{
" Use system clipboard by default; the if is to support both X11 and the Mac
" @See http://ilessendata.blogspot.nl/2012/05/vim-using-system-clipboard.html
"if has('unnamedplus')
"  set clipboard=unnamedplus
"else
"  set clipboard=unnamed
"endif
" I had to comment the if above and set it manually due to a bug
" @See
" http://stackoverflow.com/questions/25684945/pasting-in-vim-on-tmux-returns-this-error-e353-nothing-in-register
" and
" https://github.com/vim/vim/issues/203
set clipboard=unnamed
" }}}

" Editor UI
" Mouse {{{
" @See http://usevim.com/2012/05/16/mouse/
" send more characters for redraws
set ttyfast
" enable mouse in all modes
set mouse=a
" set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2
" }}}

" Color scheme {{{
" Important: the colorscheme must be define before the match for the
"   ExtraWhitespace, otherwise the second will be overwritten
" Note: I am setting the background from the terminal, so "set background..."
"   that follows won't have effect
" See: "Visual improvements" sections
if !has("gui_running")
  let g:gruvbox_italic=0
endif
set t_Co=256 | set background=dark | colorscheme molokai

" just as note, another good colorscheme:
" set t_Co=256 | colorscheme xoria256
" }}}

" Visual improvements {{{
" background from terminal: handy if your terminal bg is transparent
" http://stackoverflow.com/questions/21572179/vim-color-scheme-overriding-the-background-settings-in-gnome-terminal
hi Normal ctermbg=none
" preloads configuration accordingly to the file type
filetype plugin indent on
" syntax highlight
syntax on
" set window title TODO not working on Macos Sierra
set title
" shows line numbers
set number                            " Show line numbers
" highlight line where the cursor is
set cursorline
" always shows status bar
set laststatus=2
" improved completition in command mode: it shows all the available options
" See https://items.sjbach.com/319/configuring-vim-right
set wildmenu
set wildmode=list:longest
" self explanatory!
set colorcolumn=80
hi ColorColumn guifg=red
" See http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" cool characters when use set list
set listchars=tab:>-,eol:<
" jump to the implementation of the method on which the cursor is.
" See plugin Tagbar in Vundle plugins
" set tags=/home/luca/.vim/tags/tags,/home/luca/.vim/tags/jstags
" set switchbuf=usetab
" }}}

" Tab and spaces {{{
" tab to spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
" }}}

" Search {{{
" highlight search
set hlsearch
" incremental search
set incsearch
" searches case-sensitive only if there is a capital letter in the search expression
" See https://items.sjbach.com/319/configuring-vim-right
set ignorecase
set smartcase
" clear search by ,/
" nmap <silent> ,/ :nohlsearch<CR>
" clean the last search by pressing <Enter>
" See: http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
nnoremap <CR> :noh<CR><CR>
" }}}

" Editor mappings
" Set Leader {{{
let mapleader=","
" }}}

" Generic mappings TODO {{{
" TODO investigate difference between noremap, nnoremap, etc...

cnoreabbrev Ack Ack!
nnoremap ! :!
" no more Ex mode: http://www.bestofvim.com/tip/leave-ex-mode-good/
" TODO what is Ex mode?!
nnoremap Q <nop>
nnoremap <Leader>a :Ack!<Space>
nmap <silent> <leader>s :set nolist!<CR>
" }}}
"
" Mappings for tab navigation TODO {{{
" This mappings allow me to use ctrl+h/j/k/l to move between windows {{{
" TODO move from <Ctrl> to <Leader>
nnoremap <C-h> <esc><C-w>h
nnoremap <C-j> <esc><C-w>j
nnoremap <C-k> <esc><C-w>k
nnoremap <C-l> <esc><C-w>l
inoremap <C-h> <esc><C-w>h
inoremap <C-j> <esc><C-w>j
inoremap <C-k> <esc><C-w>k
inoremap <C-l> <esc><C-w>l
inoremap <esc><C-h> <C-w>h
inoremap <esc><C-j> <C-w>j
inoremap <esc><C-k> <C-w>k
inoremap <esc><C-l> <C-w>l
" }}}

" go to tab by number
noremap <leader>l <esc>gt<CR>
noremap <leader>h <esc>gT<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" switch to the last active tab by pressing <Leader>tl
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" }}}

" Mappings for F keys {{{
" function to toggle quickfix window
" See: http://vim.1045645.n5.nabble.com/detecting-whether-the-quickfix-window-is-open-td1155292.html
function! s:qf_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction
command! QFtoggle call s:qf_toggle()

map <F1> :QFtoggle<CR>
map <F2> :NERDTreeTabsToggle<CR>
" }}}

" Editor Plugins TODO
" Important: Vundle end line needs to be the last in .vimrc
" Plugins configuration {{{
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_check_on_open=1
" let g:syntastic_enable_signs=1
" Startify is the open as default, if no files are passed
" TODO try to understand what is augroup and VimEnter and autocmd
augroup open_nerdtreetabs
  autocmd!
  " TODO dunno why this doesn't work :(
  " \ if !argc() |
  " \ Startify   |
  " \ else   |
  " \ NERDTreeTabsFind   |
  " \ endif
  autocmd VimEnter *
    \ if !argc() |
    \ Startify   |
    \ endif
augroup END
" TODO explore NERDTree configuration further
" See: https://github.com/jistr/vim-nerdtree-tabs#configuration
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=2
" TODO doesn't seem to work as expected
let g:nerdtree_tabs_autofind=1
let g:airline#extensions#hunks#enabled=0
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:gitgutter_sign_modified='~'
" }}}

" Bundle plugins {{{
set rtp+=~/.vim/bundle/Vundle.vim
set nocompatible
filetype off
call vundle#begin()
Bundle 'gmarik/vundle'

" show function list
" Bundle 'majutsushi/tagbar'

" syntax checker
"Bundle 'scrooloose/syntastic'

" grep integration in vim
" Bundle 'yegappan/grep'

" handy screen at the vim startup
Bundle 'mhinz/vim-startify'

" file browser
Bundle 'scrooloose/nerdtree'
" makes NerdTree work with tabs
Bundle 'jistr/vim-nerdtree-tabs'

" fancy bottom bar
Bundle 'bling/vim-airline'

" Ctrlp
Bundle 'ctrlpvim/ctrlp.vim'

" ack
Bundle 'mileszs/ack.vim'

" autocomplete
Bundle 'Valloric/YouCompleteMe'

" allow to use * with selected text in visual mode
Bundle 'thinca/vim-visualstar'

" shows a git diff in the 'gutter' (sign column)
Bundle 'airblade/vim-gitgutter'

" git functions for vim
Bundle 'tpope/vim-fugitive'

" Ctrlp for tabs!
Bundle 'DavidEGx/ctrlp-smarttabs'

call vundle#end()
filetype plugin indent on
" }}}

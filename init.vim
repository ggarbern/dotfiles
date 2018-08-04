" This vimrc has the following dependencies:
" brew install python3
" brew install neovim
" pip3 install neovim --upgrade
" brew install fzf
" brew install ripgrep
" brew install thefuck
" brew install tmux
" brew install reattach-to-user-namespace
" brew install fish
" brew install grc
" brew cask install font-hack-nerd-font
" brew cask install font-firacode-nerd-font
" fisher edc/bass omf/thefuck omf/bobthefish z
" fisherman
" custom config.fish
" custom .tmux.conf

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'christoomey/vim-tmux-navigator'
Plug 'dracula/vim'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'justinmk/vim-sneak'
Plug 'maximbaz/lightline-ale'
Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'scrooloose/nerdtree'
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'Shougo/deoplete.nvim', {
    \ 'do': ':UpdateRemotePlugins',
    \ 'for': ['c', 'cpp', 'haskell', 'rust']
    \ }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'

" Initialize plugin system
call plug#end()

set encoding=utf8
set nomodeline
set nowrap
" Except... on Markdown. That's good stuff.
augroup wrap_markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
augroup END
set undolevels=100
set clipboard=unnamed
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set conceallevel=1
set noerrorbells
set number
set hlsearch
set scrolloff=1
set sidescrolloff=5
set mouse=a
set signcolumn=yes
" clipboard.vim is on nvim's critical startup path--the below two lines
" drastically reduce load times
let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
set clipboard+=unnamedplus

if has("nvim") && $TERM_PROGRAM == "iTerm.app"
    if exists('$TMUX')
        let g:dracula_colorterm = 0
    endif
    set termguicolors
elseif $TERM_PROGRAM == "iTerm.app"
    set termguicolors
elseif $TERM_PROGRAM == "Apple_Terminal"
    " termguicolors doesn't work in Terminal.app as it doesn't support true colors
endif

" Syntax highlighting
syntax on
colorscheme dracula

" Set python3 hostpath for deoplete
let g:python3_host_prog = '/usr/local/bin/python3'

" Change leader key to space
let mapleader="\<SPACE>"

" Open the last file by pressing space 2x
nmap <Leader><Leader> <c-^>

" Switch between buffers
nnoremap <C-]> :bnext!<CR>
nnoremap <C-[> :bprev!<CR><Paste>

" Switch between panes
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" ==============================================================================
" Plugins
" ==============================================================================

" ALE
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠️'

" deoplete
" this can take awhile, so only load deoplete for certain filetypes
let g:deoplete#enable_at_startup = 1

" deoplete-rust
let g:deoplete#sources#rust#racer_binary='/Users/greg/.cargo/bin/racer'

" FZF settings
nnoremap <leader>f :Files<cr>
nnoremap <leader>p :Files<cr>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>b :Buffers<CR>

" Grepper
nnoremap <Leader>gr :GrepperRg<Space>

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_char = "⟩"

" LanguageServer settings
" Required for operations modifying multiple buffers like rename.
set hidden

augroup filetype_rust
    autocmd!
    autocmd BufReadPost *.rs setlocal filetype=rust
augroup END

let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls'],
    \ }
    " \ 'c': ['cquery', '--language-server', '--log-file=/tmp/cq.log'],
    " \ 'cpp': ['cquery', '--language-server', '--log-file=/tmp/cq.log'],
    " \ }

" " cquery settings
" let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
" let g:LanguageClient_settingsPath = '/Users/greg/.config/nvim/settings.json'
" set completefunc=LanguageClient#complete
" set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Lightline settings
set laststatus=2
set noshowmode
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline = {
\ 'colorscheme': 'Dracula',
\ 'active': {
\     'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
\     'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype'],
\              [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ] ],
\ },
\ 'component': {
\     'lineinfo': ' %3l:%-2v',
\ },
\ 'component_expand': {
\     'linter_checking': 'lightline#ale#checking',
\     'linter_warnings': 'lightline#ale#warnings',
\     'linter_errors': 'lightline#ale#errors',
\     'linter_ok': 'lightline#ale#ok'
\ },
\ 'component_function': {
\     'readonly': 'LightlineReadonly',
\     'fugitive': 'LightlineFugitive'
\ },
\ 'component_type': {
\     'linter_checking': 'left',
\     'linter_warnings': 'warning',
\     'linter_errors': 'error',
\     'linter_ok': 'left',
\ },
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' }
\ }
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

" NERDTree
augroup nerd_tree_close_if_last
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1

" neosnippets
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Rainbow Parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" List of colors that you do not want. ANSI code or #RRGGBB
" let g:rainbow#blacklist = [233, 234]
" Activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme,haskell RainbowParentheses
augroup END

augroup rainbow_c
  autocmd!
  autocmd FileType c,cpp,rust RainbowParentheses
augroup END

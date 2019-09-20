" Make Vim more useful. This should always be your first configuration line.
set nocompatible

" Misq Settings  ==================================================
syntax on
set nowrap
set ignorecase
set smartcase
set cursorline
set mouse=a
set foldmethod=indent
set nofoldenable

" allways diff vertically
set diffopt+=vertical
nnoremap du  :diffupdate<CR>

" indent
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

au FileType stylus setl sw=4 ts=4
au FileType cs setl sw=4 ts=4

" clipboard linux fix
set clipboard=unnamed
set clipboard=unnamedplus

" keep windows from resizing
set noea

" Plugin Management ==================================================
call plug#begin('~/.config/nvim/plugged')

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" LSP client, Language server protocol
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }

" asynchronous execution library for Vim, others depends on this
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" colorschemes
Plug 'rickisen/vim-gotham'

" Ultisnips
Plug 'SirVer/ultisnips'

" vim snippets
Plug 'honza/vim-snippets'

" vim-surround
Plug 'tpope/vim-surround'

" tcomments
Plug 'tomtom/tcomment_vim'

" neomake (like dispatch and syntastic)
Plug 'benekastah/neomake'

" react / jsx
Plug 'sheerun/vim-polyglot'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" to apply prettier on typescript
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

call plug#end()

" deoplete -------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 2
let g:deoplete#auto_complete_delay = 150
let deoplete#tag#cache_limit_size = 5000000

" priority of sources
call deoplete#custom#source('buffer', 'rank', 900)
call deoplete#custom#source('LanguageClient', 'rank', 800)
call deoplete#custom#source('ultisnips', 'rank', 700)
call deoplete#custom#source('go', 'rank', 600)
call deoplete#custom#source('fs', 'rank', 2)

" typescript/javascript -------------------------
" set filetypes as typescript.jsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx
let g:jsx_ext_required = 0
let g:javascript_opfirst = '^\s*\%(\%(\%(\/\*.\{-}\)\=\*\+\/\s*\)\=\)\@>\%([<>,?^%|*&]\|\([-/.+]\)\1\@!\|=>\@!\|in\%(sta nceof\)\=\>\)'
let g:javascript_continuation = '\%([<=,.?/*:^%|&]\|+\@<!+\|-\@<!-\|\<in\%(stanceof\)\=\)\s*\%(\%(\/\%(\%(\*.\{-}\*\/\)\|\%(\*\+\)\)\)\s*\)\=$'

let g:used_javascript_libs = 'react'

let g:LanguageClient_serverCommands = {
    \ 'rust':           ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript':     ['/usr/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['/usr/bin/javascript-typescript-stdio'],
    \ 'json':           ['/usr/bin/javascript-typescript-stdio'],
    \ 'typescript':     ['/usr/bin/javascript-typescript-stdio'],
    \ 'typescript.tsx': ['/usr/bin/javascript-typescript-stdio'],
    \ 'typescript.jsx': ['/usr/bin/javascript-typescript-stdio'],
    \ 'python':         ['/usr/local/bin/pyls'],
    \ }

" Work around a bug when editing files webpack watches.
" But tares on a ssd drive
autocmd FileType javascript.jsx :set backupcopy=yes
autocmd FileType javascript.jsx :set signcolumn=yes
autocmd FileType javascript :set signcolumn=yes

" LSP --------------------
" Required for operations modifying multiple buffers like rename.
set hidden

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" ultisnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

" Neomake  -------------------------
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_php_enabled_makers = ['php']
let g:neomake_html_enabled_makers = ['tidy']
let g:neomake_scss_enabled_makers = ['scsslint']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_json_enabled_makers = ['jsonlint']
au User NeomakeFinished checktime

let g:neomake_logfile='/tmp/error.log'

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Color Configuration ==================================================
" enable nvim truecolor
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" set terminal color
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" set colorscheme
set background=dark
set termguicolors
colorscheme gotham

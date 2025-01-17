" enable nvim truecolor
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
 indent = {
   enable = true
 },
}
EOF

" set terminal color
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Color scheme overrides
"
" \ | highlight Normal  cterm=NONE ctermbg=3  gui=NONE guibg=#1f1f1f
" \ | highlight Comment cterm=NONE ctermfg=14 gui=NONE guifg=#6272a4
" \ | highlight NonText cterm=NONE ctermbg=NONE gui=NONE guibg=NONE
" augroup MyColors
" autocmd!
set termguicolors
autocmd ColorScheme * highlight Normal      guibg=NONE
                  \ | highlight EndOfBuffer guibg=NONE
                  \ | highlight NonText     guibg=NONE
                  \ | highlight NormalNC    guibg=NONE
                  \ | highlight CursorLine  guibg=#282a36
                  \ | highlight VertSplit   guibg=NONE    guifg=grey
                  " \ | highlight Comment   cterm=NONE ctermfg=14 gui=NONE guifg=#8f9ed3
augroup END

" set background=dark
" set background=light
colorscheme sonokai

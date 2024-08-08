" Fix for vim auto entering in REPLACE mode
" set t_u7=
" set nocompatible

call plug#begin()

Plug 'https://tpope.io/vim/repeat.git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" colorschemes
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
" code highlight
Plug 'vim-python/python-syntax'
" HTML
Plug 'mattn/emmet-vim'
" :PlugInstall to install plugins, or :PlugUpdate to update them

call plug#end()

set belloff=all
syntax enable

" Mapping leader key to spacebar
let mapleader = ' '
nmap <silent> <leader>so :source ~/.vimrc<CR>

" Python mapping
nmap <silent> <leader>xt :! clear; python3 %<CR>
nmap <silent> <leader>xv :vert term python3 %<CR>
nmap <silent> <leader>xh :term python3 %<CR>

" emmet leader key setting and shortcuts
let g:user_emmet_leader_key="<C-L>"
vmap <leader>cm <C-L>,p<CR><C-L>/dst

" mapping ctrl-] for jump to definition
nnoremap <leader>+ <C-]>

" colorscheme and highlight
colorscheme gruvbox
set bg=dark
set hlsearch
set incsearch
" turn off highlight
nmap <silent><leader>h :nohl<CR>

" Numbers and relative numbers
set number
nmap <silent><F10> :set number!<CR>
imap <silent><F10><ESC> :set number!<CR>i
set relativenumber
nmap <silent><F11> :set relativenumber!<CR>
nmap <silent><F11><ESC> :set relativenumber!<CR>i

" Split windows: mapping leader w to Ctrl-w
nnoremap <leader>w <C-w>

" Split window resize shortcut
" note: to 'write' a key like Alt or Ctrl in INSERT mode press Ctrl-v and then
" the key to write down
nnoremap <silent>j :resize +2<CR>
nnoremap <silent>k :resize -2<CR>
nnoremap <silent>h :vert resize +4<CR>
nnoremap <silent>l :vert resize -4<CR>

" Setting default default split: vertical to the right, horizontal below
set splitright
set splitbelow

" Setting tabstops and scroll offset
set scrolloff=2
set ts=4 sts=4 sw=4 et ai si

" python code highlight options
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" netrw settings, styles: 0 thin, 1 long, 2 wide, 3 tree
let g:netrw_liststyle=3
let g:netrw_preview=1

" Auto make view and auto load it silently on buffer close and open
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Next two lines are for the fuzzy search in .vimrc
set path+=** " Search all subdirectories and recursively
set wildmenu " Show multiple matches on one line

" Cursor shape settings, SI is insert mode, EI when exiting insert mode.
" Reference chart of values:
" Ps = 0 is Blinking block. Ps = 1 is blinking block (default).
" Ps = 2 is stady block, Ps = 3 is blinking underline,
" Ps = 4 is stady underline, Ps = 5 is blinking bar and 6 is steady bar
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

"+++++++++++++++++++ Conquer of completion settings ++++++++++++++++++++
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)


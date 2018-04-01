" general settings
if exists('+relativenumber')
  set relativenumber
endif

if exists('+number')
  set number
endif

syntax on                       " enable syntax highlighting
filetype plugin indent on       " latest smart tab setting
set tabstop=2                   " show existing tab
set shiftwidth=2                " when indenting with '>', use spaces
set expandtab                   " On pressing tab, insert spaces
set laststatus=2                " always display the status on the bottom-1 line
set hlsearch                    " when searching, highlight all
set shortmess+=I                " don't display the intro message
set backspace=indent,eol,start  " enable regular backspacing

let mapleader = ','

" turn number on and off
map <Leader>no :set nonumber <bar> :set norelativenumber<CR>
map <Leader>nO :set number <bar> :set relativenumber<CR>

" git commands
map <Leader>gs :! git status<CR>
map <Leader>gd :! git diff %<CR>
map <Leader>ga :! git add %<CR>

" open commands
map <Leader>ob :buffers<CR>:buffer<Space>
map <Leader>oe :Vexplore<CR>

" code folding settings
if exists('+foldmethod')
  set foldmethod=indent
  set foldlevel=1
  set foldlevelstart=0
  set foldnestmax=10
  nnoremap f za
  nnoremap < zm
  nnoremap > zr
endif

" make tabs intuitive for insert mode
inoremap <S-Tab> <Esc><<i
nnoremap <Tab> >>i<Esc>
nnoremap <S-Tab> <<i<Esc>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" key mappings
nnoremap T :tabnew<CR>
nnoremap L :tabnext<CR>
nnoremap H :tabprev<CR>
nnoremap <C-S-L> :tabm +1<CR>
nnoremap <C-S-H> :tabm -1<CR>
nnoremap s :%s/    /\t/gc<CR>
set pastetoggle=<F2>
nnoremap <F8> :let @/ = ""<CR>

" key mappings for multi-window navigation
nnoremap <Up> <c-w>k
nnoremap <Down> <c-w>j
nnoremap <Left> <c-w>h
nnoremap <Right> <c-w>l

" mapping CTRL-SHIFT-Arrow keys
map [1;6A <C-S-Up>
map [1;6B <C-S-Down>
map [1;6C <C-S-Right>
map [1;6D <C-S-Left>

" mapping ALT-SHIFT-Arrow keys
map <S-Up> :resize +2<CR>
map <S-Down> :resize -2<CR>
map <S-Right> :vertical resize +4<CR>
map <S-Left> :vertical resize -4<CR>

" netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 13
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

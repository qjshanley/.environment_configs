"general settings
if exists('+relativenumber')
	set relativenumber
endif

if exists('+number')
	set number
endif

syntax on
set pastetoggle=<F2>
set smartindent
set tabstop=4
set shiftwidth=4
set hlsearch
set showtabline=2
set shortmess+=I

"code folding settings
if exists('foldmethod')
	set foldmethod=indent
	set foldnestmax=5
	set nofoldenable
	set foldlevel=1
endif

"make tabs intuitive for insert mode
imap <S-Tab> <Esc><<i

"key mappings
map! zz <esc>
nnoremap ; :
nnoremap T :tabnew<CR>
nnoremap L :tabnext<CR>
nnoremap H :tabprev<CR>
nnoremap s :%s/    /\t/gc<CR>
nnoremap <F8> :let @/ = ""<CR>
nnoremap <F3> :Explore<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

"key mappings for multi-window navigation
nnoremap <Up> <c-w>k
nnoremap <Down> <c-w>j
nnoremap <Left> <c-w>h
nnoremap <Right> <c-w>l

"mapping CTRL-Arrow keys
map [1;5A <C-Up>
map [1;5B <C-Down>
map [1;5D <C-Left>
map [1;5C <C-Right>

"mapping SHIFT-Arrow keys
map [1;2A <S-Up>
map [1;2B <S-Down>
map [1;2D <S-Left>
map [1;2C <S-Right>

"mapping CTRL-SHIFT-Arrow keys
map [1;6A <C-S-Up>
map [1;6B <C-S-Down>
map [1;6D <C-S-Left>
map [1;6C <C-S-Right>

"key mappings to resize windows
nnoremap <silent> <C-Up> :resize +1<CR>
nnoremap <silent> <C-Down> :resize -1<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

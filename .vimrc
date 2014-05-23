"general settings
if exists('+relativenumber')
        set relativenumber
endif
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

"make tabs intuitive for command mode
nmap <S-Tab> <<
nmap <Tab> >>
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

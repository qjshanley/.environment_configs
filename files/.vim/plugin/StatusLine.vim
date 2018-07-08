" Formats the statusline
set laststatus=2
set statusline=%f\ %=%m%r\ [%p%%]\ [line:%03l/%03L,col:%03v]

function SetupWindowStyle()
  " default the statusline to green when entering Vim
  hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
endfunction

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

augroup WindowStylizing
  autocmd!
  autocmd VimEnter * call SetupWindowStyle()
  autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
  autocmd InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
augroup END

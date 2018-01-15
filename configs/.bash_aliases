# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'

shen() { 
  grep -v "escape" ~/.screenrc | ssh "$1" "cat > .screenrc"
  ssh -t "$1" screen -D -R
}

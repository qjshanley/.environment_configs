# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'

shh() { 
  if [ "$1" == "-c" ]; then
    # copy dot files
    shift 1
    grep -v "escape" ~/.screenrc | ssh "$1" "cat > .screenrc"
    cat ~/.vimrc | ssh "$1" "cat > .vimrc"
  fi
  ssh -t "$1" screen -D -R
}

# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'

function datica() {
  case $1 in
      qub3r)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
       test)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
    staging)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
       prod)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
          *)             $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
  esac
}

function ssh() { 
  if [ "$#" == 1 -a "${1:0:1}" != "-" ] ; then
    [ ! -r ~/.foobar/known_hosts ] && mkdir -p ~/.ssh && touch ~/.ssh/known_hosts
    if [ -z "$(grep "$1" ~/.ssh/known_hosts)" ] ; then
      dot_files="~/.bash_aliases ~/.screenrc ~/.vimrc"
      eval "scp $dot_files ${1}:~/."
    fi
    eval "$(which ssh) -t $1 screen -D -R"
  else
    eval "$(which ssh) $@"
  fi
}

function oom_check() {
  printf "Container ID: " && read CID
  CPU_SET="$(sudo docker inspect $CID | grep "Id" | awk -F'"' '{print $4}')" && dmesg -t | grep "$CPU_SET"
}

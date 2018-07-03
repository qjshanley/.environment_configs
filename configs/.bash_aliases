# User specific aliases and functions
alias ..='cd ..'
alias vi='vim'
alias lh='ls -lh'
alias lt='ls -lt'
alias lha='ls -lhA'
alias lta='ls -ltA'
alias recent='ls -lhtA | head -n 20'

function compare {
	diff -W $(tput cols) -s -y $@
}

function pod-api {
	sudo docker exec -it -u postgres postgresql bash -c '
		export PSQL_EDITOR=$(which vim)
		export PG_CURR_DB=pod-api
		psql $PG_CURR_DB
	'
}

function li {
	printf -- "%*s\n" "$(tput cols)" " " | sed 's/ /-/g'
}

function datica {
  case $1 in
      qub3r)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
       test)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
    staging)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
       prod)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
          *)             $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
  esac
}

function dat {
	bash ~/code/datica/toolbox/misc/exec_for_each_service_in_env.sh $@
}

function ssh { 
  if [ "$#" == 1 -a "${1:0:1}" != "-" ] ; then
    [ ! -r ~/.foobar/known_hosts ] && mkdir -p ~/.ssh && touch ~/.ssh/known_hosts
		dot_files="${HOME}/.bash_aliases ${HOME}/.screenrc ${HOME}/.vimrc"
		rsync -Le ssh ${dot_files} ${1}:~/.
    $(which ssh) -t $1 screen -DR -S ssh -p 0 -t host
  else
    $(which ssh) $@
  fi
}

function oom_check {
  printf "Container ID: " && read CID
  CPU_SET="$(sudo docker inspect $CID | grep "Id" | awk -F'"' '{print $4}')" && dmesg -T | grep "$CPU_SET"
}

function LIST {
	netstat -an | sed -n '1,2p ; /tcp.*LIST/p'
}

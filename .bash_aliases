# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'

#USAGE: moop --port #####
#Complete list of all operation including idle and system operations
alias moop='moop'
function moop { echo "rs.slaveOk(true); db.currentOp();" | mongo $1 $2; }

#USAGE: moops --port #####
#Sorted list of running operations by TIME - OPID
alias moops='moops'
function moops { 
	echo ' secs - opid'
	js="rs.slaveOk(); 
		inprog = db.currentOp().inprog;
		for(var i = 0; i < inprog.length; i++) {
			msg = ' ';
			if('secs_running' in inprog[i]) {
				msg += inprog[i]['secs_running'] + ' - ';
			} else {
				msg += 'NA - ';
			}
			msg += inprog[i]['opid'];
			print(msg);
		}
	"
	echo $js | mongo --quiet $1 $2 | sort -n
}

#USAGE: moopid --port #####  #####
#Print the operation where the OPID match the last value passed in
alias moopid='moopid'
function moopid { 
	js="rs.slaveOk(); 
		inprog = db.currentOp(true).inprog;
		
		for(var i = 0; i < inprog.length; i++) {
			if(inprog[i]['opid'] == $3) {
				printjson(inprog[i]);
			}
		}
	"
	echo $js | mongo --quiet $1 $2 $3
}

#USAGE: molag --port #####
#Print the replication lag for the cluster.
alias molag='molag'
function molag { echo "print(new Date()); var status = rs.status(); status.members.forEach( function(obj) { print(obj.name + \" (\" + obj.state + \") -- \" + (status.date - obj.optimeDate)/1000) } );" | mongo $1 $2; }

alias cql='cql'
function cql { ~/.cassandra/dsc-cassandra-2.1.13/bin/cqlsh "$1"; }

# User specific aliases and functions
# Copy the code below into your .bashrc in your home directory.
#***REMOVE THE COMMENTS***
#if [ -f ~/.bash_aliases ]; then
#	. ~/.bash_aliases
#fi

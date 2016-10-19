# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'

alias moop='moop'
function moop { echo "rs.slaveOk(); db.currentOp({"secs_running":{\$exists:true}});" | mongo $1 $2; }

alias moops='moops'
function moops { echo "rs.slaveOk(); db.currentOp({"secs_running":{\$exists:true}});" | mongo $1 $2 | grep -e "opid" -e "secs"; }

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

	
	
	
	
	
#	.forEach(function(operation) { msg = \"OPID: \" + operation[\"opid\"] + \" - MILLIS: \"; if(\"secs_running\" in operation) { msg += operation[\"secs_running\"] }; print(msg); printjsononeline(operation); } )" | mongo $1 $2; }
#function moopid { echo "rs.slaveOk(); db.currentOp();" | mongo $1 $2 | grep -e "$3" -A $4 -B 1; }
#db.currentOp(true).inprog.forEach(function(o) { if(o["opid"] == 9){ printjson(o) } } )

alias moopns='moopns'
function moopns { echo "rs.slaveOk(); db.system.profile.aggregate({\$group: {\"_id\": \"\$3\", \"count\": {\$sum: 1} } })" | mongo $1 $2 $3; }

alias moprof='moprof'
function moprof { echo "print(\"Level\t| SlowMS\t| DB\"); print(\"-------------------------------------------------\"); db.adminCommand(\"listDatabases\").databases.forEach( function (mdb) { db = db.getSiblingDB(mdb.name); print(db.getProfilingStatus().was + \"\t| \" + db.getProfilingStatus().slowms + \"   \t| \" + db); } );" | mongo $1 $2 $3; }

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

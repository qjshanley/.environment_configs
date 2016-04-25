# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'
alias moop='echo "rs.slaveOk(); db.currentOp({"secs_running":{\$exists:true}});" | mongo --port 27018'
alias moops='echo "rs.slaveOk(); db.currentOp({"secs_running":{\$exists:true}});" | mongo --port 27018 | grep -e "opid" -e "secs"'
alias moopid='echo "rs.slaveOk(); db.currentOp();" | mongo --port 27018 | grep -e "$opid" -A 30 -B 1'
alias moopns='echo "rs.slaveOk(); db.system.profile.aggregate({\$group: {\"_id\": \"\$ns\", \"count\": {\$sum: 1} } })" | mongo --port 27018 $ns'
alias moprof='echo "print(\"Level\t| SlowMS\t| DB\"); print(\"-------------------------------------------------\"); db.adminCommand(\"listDatabases\").databases.forEach( function (mdb) { db = db.getSiblingDB(mdb.name); print(db.getProfilingStatus().was + \"\t| \" + db.getProfilingStatus().slowms + \"   \t| \" + db); } );" | mongo --port 27018 --quiet'
alias molag='echo "print(new Date()); var status = rs.status(); status.members.forEach( function(obj) { print(obj.name + \" (\" + obj.state + \") -- \" + (status.date - obj.optimeDate)/1000) } );" | mongo --port 27018'

# User specific aliases and functions
# Copy the code below into your .bashrc in your home directory.
#***REMOVE THE COMMENTS***
#if [ -f ~/.bash_aliases ]; then
#	. ~/.bash_aliases
#fi

function objectIdFromTimestamp(ts) {
        // ***** USE 'YYYY/MM/DD' FORMAT *****

        // Convert string date to Date object (otherwise assume timestamp is a date)
        if (typeof(ts) == 'string') {
                var ts = new Date(ts);
        }

        // Convert date object to hex seconds since Unix epoch
        var hexSeconds = Math.floor(ts/1000).toString(16);

        // Create an ObjectId with that hex timestamp
        var constructedObjectId = ObjectId(hexSeconds + "0000000000000000");

        return constructedObjectId
}

function printRepLag() {
	status = rs.status(); 
	status.members.forEach( function(obj) { 
		print(obj.name + " (" + obj.state + ") -- " + (status.date - obj.optimeDate)/1000) 
	});
}

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

function popularContests(date, limit) {
	if (typeof(date) == 'string') {
		var mid = objectIdFromTimestamp(date);
	}

	db.entry.aggregate(
		{"$match":{"_id":{"$gte":mid}}}, 
		{"$group":{"_id":{"client_id":"$client_id", "contest_id":"$contest_id"}, "count":{"$sum":1}}}, 
		{"$sort":{"count":-1}}, 
		{"$limit":limit}).result.forEach(
			function(d) { 
				var c = db.config.findOne(
					{"_id":ObjectId(d._id.contest_id)}, 
					{"config.submission.twitter_hashtag":1, "config.submission.instagram_hashtag":1}); 
				print("###################################################################"); 
				printjson(d); 
				printjson(c); 
				print("###################################################################"); 
			}
		);
}

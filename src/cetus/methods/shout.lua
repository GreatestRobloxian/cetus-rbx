return function(client, newShout)
	return client:makeRequest("PATCH", "/v1/roblox/shout/", {
		message = newShout
	})
end

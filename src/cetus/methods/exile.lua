return function(client, userId)
	return client:makeRequest("DELETE", "/v1/roblox/exile/"..userId)
end

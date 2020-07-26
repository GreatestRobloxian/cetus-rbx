return function(client)
    return function (userId)
        return client.makeRequest("GET", "/v1/roblox/rank/"..userId)
    end
end
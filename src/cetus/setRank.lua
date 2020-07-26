return function(client)
    return function (userId, rank)
        return client.makeRequest("POST", "/v1/roblox/setRank/"..userId, {
            rank = rank
        })
    end
end
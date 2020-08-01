return function (client, userId)
    return client:makeRequest("GET", "/v1/roblox/rank/"..userId)
end

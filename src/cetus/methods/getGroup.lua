local cache = nil
local cacheSetAt = 0
return function (client)
    if cache then
        -- 20 minutes cache time
        if (os.time() - cacheSetAt) < 1200 then
            return cache
        else
            cacheSetAt = 0
            cache = nil
        end
    end
    local result =  client:makeRequest("GET", "/v1/roblox/info/")
    if not result.error then
        cache = result
        client._groupId = result.id
        cacheSetAt = os.time()
    end
    return result
end

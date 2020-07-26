local http = require(script.http)
local getRank = require(script.getRank)
local setRank = require(script.setRank)
--[[
    https://cetus.app: Lua SDK
    Source: https://github.com/cetus-app/cetus-rbx
    As per our license you should not modify this to be used on other projects without open sourcing your code.
    Written by Neztore, 2020.
    v0.0.1

    Availible client options:
        * token (required): Your authorisation token for your group. Get one here: https://cetus.app/dashboard



]]
return function (config)
    local client = {
        baseUrl = "http://localhost:4000"
    }
    if config.token then
       client._token = config.token
    else
        error("Cetus-Rbx: Failed to start: No token provided.")
    end
    client.makeRequest = http(client)
    client.getRank = getRank(client)
    client.setRank = setRank(client)

    return client
end
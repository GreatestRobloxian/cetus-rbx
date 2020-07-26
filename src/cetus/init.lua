local http = require(script.http)
local getRank = require(script.getRank)
local setRank = require(script.setRank)
local assertConfig = require(script.assertConfig)
--[[
    https://cetus.app: Lua SDK
    Source: https://github.com/cetus-app/cetus-rbx
    As per our license you should not modify this to be used on other projects without open sourcing your code.
    Written by Neztore, 2020.
    v0.0.1

    Availible client options:
        * token (required): Your authorisation token for your group. Get one here: https://cetus.app/dashboard
]]

local clientPrototype = {}
clientPrototype.baseUrl = "https://api.cetus.app"
clientPrototype.http = http
clientPrototype.setRank = setRank
clientPrototype.getRank = getRank

--No need to have two tables if we can only use one!
clientPrototype.__index = clientPrototype
clientPrototype.__metatable = "locked"

local function new (config)
    assertConfig(config)

    return setmetatable({
        baseUrl = config._overrideBase;
        _token = config.token;
    }, clientPrototype)
end

return new
local http = require(script.util.http)
local assertConfig = require(script.util.assertConfig)

--[[
    https://cetus.app: Lua SDK
    Source: https://github.com/cetus-app/cetus-rbx
    As per our license you should not modify this to be used on other projects without open sourcing your code.

    Availible client options:
        * token (required): Your authorisation token for your group. Get one here: https://cetus.app/dashboard

    Version: v0.2.0
]]

local clientPrototype = {}

-- Load methods from file
-- Also includes a wrapper function to ensure functions are called correctly.
for _, child in pairs(script.methods:GetChildren()) do
    if child:isA("ModuleScript") then
        local func = require(child)
        clientPrototype[child.Name] = function (client, ...)
            if type(client) == "table" and client.__name == "Cetus client" then
                return func(client, ...)
            else
                error("Failed to find Client instance. Did you call a method without using :Method()?")
            end
        end
    end
end

clientPrototype.baseUrl = "https://api.cetus.app"
clientPrototype.makeRequest = http

--No need to have two tables if we can only use one!
clientPrototype.__index = clientPrototype
clientPrototype.__metatable = "locked"

-- Purely to allow us to make sure methods are called properly
clientPrototype.__name = "Cetus client"

local function new (config)
    assertConfig(config)

    return setmetatable({
        baseUrl = config._overrideBase;
        _token = config.token;
    }, clientPrototype)
end

return new
local httpService = game:GetService("HttpService");

--[[
    The main function used to interact with the Cetus API.
    If successful, this function will return the body of the response.
    If the request fails it will return the following:
    {
        error: {
            status: number (The http status code),
            message: string, The HTTP error message
            name: string The error name (often something like UnauthorisedError)
        }
    }
    In the event of an error occuring *making* the request, (an error which would normally be thrown)
    This will return the status code as 0, the name as "HttpError" and the message as the Roblox error message
    If an error is returned from the API it is returned as-is.
]]

local function makeRequest (client, method, url, body)
    local headers = {
         Authorization = "Bearer "..client._token
    }
    local request = {
        Url = client.baseUrl..url,
        Method = method,
        Headers = headers
    }
    if body then
        headers["Content-Type"] = "application/json"
        if type(body) == "string" then
            request.body = httpService:JSONEncode(body)
        else
            request.body = body
        end
    end
    local succ, returnVal = pcall(function ()
        local response = httpService:RequestAsync(request)
        local decoded = httpService:JSONDecode(response.Body);
        if response.Success then
            return decoded
        else
            return {
                error = {
                    status = response.StatusCode,
                    message = decoded.message,
                    name = decoded.name
                }
            }
        end
    end)
    if succ then
        return returnVal
    else
        return {
            error = {
                status = 0,
                message = returnVal,
                name = "HttpError"
            }
        }
    end
end

return makeRequest
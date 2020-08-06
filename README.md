# cetus-rbx
The official Lua SDK for interacting with the Cetus API from Roblox games.
This SDK, like our platform, is in Alpha and is not quite fully baked yet.
Expect a lot of variation between versions until we hit v1.x.x!

> **Warning**: The docs provided here may not be kept up to date. See the official docs by opening the group in our dashboard and clicking "Lua SDK".
> [Dashboard](https://cetus.app/dashboard)

## Installation
### Method 1: Rojo
You must have Rojo installed and configured
1. Clone this repo with your GUI tool of choice or the command:
```bash
$ git clone https://github.com/cetus-app/cetus.rbx
```
2. Navigate to the repository
3. Run `Rojo serve`

### Method 2: Github releases
We release Roblox model files via. the [Github releases](https://github.com/cetus-app/cetus-rbx/releases) page. You can download the model, add it to your game via. "Insert from file" and get started!


## API
### Responses
The majority of the methods here return the API response in the event of a success. You can find schemas and more by looking at our API docs.
Errors are slightly different:
#### Handling errors
Errors are returned as a table with the following keys:
```lua
{
    error = {
        status: number, -- The HTTP status code. 0 for a Roblox HTTP error
        name: string, -- The error name as returned by our API or "HttpError" for Roblox HTTP errors like ConnectFail.
        message: string -- A more indepth error message. Always returned unless it's an unauthorized error, in which case it may not be.
    }
}
```
We choose not to use the built in Lua `error` function because it only allows us to throw a string, and it does not allow us to express these other values.
Our recomended way to make use of the API is to run a method and then check for `response.error` to see if it errored. If `error` is nil, the `response` will be the returned API values.

### Getting a client
The main cetus module returns an init function. To create a `Client`, you must call this init function with your client config.

This client structure means that you can have multiple Cetus clients or "instances" of this SDK without them interfering with each other.
This means that you could control multiple groups at once, for example.


#### Client options
- token: string, Your authorisation token as gained from our Dashboard https://cetus.app/dashboard. You must add the group to our service first.

These are passed as a table.

#### Client example
```lua
local ServerStorage = game:GetService("ServerStorage")
local Cetus = require(ServerStorage.cetus)
local client = Cetus({
    token = "My secret authentication token"
})
```
### Client Methods
> More Documentation coming soon
#### setRank
`client:setRank(userId: number)`

#### getRank
`client:getRank(userId: number)`

#### exile
`client:exile(userId: number)`

#### shout
`client:shout(message: string)`
Post string `message` to the Group shout. Pass an empty string to remove the Group shout.

## To-do list
* Add rate limit support
* Implement option to make errors 'thrown'

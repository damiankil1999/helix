---Grants abilities to characters.
---
---Flags are a simple way of adding/removing certain abilities to players on a per-character basis. Helix comes with a few flags
--- by default, for example to restrict spawning of props, usage of the physgun, etc. All flags will be listed in the
--- `Flags` section of the `Help` menu. Flags are usually used when server validation is required to allow a player to do something
--- on their character. However, it's usually preferable to use in-character methods over flags when possible (i.e restricting
--- the business menu to characters that have a permit item, rather than using flags to determine availability).
---
---Flags are a single alphanumeric character that can be checked on the server. Serverside callbacks can be used to provide
--- functionality whenever the flag is added or removed. For example:
--- ```
---	ix.flag.Add("z", "Access to some cool stuff.", function(client, bGiven)
---		print("z flag given:", bGiven)
---	end)
---
---	Entity(1):GetCharacter():GiveFlags("z") --> z flag given: true
---	Entity(1):GetCharacter():TakeFlags("z") --> z flag given: false
---	print(Entity(1):GetCharacter():HasFlags("z")) --> false
--- ```
---
---Check out `Character:GiveFlags` and `Character:TakeFlags` for additional info.
---@see Character.GiveFlags
---@see Character.TakeFlags
---@class ix.flag
---@field list table<string, { description: string, callback?: fun(client: Player, isGiven: boolean) }>
ix.flag = {}

---[SHARED] Creates a flag. This should be called shared in order for the client to be aware of the flag's existence.
---@param flag string Alphanumeric character to use for the flag
---@param description string Description of the flag
---@param callback? fun(client: Player, isGiven: boolean) Function to call when the flag is given or taken from a player. Or during `GM:PlayerLoadout`.
function ix.flag.Add(flag, description, callback) end

---[SERVER] Called to apply flags when a player has spawned.
---@param client Player Player to setup flags for
function ix.flag.OnSpawn(client) end
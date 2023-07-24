---@meta

---@TODO Document `CharVarData`.
---@class CharVarData
---@field field? string If set will save the var in a database column.
---@field fieldType? string
---@field bSaveLoadInitialOnly? boolean
---@field bNotModifiable? boolean
---@field OnSet? function
---@field OnGet? function
---@field default any
---@field bNoNetworking? boolean
---@field isLocal? boolean
---@field alias? string
---@field value any

---Character creation and management.
---@class ix.char
---[SHARED] Characters that are currently loaded into memory. This is **not** a table of characters that players are currently using.
---Characters are automatically loaded when a player joins the server. Entries are not cleared once the player disconnects, as
--- some data is needed after the player has disconnected. Clients will also keep their own version of this table, so don't
--- expect it to be the same as the server's.
---
---The keys in this table are the IDs of characters, and the values are the `Character` objects that the ID corresponds to.
---
---Example:
--- ```
--- print(ix.char.loaded[1]) -- > character[1]
--- ```
---@field loaded table<number, Character>
---[SHARED] Variables that are stored on characters. This table is populated automatically by `ix.char.RegisterVar`.
---@field vars table<string, CharVarData>
---[SERVER] Functions similar to `ix.char.loaded`, but is serverside only. This contains a table of all loaded characters grouped by
--- the SteamID64 of the player that owns them.
---@field cache table<string, Character[]>
---@field private varHooks table<string, table<string, function>>
ix.char = {}

---@TODO Document `CharCreateData`
---@class CharCreateData
---@field name? number
---@field description? number
---@field model? string Defaults to `"models/error.mdl"`.
---@field steamID string
---@field faction? string Defaults to `"Unknown"`.
---@field money? number Defaults to `ix.config.Get("defaultMoney", 0)`.
---@field data? table<string, any>

---[SERVER] Creates a character object with its assigned properties and saves it to the database.
---@param data CharCreateData Properties to assign to this character. If fields are missing from the table, then it will use the default value for that property
---@param callback fun(id: number) Function to call after the character saves
function ix.char.Create(data, callback) end

---[SERVER] Loads all of a player's characters into memory.
---@param client Player Player to load the characters for
---@param callback? fun(characters: Character[]) Function to call when the characters have been loaded
---@param bNoCache? boolean Whether or not to skip the cache; players that leave and join again later will already have their characters loaded which will skip the database query and load quicker
---@param id? number The ID of a specific character to load instead of all of the player's characters
function ix.char.Restore(client, callback, bNoCache, id) end

---[SERVER] Adds character properties to a table. This is done automatically by `ix.char.Restore`, so that should be used instead if you are loading characters.
---@param data table Table of fields to apply to the table. If this is an SQL query object, it will instead populate the query with `SELECT` statements for each applicable character var in `ix.char.vars`.
---@param characterInfo table Table to apply the properties to. This can be left as `nil` if an SQL query object is passed in `data`
function ix.char.RestoreVars(data, characterInfo) end

---[SHARED] Creates a new empty `Character` object. If you are looking to create a usable character, see `ix.char.Create`.
---@param data table Character vars to assign
---@param id number Unique ID of the character
---@param client Player Player that will own the character
---@param steamID? string SteamID64 of the player that will own the character. Defaults to `client:SteamID64()`.
---@return Character
function ix.char.New(data, id, client, steamID) end

---@TODO Document `ix.char.HookVar`.
---@param varName string
---@param hookName string
---@param func function
function ix.char.HookVar(varName, hookName, func) end

---@TODO Document `ix.char.RegisterVar`.
---@param key string
---@param data CharVarData
function ix.char.RegisterVar(key, data) end
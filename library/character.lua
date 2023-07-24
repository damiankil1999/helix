---@meta

---@class Character
---@field id number Unique ID of the character.
---@field vars table<string, any>
---@field firstTimeLoaded boolean? [SERVER] Set when `Character.Setup` was called.
---@field steamID string SteamID64 of the owning player.
---@field player number|Player Player entity or Entity ID of the owning player.
local Character = {}

---[SHARED] Returns a string representation of this character.
---
---Example:
--- ```
--- print(ix.char.loaded[1]) --> "character[1]"
--- ```
---@return string
function Character:__tostring() end

---[SHARED] Returns true if this character is equal to another.
--- Internally, this checks character IDs.
---@return boolean
function Character:__eq() end

---[SHARED] Return this character's database ID. This is quaranteed to be unique.
---@return number #Unique ID of the character.
function Character:GetID() end

---[SERVER] Saves this character's info to the database.
--- This will silently fail if the character is owned by a bot or the `CharacterPreSave`
--- hook has returned `false`
---
---Example:
--- ```
--- ix.char.loaded[1]:Save(function () print("Done!") end)
--- --Prints "Done!" to console when the character has been saved.
--- ```
---@param callback function Function to call when the save has completed.
function Character:Save(callback) end

---[SERVER] Networks this character's information to make the given player aware of this character's existence. If the receiver is
--- not the owner of this character, it will only be sent a limited amount of data (as it does not need anything else).
--- This is done automatically by the framework.
---@protected
---@param receiver? Player Player to send the information to. This will sync to all connected players if set to `nil`.
function Character:Sync(receiver) end

---[SERVER] Applies the character's appearance and synchronizes information to the owning player.
---@param bNoNetworking? boolean Whether or not to sync the character info to other players
function Character:Setup(bNoNetworking) end

---[SERVER] Forces a player off their current character, and sends them to the character menu to select a character.
function Character:Kick() end

---[SERVER] Forces a player off their current character, and prevents them from using the character for the specified amount of time.
---@param time? number Amount of seconds to ban the character for. If left as `nil`, the character will be banned permanently
function Character:Ban(time) end

---[SHARED] Returns the player that owns this character.
---@return Player? #player that owns this character.
function Character:GetPlayer() end

---[SERVER] Sets character name.
---Added by `ix.char.RegisterVar("name")`
function Character:SetName(value) end

---[SHARED] Gets character name.
---Added by `ix.char.RegisterVar("name")`
---@return string #This character's current name
function Character:GetName() end

---[SERVER] Sets character Description.
---Added by `ix.char.RegisterVar("description")`
---@param value string
function Character:SetDescription(value) end

---[SHARED] Gets character Description.
---Added by `ix.char.RegisterVar("description")`
---@return string #This character's current description
function Character:GetDescription() end

---[SERVER] Sets this character's model. This sets the player's current model to the given one, and saves it to the character.
---Added by `ix.char.RegisterVar("model")`
---@param value string
function Character:SetModel(value) end

---[SHARED] Gets character Description.
---Added by `ix.char.RegisterVar("model")`
---@return string #This character's current model
function Character:GetModel() end

---[SERVER] Makes this character join a class. This automatically calls `KickClass` for you.
---@param class number Index of the class to join
---@return boolean #Whether or not the character has successfully joined the class
function Character:JoinClass(class) end

---[SERVER] Kicks this character out of the class they are currently in.
function Character:KickClass() end

---[SHARED] Gets character class.
---Added by `ix.char.RegisterVar("class")`
---@return number #Index of this character's current class
function Character:GetClass() end

---[SERVER] Sets character Description.
---Added by `ix.char.RegisterVar("faction")`
---@param value number Index of the faction to transfer this character to
function Character:SetFaction(value) end

---[SHARED] Gets character Description.
---Added by `ix.char.RegisterVar("faction")`
---@return number #Index of the faction this character is currently in.
function Character:GetFaction() end

---[SERVER] Sets this character's current money. Money is only networked to the player that owns this character.
---Added by `ix.char.RegisterVar("money")`
---@param money number New amount of money this character should have
function Character:SetMoney(money) end

---[SHARED] Returns this character's money. This is only valid on the server and the owning client.
---Added by `ix.char.RegisterVar("money")`
---@return number #Current money of this character
function Character:GetMoney() end

---[SERVER] Sets a data field on this character. This is useful for storing small bits of data that you need persisted on this
--- character. This is networked only to the owning client. If you are going to be accessing this data field frequently with
--- a getter/setter, consider using `ix.char.RegisterVar` instead.
---Added by `ix.char.RegisterVar("data")`
---@param key string Name of the field that holds the data
---@param value any Any value to store in the field, as long as it's supported by GMod's JSON parser
function Character:SetData(key, value) end

---[SHARED] Returns a data field set on this character. If it doesn't exist, it will return the given default or `nil`. This is only
--- valid on the server and the owning client.
---Added by `ix.char.RegisterVar("data")`
---@param key string Name of the field that's holding the data
---@param default any Value to return if the given key doesn't exist, or is `nil`
---@return any data Data stored in the field, or value of default
function Character:GetData(key, default) end

---[SERVER]
---Added by `ix.char.RegisterVar("var")`
---@TODO Document `Character.SetVar`.
---@param key string
---@param value any
---@param noReplication? boolean
---@param receiver? Player Player to send this var to. Defaults to `self:GetPlayer()`.
function Character:SetVar(key, value, noReplication, receiver) end

---[SHARED]
---Added by `ix.char.RegisterVar("var")`
---@TODO Document `Character.GetVar`.
---@param key stringlib
---@param default any
---@return any data Data stored on the var, or default.
function Character:GetVar(key, default) end

---[SERVER] Returns the Unix timestamp of when this character was created (i.e the value of `os.time()` at the time of creation).
---Added by `ix.char.RegisterVar("createTime")`
---@return number #Unix timestamp of when this character was created
function Character:GetCreateTime() end

---[SERVER] Returns the Unix timestamp of when this character was last used by its owning player.
---Added by `ix.char.RegisterVar("createTime")`
---@return number #Unix timestamp of when this character was last used
function Character:GetLastJoinTime() end

---[SERVER] Returns the schema that this character belongs to. This is useful if you are running multiple schemas off of the same
--- database, and need to differentiate between them.
---Added by `ix.char.RegisterVar("schema")`
---@return string #Schema this character belongs to.
function Character:GetSchema() end

---[SERVER] Returns the 64-bit Steam ID of the player that owns this character.
---Added by `ix.char.RegisterVar("schema")`
---@return string #Owning player's Steam ID
function Character:GetSteamID() end

---[SHARED] Returns this character's associated `Inventory` object.
---@return Inventory #This character's inventory
function Character:GetInventory() end

Character.GetInv = Character.GetInventory

---[SERVER] Increments one of this character's attributes by the given amount.
---@param key string Name of the attribute to update
---@param value number Amount to add to the attribute
function Character:UpdateAttrib(key, value) end

---[SERVER] Sets the value of an attribute for this character.
---@param key string Name of the attribute to update
---@param value number New value for the attribute
function Character:SetAttrib(key, value) end

---[SERVER] Temporarily increments one of this character's attributes. Useful for things like consumable items.
---@param boostID string Unique ID to use for the boost to remove it later
---@param attribID string Name of the attribute to boost
---@param boostAmount number Amount to increase the attribute by
function Character:AddBoost(boostID, attribID, boostAmount) end

---[SERVER] Removes a temporary boost from this character.
---@param boostID string Unique ID of the boost to remove
---@param attribID string Name of the attribute that was boosted
function Character:RemoveBoost(boostID, attribID) end

---[SHARED] Returns all boosts that this character has for the given attribute. This is only valid on the server and owning client.
---@param attribID string Name of the attribute to find boosts for
---@return table<string, number>? #Table of boosts that this character has for the attribute - `nil` If the character has no boosts for the given attribute
function Character:GetBoost(attribID) end

---[SHARED] Returns the current value of an attribute. This is only valid on the server and owning client.
---@param key string Name of the attribute to get
---@param default number Value to return if the attribute doesn't exist
---@return number #Value of the attribute
function Character:GetAttribute(key, default) end

---[SHARED] Returns if this character can afford the amount. This is only valid on the server and the owning client.
---@param amount number
---@return boolean canAfford
function Character:HasMoney(amount) end

---[SERVER] Gives the character the specified amount of money.
---@param amount number Amount to give to the character.
---@param bNoLog? boolean Whether or not to log this transaction.
---@return boolean success
function Character:GiveMoney(amount, bNoLog) end

---[SERVER] Takes the specified amount of money from this character.
---@param amount number Amount to take from the character.
---@param bNoLog? boolean Whether or not to log this transaction.
---@return boolean success
function Character:TakeMoney(amount, bNoLog) end

---[SERVER] Sets this character's accessible flags. Note that this method overwrites **all** flags instead of adding them.
---@see Character.GiveFlags
---@param flags string #Flag(s) this charater is allowed to have
function Character:SetFlags(flags) end

---[SERVER] Adds a flag to the list of this character's accessible flags. This does not overwrite existing flags.
---
---Example:
--- ```
--- character:GiveFlags("pet")
--- -- gives p, e, and t flags to the character
--- ```
---@see HasFlags
---@param flags string Flag(s) this character should be given
function Character:GiveFlags(flags) end

---[SERVER] Removes this character's access to the given flags.
---
---Example:
--- ```
--- -- for a character with "pet" flags
--- character:TakeFlags("p")
--- -- character now has e, and t flags
--- ```
---@param flags string Flag(s) to remove from this character
function Character:TakeFlags(flags) end

---[SHARED] Returns all of the flags this character has.
---@return string #Flags this character has represented as one string. You can access individual flags by iterating through the string letter by letter
function Character:GetFlags() end

---[SHARED] Returns `true` if the character has the given flag(s).
---@param flags string Flag(s) to check access for
---@return boolean #Whether or not this character has access to the given flag(s)
function Character:HasFlags(flags) end
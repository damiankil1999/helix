---@meta

---@class Entity
---@field private ixPartner Entity? [SERVER] Set on door entities that have been linked together.
local Entity = {}

---[SHARED] Returns `true` if this entity is a chair.
---@return boolean #Whether or not his entity is a chair.
function Entity:IsChair() end

---[SHARED] Returns `true` if this entity is a door. Internally, this checks to see if the entity's class has `door` in its name.
---@return boolean #Whether or not the entity is a door
function Entity:IsDoor() end

---[SERVER] Returns `true` if the given entity is a button or door and is locked.
---@return boolean #Whether or not this entity is locked; `false` if this entity cannot be locked at all (e.g not a button or door)
function Entity:IsLocked() end

---[SHARED] Returns the neighbouring door entity for double doors.
---@return Entity? #This door's partner - `nil` If the door does not have a partner
function Entity:GetDoorPartner() end

---[SERVER] Returns the entity that is blocking this door from opening.
---@return Entity? #Entity that is blocking this door - `nil` If this entity is not a door, or there is no blocking entity
function Entity:GetBlocker() end

---[SERVER] Blasts a door off its hinges. Internally, this hides the door entity, spawns a physics prop with the same model, and
--- applies force to the prop.
---@param velocity? Vector Velocity to apply to the door
---@param lifeTime? number How long to wait in seconds before the door is put back on its hinges
---@param bIgnorePartner? boolean Whether or not to ignore the door's partner in the case of double doors
---@return Entity? #The physics prop created for the door - `nil` If the entity is not a door
function Entity:BlastDoor(velocity, lifeTime, bIgnorePartner) end

---[SHARED] Retrieves a networked variable. If it is not set, it'll return the default that you've specified.
---
---Example:
--- ```
--- print(Entity(2):GetNetVar("example")) --> Hello World!
--- ```
---@see Entity.SetNetVar
---@param key string Identifier of the networked variable
---@param default any Default value to return if the networked variable is not set
---@return any #Value associated with the key, or the default that was given if it doesn't exist
function Entity:GetNetVar(key, default) end

---[SERVER] Sets the value of a networked variable.
---
---Example:
--- ```
--- Entity(2):SetNetVar("example", "Hello World!")
--- ```
---@see Entity.GetNetVar
---@param key string Identifier of the networked variable
---@param value any New value to assign to the networked variable
---@param receiver? Player|Player[]|CRecipientFilter The players to send the networked variable to
function Entity:SetNetVar(key, value, receiver) end

---[SERVER] Sends a networked variable.
---@param key string Identifier of the networked variable
---@param receiver? Player|Player[]|CRecipientFilter The players to send the networked variable to - or everyone.
function Entity:SendNetVar(key, receiver) end

---[SERVER] Clears all of the networked variables.
---@param receiver? Player|Player[]|CRecipientFilter The players to clear the networked variable for - or everyone.
function Entity:ClearNetVars(receiver) end
---@meta

---@class Faction
---@field index number index of this faction (Same as `LocaLPlayer():Team()`). Use `uniqueID` for a persistant index.
---@field plugin? string Automatically set if the faction was registered from a plugin.
---@field name string Name of the faction.
---@field color Color Color of the faction.
---@field models string[] Table of paths to the default playermodels for this faction.
---@field uniqueID string Do not overwrite this!. 'niceName' of the faction, generated from the filename.

---@class ix.faction
---@field teams table<string, Faction> Table of factions by their uniqueID (niceName)
---@field indices table<number, Faction> Table of factions by their team index.
ix.faction = {}

---[SHARED] Loads factions from a directory.
---@param directory string The path to the factions files.
function ix.faction.LoadFromDir(directory) end

---[SHARED] Retrieves a faction table.
---
---Example:
--- ```
--- print(ix.faction.Get(Entity(1):Team()).name) --> "Citizen"
--- ```
---@param identifier string|number Index or name of the faction
---@return Faction #Faction table
function ix.faction.Get(identifier) end

---[SHARED] Retrieves a faction index.
---@param uniqueID string Unique ID of the faction
---@return number #Faction index
function ix.faction.GetIndex(uniqueID) end

---[CLIENT] Returns true if a faction requires a whitelist.
---@param faction number Index of the faction
---@return boolean #Whether or not the faction requires a whitelist
function ix.faction.HasWhitelist(faction) end
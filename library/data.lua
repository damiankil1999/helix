---@meta

---@class ix.data
---@field stored table<string, any>
ix.data = {}

---[SHARED] Populates a file in the `data/helix` folder with some serialized data.
---@param key string Name of the file to save
---@param value any Some sort of data to save
---@param bGlobal? boolean Whether or not to write directly to the `data/helix` folder, or the `data/helix/schema` folder, where `schema` is the name of the current schema. Defaults to `false`
---@param bIgnoreMap? boolean Whether or not to ignore the map and save in the schema folder, rather than `data/helix/schema/map`, where `map` is the name of the current map. Defaults to `false`
function ix.data.Set(key, value, bGlobal, bIgnoreMap) end

---[SHARED] Retrieves the contents of a saved file in the `data/helix` folder.
---@param key string Name of the file to load
---@param default any Value to return if the file could not be loaded successfully
---@param bGlobal? boolean Whether or not the data is in the `data/helix` folder, or the `data/helix/schema` folder, where `schema` is the name of the current schema. Defaults to `false`
---@param bIgnoreMap? boolean Whether or not to ignore the map and load from the schema folder, rather than `data/helix/schema/map`, where `map` is the name of the current map. Defaults to `false`
---@param bRefresh? boolean Whether or not to skip the cache and forcefully load from disk. Defaults to `false`
---@return any #associated with the key, or the default that was given if it doesn't exists
function ix.data.Get(key, default, bGlobal, bIgnoreMap, bRefresh) end

---[SHARED] Deletes the contents of a saved file in the `data/helix` folder.
---@param key string Name of the file to delete
---@param bGlobal? boolean Whether or not the data is in the `data/helix` folder, or the `data/helix/schema` folder, where `schema` is the name of the current schema.
---@param bIgnoreMap? boolean Whether or not to ignore the map and delete from the schema folder, rather than `data/helix/schema/map`, where `map` is the name of the current map.
---@return boolean #Whether or not the deletion has succeeded
function ix.data.Delete(key, bGlobal, bIgnoreMap) end
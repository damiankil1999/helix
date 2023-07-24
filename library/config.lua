---@meta

---@class ix.config
---@field stored table
ix.config = {}



---[SHARED] Creates a config option with the given information.
---@param key string Unique ID of the config
---@param value any Default value that this config will have
---@param description string Description of the config
---@param callback? fun(oldValue, newValue) Function to call when config is changed
---@param data? table Additional settings for this config option. Eg `hidden: boolean`
---@param bNoNetworking? boolean Whether or not to prevent networking the config Defaults to `false`
---@param bSchemaOnly? boolean Whether or not the config is for the schema only Defaults to `false`
function ix.config.Add(key, value, description, callback, data, bNoNetworking, bSchemaOnly) end

---[SHARED] Sets the default value for a config option.
---@param key string Unique ID of the config
---@param value any Default value for the config option
function ix.config.SetDefault(key, value) end

---[SHARED]
---@TODO Document `ix.config.ForceSet`.
function ix.config.ForceSet(key, value, noSave) end

---[SHARED] Sets the value of a config option.
---@param key string Unique ID of the config
---@param value any New value to assign to the config
function ix.config.Set(key, value) end

---[SHARED] Retrieves a value of a config option. If it is not set, it'll return the default that you've specified.
---@param key string Unique ID of the config
---@param default any Default value to return if the config is not set
---@return any #Value associated with the key, or the default that was given if it doesn't exist
function ix.config.Get(key, default) end

---[SHARED] Loads all saved config options from disk.
---You can call this, but you really shouldn't.
function ix.config.Load() end

---[SERVER]
---@TODO Document `ix.config.GetChangedValues`.
function ix.config.GetChangedValues() end

---[SERVER]
---@TODO Document `ix.config.Send`.
---@param client Player|Player[]|CRecipientFilter
function ix.config.Send(client) end

---[SERVER] Saves all config options to disk.
---You can call this, but you really shouldn't.
function ix.config.Save() end
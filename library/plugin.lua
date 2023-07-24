---@meta

---All functions registered on the PLUGIN variable will be registered as a hook.
---@class Plugin
---@field folder string
---@field plugin Plugin? (Plugin in plugin, this would be the parent plugin)
---@field uniqueID string
---@field name string
---@field description string
---@field author string
---@field loading boolean
local Plugin = {}

---@see ix.data.Set
function Plugin:SetData(value, global, ignoreMap) end

---@see ix.data.Get
function Plugin:GetData(default, global, ignoreMap, refresh) end

function Plugin:OnLoaded() end

function Plugin:OnUnload() end

function Plugin:SaveData() end

function Plugin:PostLoadData() end

---@class ix.plugin
---@field list table<string, Plugin>
---@field unloaded table<string, boolean>
ix.plugin = {}

---[SHARED]
---@TODO Document `ix.plugin.Load`.
function ix.plugin.Load(uniqueID, path, isSingleFile, variable) end

---[SHARED]
---@TODO Document `ix.plugin.GetHook`.
---@return function?
function ix.plugin.GetHook(pluginName, hookName) end

---[SHARED]
---@TODO Document `ix.plugin.LoadEntities`.
function ix.plugin.LoadEntities(path) end

---[SHARED]
---@TODO Document `ix.plugin.Initialize`.
function ix.plugin.Initialize() end

---[SHARED]
---@param identifier string uniqueID of the plugin you want to access.
---@return Plugin?
function ix.plugin.Get(identifier) end

---[SHARED]
---@TODO Document `ix.plugin.LoadFromDir`.
function ix.plugin.LoadFromDir(directory) end

---[SHARED]
---@TODO Document `ix.plugin.SetUnloaded`.
function ix.plugin.SetUnloaded(uniqueID, state, bNoSave) end

---[SERVER] Runs the `LoadData` and `PostLoadData` hooks for the gamemode, schema, and plugins. Any plugins that error during the
-- hook will have their `SaveData` and `PostLoadData` hooks removed to prevent them from saving junk data.
function ix.plugin.RunLoadData() end

---[SHARED] Runs the given hook in a protected call so that the calling function will continue executing even if any errors occur
--- while running the hook. This function is much more expensive to call than `hook.Run`, so you should avoid using it unless
--- you absolutely need to avoid errors from stopping the execution of your function.
---
---```
--- local errors, bCanSpray = hook.SafeRun("PlayerSpray", Entity(1))
--- if (!errors) then
---		-- do stuff with bCanSpray
--- else
---		PrintTable(errors)
--- end
--- ```
---@param name string Name of the hook to run
---@param ... any Arguments to pass to the hook functions
---@return {name: string, plugin?: string, schema?: string, gamemode?: string, errorMessage: string}[] errors #Table of error data if an error occurred while running
---@return ... any Anything that was returned by the hook function.
function hook.SafeRun(name, ...) end
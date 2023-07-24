---@meta

---A global shared table to store Helix information.
ix = {}

---@type table<string, boolean>
ix.allowedHoldableClasses = {}

---Used internally to check if the base gamemode (helix) has been reloaded.
---This causes the plugins, configs and options to be refreshed.
IX_RELOADED = false

---Height of the ability bars.
BAR_HEIGHT = 10

---@type table<string, boolean>
ALWAYS_RAISED = {}

---All plugin functions will be registered as hooks.
--- This is the cache for those functions.
---@type table<string, table<Plugin, function>>
HOOKS_CACHE = {}
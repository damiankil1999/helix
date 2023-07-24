---@meta

---Sets a global networked var.
---@param key string
---@param default any
---@return any
function _G.GetNetVar(key, default) end

---Sets global networked var.
---@param key string
---@param value any
---@param receiver? Player|Player[]|CRecipientFilter
---@return any
function _G.SetNetVar(key, value, receiver) end
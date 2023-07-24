---@meta

---@class BarData
---@field index number
---@field color Color
---@field priority number
---@field GetValue fun(): number, string?
---@field identifier string
---@field panel Panel

---@class ix.bar
---@field list table<string, BarData>
ix.bar = {}

---[CLIENT]
---@TODO Document `ix.bar.Get`.
---@param identifier string
function ix.bar.Get(identifier) end

---[CLIENT]
---@TODO Document `ix.bar.Remove`
---@param identifier string
function ix.bar.Remove(identifier) end

---[CLIENT]
---@TODO Document `ix.bar.Add`.
---@param getValue fun(): number, string?
---@param color Color
---@param priority number?
---@param identifier string
---@return number priority The priority(order) of the bar.
function ix.bar.Add(getValue, color, priority, identifier) end

---[CLIENT]
function ix.bar.DrawAction() end
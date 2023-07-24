---@meta

---@class ix.currency
---@field symbol string The symbol of the currency. Defaults to `"$"`.
---@field singular string The name of the currency in it's singular form. Defaults to `"dollar"`.
---@field plural string The name of the currency in it's plurar form.
---@field model string The model of the currency entity. Defaults to `"models/props_lab/box01a.mdl"`.
ix.currency = {}

---[SHARED] Sets the currency type.
---@param symbol string The symbol of the currency.
---@param singular string The name of the currency in it's singular form.
---@param plural string The name of the currency in it's plural form.
---@param model string The model of the currency entity.
function ix.currency.Set(symbol, singular, plural, model) end

---[SHARED] Returns a formatted string according to the current currency.
---@param amount number The amount of cash being formatted.
---@return string #The formatted string.
function ix.currency.Get(amount) end

---[SERVER] Spawns an amount of cash at a specific location on the map.
---@param pos Vector The position of the money to be spawned.
---@param amount number The amount of cash being spawned.
---@param angle Angle The angle of the entity being spawned. Defaults to `angle_zero`.
---@return Entity #The spawned money entity.
function ix.currency.Spawn(pos, amount, angle) end
---@meta

---Item manipulation and helper functions.
---@class ix.item
---@field list table<string, Item>
---@field base table<string, Item>
---@field instances table<number, Item>
---@field inventories table<number, Inventory>
---@field inventoryTypes table
ix.item = {}

---[SERVER]
---@TODO Document `ix.item.Instance`.
function ix.item.Instance(index, uniqueID, itemData, x, y, callback, characterID, playerID) end

---[SHARED] Retrieves an item table.
---
---Example:
--- ```
--- print(ix.item.Get("example")) --> "item[example][0]"
--- ```
---@param identifier string Unique ID of the item
---@return Item #Item table
function ix.item.Get(identifier) end

---[SHARED]
---@TODO Document `ix.item.Load`.
function ix.item.Load(path, baseID, isBaseItem) end

---[SHARED]
---@TODO Document `ix.item.Register`.
---@return Item #Only if `luaGenerated` is true, else `nil`.
function ix.item.Register(uniqueID, baseID, isBaseItem, path, luaGenerated) end

---[SHARED]
---@TODO Document `ix.item.LoadFromDir`.
function ix.item.LoadFromDir(directory) end

---[SHARED]
---@TODO Document `ix.item.New`.
function ix.item.New(uniqueID, id) end

---@deprecated Use `ix.inventory.Get` instead
function ix.item.GetInv(...) return ix.inventory.Get(...) end

---@deprecated Use `ix.inventory.Register` instead
function ix.item.RegisterInv(...) return ix.inventory.Register(...) end

---@deprecated Use `ix.inventory.New` instead
function ix.item.NewInv(...) return ix.inventory.New(...) end

---@deprecated Use `ix.inventory.Create` instead
function ix.item.CreateInv(...) return ix.inventory.Create(...) end

---@deprecated Use `ix.inventory.Restore` instead
function ix.item.RestoreInv(...) return ix.inventory.Restore(...) end

---[SERVER]
---@TODO Document `ix.item.LoadItemByID`.
function ix.item.LoadItemByID(itemIndex) end

---[SERVER]
---@TODO Document `ix.item.PerformInventoryAction`.
function ix.item.PerformInventoryAction(client, action, item, invID, data) end

---[SERVER] Instances and spawns a given item type.
---@param uniqueID string Unique ID of the item
---@param position Vector The position in which the item's entity will be spawned
---@param callback? fun(item: Item, entity: Entity) Function to call when the item entity is created
---@param angles? Angle The angles at which the item's entity will spawn. Defaults to `angle_zero`.
---@param data? table Additional data for this item instance
function ix.item.Spawn(uniqueID, position, callback, angles, data) end
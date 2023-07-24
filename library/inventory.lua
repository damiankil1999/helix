---@meta

---Inventory manipulation and helper functions.
---@class ix.inventory
ix.inventory = {}

---[SHARED] Retrieves an inventory table.
---@param invID number Index of the inventory
---@return Inventory #Inventory table
function ix.inventory.Get(invID) end

---[SHARED]
---@TODO Document `ix.inventory.Create`.
---@return Inventory
function ix.inventory.Create(width, height, id) end

---[SERVER] Loads an inventory and associated items from the database into memory. If you are passing a table into `invID`, it
--- requires a table where the key is the inventory ID, and the value is a table of the width and height values.
---
---Example:
--- ```
--- ix.inventory.Restore({
--- 	[10] = {5, 5},
--- 	[11] = {7, 4}
--- })
--- -- inventories 10 and 11 with sizes (5, 5) and (7, 4) will be loaded
--- ```
---@param invID Inventory ID or table of inventory IDs
---@param width number Width of inventory (this is not used when passing a table to `invID`)
---@param height number Height of inventory (this is not used when passing a table to `invID`)
---@param callback? fun(inventory: Inventory) Function to call when inventory is restored. this is called for each inventory in the invID table.
function ix.inventory.Restore(invID, width, height, callback) end

---[SHARED]
---@TODO Document `ix.inventory.New`.
function ix.inventory.New(owner, invType, callback) end

---[SHARED]
---@TODO Document `ix.inventory.Register`.
function ix.inventory.Register(invType, w, h, isBag) end
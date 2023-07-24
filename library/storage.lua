---@meta

---Player manipulation of inventories.
---
---This library provides an easy way for players to manipulate other inventories. The only functions that you should need are
---`ix.storage.Open` and `ix.storage.Close`. When opening an inventory as a storage item, it will display both the given inventory
---and the player's inventory in the player's UI, which allows them to drag items to and from the given inventory.
---
---Example usage:
--- ```
--- ix.storage.Open(client, inventory, {
---		name = "Filing Cabinet",
---		entity = ents.GetByIndex(3),
---		bMultipleUsers = true,
---		searchText = "Rummaging...",
---		searchTime = 4
--- })
--- ```
ix.storage = {}

--- There are some parameters you can customize when opening an inventory as a storage object with `ix.storage.Open`.
---@class StorageInfoStructure
---Entity to "attach" the inventory to. This is used to provide a location for the inventory for
--- things like making sure the player doesn't move too far away from the inventory, etc. This can also be a `player` object.
---@field entity Entity
---@field id number The ID of the Inventory. This defaults to the inventory passed into `ix.Storage.Open`.
---@field name string Title to display in the UI when the inventory is open.
---@field bMultipleUsers? boolean Whether or not multiple players are allowed to view this inventory at the same time.
---@field bNoMoney? boolean Whether or not money should be shown in the storage or not.
---@field searchTime number How long the player has to wait before the inventory is opened.
---@field text string Text to display to the user while opening the inventory. If prefixed with `"@"`, it will display a language phrase.
---Called when a player who was accessing the inventory has closed it. The
--- argument passed to the callback is the player who closed it.
---@field OnPlayerClose? fun(client: Player)
---@field data? table Table of arbitrary data to send to the client when the inventory has been opened.

---[SERVER] Returns whether or not the given inventory has a storage context and is being looked at by other players.
---@param inventory Inventory Inventory to check
---@return boolean #Whether or not `inventory` is in use
function ix.storage.InUse(inventory) end

---[SERVER] Returns whether or not an inventory is in use by a specific player.
---@poaram inventory Inventory Inventory to check
---@param client Player Player to check
---@return boolean #Whether or not the player is using the given `inventory`
function ix.storage.InUseBy(inventory, client) end

---[SERVER] Creates a storage context on the given inventory.
---@param inventory Inventory Inventory to create a storage context for
---@param info StorageInfoStructure Information to store on the context
function ix.storage.CreateContext(inventory, info) end

---[SERVER] Removes a storage context from an inventory if it exists.
---@param inventory Inventory Inventory to remove a storage context from
function ix.storage.RemoveContext(inventory) end

---[SERVER] Synchronizes an inventory with a storage context to the given client.
---@param client Player Player to sync storage for
---@param inventory Inventory Inventory to sync storage for
function ix.storage.Sync(client, inventory) end

---[SERVER] Adds a receiver to a given inventory with a storage context.
---@param client Player Player to sync storage for
---@param inventory Inventory Inventory to sync storage for
---@param bDontSync? boolean Whether or not to skip syncing the storage to the client. If this is `true`, the storage panel will not show up for the player
function ix.storage.AddReceiver(client, inventory, bDontSync) end

---[SERVER] Removes a storage receiver and removes the context if there are no more receivers.
---@param client Player Player to remove from receivers
---@param inventory Inventory Inventory with storage context to remove receiver from
---@param bDontRemove? boolean Whether or not to skip removing the storage context if there are no more receivers
function ix.storage.RemoveReceiver(client, inventory, bDontRemove) end

---[SERVER] Makes a player open an inventory that they can interact with. This can be called multiple times on the same inventory,
--- if the info passed allows for multiple users.
---@param client Player Player to open the inventory for
---@param inventory Inventory Inventory to open
---@param info? StorageInfoStructure `StorageInfoStructure` describing the storage properties
function ix.storage.Open(client, inventory, info) end

---[SERVER] Forcefully makes clients close this inventory if they have it open.
---@param inventory Inventory Inventory to close
function ix.storage.Close(inventory) end
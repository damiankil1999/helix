---@meta

---Holds items within a grid layout.
---
---Inventories are an object that contains `Item`s in a grid layout. Every `Character` will have exactly one inventory attached to
--- it, which is the only inventory that is allowed to hold bags - any item that has its own inventory (i.e a suitcase). Inventories
--- can be owned by a character, or it can be individually interacted with as a standalone object. For example, the container plugin
--- attaches inventories to props, allowing for items to be stored outside of any character inventories and remain "in the world".
---@class Inventory
---@field slots table
---@field vars table<string, any>
---@field owner any
---@field protected receivers table<Player, boolean>
---@field noSave boolean?
local Inventory = {}

---[SHARED] Returns a string representation of this inventory.
---
---Example:
--- ```
--- print(ix.item.inventories[1]) --> "inventory[1]"
--- ```
---@return string
function Inventory:__tostring() end

---[SHARED] Initializes the inventory with the provided arguments.
---
---@param id number The `Inventory`'s database ID.
---@param width number The inventory's width.
---@param height number The inventory's height.
function Inventory:Initialize(id, width, height) end

---[SHARED] Returns this inventory's database ID. This is guaranteed to be unique.
---@return number #Unique ID of inventory
function Inventory:GetID() end

---[SHARED] Sets the grid size of this inventory.
--- You can call this, but you really shouldn't.
---@param width number New width of inventory
---@param height number New height of inventory
function Inventory:SetSize(width, height) end

---[SHARED] Returns the grid size of this inventory.
---@return number #Width of inventory
---@return number #Height of inventory
function Inventory:GetSize() end

---[SHARED] This is pretty good to debug/develop function to use.
--- Prints relevant data to the console.
---@param printPos? boolean Should the print include the position inside the inventory.
function Inventory:Print(printPos) end

---[SHARED] Searches the inventory to find any stacked items.
--- A common problem with developing, is that items will sometimes error out, or get corrupt.
--- Sometimes, the server knows things you don't while developing live
--- This function can be helpful for getting rid of those pesky errors.
function Inventory:FindError() end

---[SHARED] Prints out the id, width, height, slots and each item in each slot of an `Inventory`, used for debugging.
function Inventory:PrintAll() end

---[SHARED] Returns the player that owns this inventory.
---@return Player? #Owning player - `nil` If no connected player owns this inventory
function Inventory:GetOwner() end

---[SHARED] Sets the player that owns this inventory.
---@param owner Player The player to take control over the inventory.
---@param fullUpdate? boolean Whether or not to update the inventory immediately to the new owner.
function Inventory:SetOwner(owner, fullUpdate) end

---[SHARED] Checks whether a player has access to an inventory
--- You can call this, but you really shouldn't.
---@param client Player Player to check access for
---@return boolean #Whether or not the player has access to the inventory
function Inventory:OnCheckAccess(client) end

---[SHARED] Checks whether or not an `Item` can fit into the `Inventory` starting from `x` and `y`.
--- Internally used by FindEmptySlot, in most cases you are better off using that.
--- This function will search if all of the slots within `x + width` and `y + width` are empty,
--- ignoring any space the `Item` itself already occupies.
--- You can call this, but you really shouldn't.
---@param x number The beginning x coordinate to search for.
---@param y number The beginning y coordiate to search for.
---@param w number The `Item`'s width.
---@param h number The `Item`'s height.
---@param item2? Item An `Item`, if any, to ignore when searching.
---@return boolean
function Inventory:CanItemFit(x, y, w, h, item2) end

---[SHARED] Returns the amount of slots currently filled in the Inventory.
---@return number #The amount of slots currently filled.
function Inventory:GetFilledSlotCount() end

---[SHARED] Finds an empty slot of a specified width and height.
--- In most cases, to check if an `Item` can actually fit in the `Inventory`,
--- as if it can't, it will just return `nil`.
---
---FindEmptySlot will loop through all the slots for you, as opposed to `CanItemFit`
--- which you specify an `x` and `y` for.
--- this will call CanItemFit anyway.
--- If you need to check if an item will fit *exactly* at a position, you want CanItemFit instead.
---@see Inventory.CanItemFit
---@param w? number The width of the `Item` you are trying to fit.
---@param h? number The height of the `Item` you are trying to fit.
---@param onlyMain? boolean Whether or not to search any bags connected to this `Inventory`
---@return number? x The `x` coordinate that the `Item` can fit into - `nil` if the item doesn't fit.
---@return number y The `y` coordinate that the `Item` can fit into.
---@return Inventory? bagInv If the item was in a bag, it will return the inventory it was in.
function Inventory:FindEmptySlot(w, h, onlyMain) end

---[SHARED] Returns the item that currently exists within `x` and `y` in the `Inventory`.
--- Items that have a width or height greater than 0 occupy more than 1 x and y.
---@number x The `x` coordindate to search in.
---@number y The `y` coordinate to search in.
---@return Item?
function Inventory:GetItemAt(x, y) end

---[SHARED] Removes an item from the inventory.
---@param id number The item instance ID to remove
---@param bNoReplication? boolean Whether or not the item's removal should not be replicated
---@param bNoDelete? boolean Whether or not the item should not be fully deleted
---@param bTransferring? boolean Whether or not the item is being transferred to another inventory
---@return number x The X position that the item was removed from
---@return number y The Y position that the item was removed from
function Inventory:Remove(id, bNoReplication, bNoDelete, bTransferring) end

---[SHARED] Adds a player as a receiver on this `Inventory`
--- Receivers are players who will be networked the items inside the inventory.
---
---Calling this will *not* automatically sync it's current contents to the client.
--- All future contents will be synced, but not anything that was not synced before this is called.
---
---This function does not check the validity of `client`, therefore if `client` doesn't exist, it will error.
---@param client Player The player to add as a receiver.
function Inventory:AddReceiver(client) end

---[SHARED] The opposite of `AddReceiver`.
--- This function does not check the validity of `client`, therefore if `client` doesn't exist, it will error.
---@param client Player The player to remove from the receiver list.
function Inventory:RemoveReceiver(client) end

---[SHARED] Get all of the receivers this `Inventory` has.
--- Receivers are players to whom the items inside the inventory will be networked to.
---
---This function will automatically sort out invalid players for you.
---@return Player[] receivers The players who are on the server and allowed to see this table.
function Inventory:GetReceivers() end

---[SHARED] Returns a count of a *specific* `Item` in the `Inventory`
--- ```
--- local curHighest, winner = 0, false
--- for client, character in ix.util.GetCharacters() do
--- 	local itemCount = character:GetInventory():GetItemCount('water', false)
--- 	if itemCount > curHighest then
--- 		curHighest = itemCount
--- 		winner = character
--- 	end
--- end
--- -- Finds the thirstiest character on the server and returns their Character ID or false if no character has water.
--- ```
---@param uniqueID string The Unique ID of the item.
---@param onlyMain? boolean Whether or not to exclude bags that are present from the search.
---@return number #The amount of `Item`s this inventory has.
function Inventory:GetItemCount(uniqueID, onlyMain) end

---[SHARED] Returns a table of all `Item`s in the `Inventory` by their Unique ID.
--- Not to be confused with `GetItemsByID` or `GetItemByID` which take in an Item Instance's ID instead.
---@param uniqueID string The Unique ID of the item.
---@param onlyMain? boolean Whether or not to exclude bags that are present from the search.
---@return Item[] #The table of specified `Item`s this inventory has.
function Inventory:GetItemsByUniqueID(uniqueID, onlyMain) end

---[SHARED] Returns a table of `Item`s by their base.
---@param baseID string The base to search for.
---@param bOnlyMain? boolean Whether or not to exclude bags that are present from the search.
---@return Item[]
function Inventory:GetItemsByBase(baseID, bOnlyMain) end

---[SHARED] Get an `Item` by it's specific Database ID.
---@param id number The ID to search for.
---@param onlyMain? boolean Whether or not to exclude bags that are present from the search.
---@return Item? #The item if it exists.
function Inventory:GetItemByID(id, onlyMain) end

---[SHARED] Get a table of `Item`s by their specific Database ID.
--- It's important to note that while in 99% of cases,
--- items will have a unique Database ID, developers or random GMod weirdness could
--- cause a second item with the same ID to appear, even though, `ix.item.instances` will only store one of those.
--- The inventory only stores a reference to the `ix.item.instance` ID, not the memory reference itself.
---@param id number The ID to search for.
---@param onlyMain boolean? Whether or not to exclude bags that are present from the search.
---@return Item[] #The items if they exists.
function Inventory:GetItemsByID(id, onlyMain) end

---[SHARED] Returns a table of all the items that an `Inventory` has.
---@see Inventory.Iter if you are going to loop through them.
---@param onlyMain? boolean Whether or not to exclude bags from this search.
---@return table<number, Item> #Dictionary of items this `Inventory` has, keyed by their id.
function Inventory:GetItems(onlyMain) end

---[SHARED] Returns an iterator that returns all contained items, a better way to iterate items than `pairs(inventory:GetItems())`
---
--Example:
--- ```
--- for item, x, y in ix.char.loaded[1]:GetInventory():Iter() do
--- 	print(item, x, y)
--- end
--- -- Print all items, x and y pos of the first character's inventory.
--- ```
---@return fun(): Item?, number, number iterator
function Inventory:Iter() end

---[SHARED] Returns a table of all inventory ids that contained items have.
--- This function may pretty heavy.
---@return number[] #The inventory ids attached to this inventory.
function Inventory:GetBags() end

---[SHARED] Returns the item with the given unique ID (e.g `"handheld_radio"`) if it exists in this inventory.
--- This method checks both this inventory, and any bags that this inventory has inside of it.
---
---Example:
--- ```
--- local item = inventory:HasItem("handheld_radio")
---
--- if (item) then
--- 	-- do something with the item table
--- end
--- ```
---@see Inventory.HasItems
---@see Inventory.HasItemOfBase
---@param targetID string Unique ID of the item to look for
---@param data? table<string, any> Item data to check for
---@return Item|false #Item that belongs to this inventory with the given criteria - `false` if the item does not exist
function Inventory:HasItem(targetID, data) end

---[SHARED] Checks whether or not the `Inventory` has a table of items.
--- This function takes a table with **no** keys and runs in order of first item > last item,
--- this is due to the usage of the `#` operator in the function.
---
---Example:
--- ```
--- local itemFilter = {'water', 'water_sparkling'}
--- if not Player(1):GetCharacter():GetInventory():HasItems(itemFilter) then return end
--- -- Filters out if this player has both a water, and a sparkling water.
--- ```
---@param targetIDs string[] A table of `Item` Unique ID's.
---@return boolean #Whether or not the `Inventory` has all of the items.
---@return string[] targetIDs Table consisting of the items the `Inventory` did **not** have.
function Inventory:HasItems(targetIDs) end

---[SHARED] Whether or not an `Inventory` has an item of a base, optionally with specified data.
--- This function has an optional `data` argument, which will take a `table`.
--- it will match if the data of the item is correct or not.
---
---Items which are a base will automatically have base_ prefixed to their Unique ID, if you are having
--- trouble finding your base, that is probably why.
---
---Example:
--- ```
--- local bHasWeaponEquipped = Entity(1):GetCharacter():GetInventory():HasItemOfBase('base_weapons', {['equip'] = true})
--- if bHasWeaponEquipped then
---  Entity(1):Notify('One gun is fun, two guns is Woo-tastic.')
--- end
--- -- Notifies the player that they should get some more guns.
--- ```
---@param baseID string The Item Base's Unique ID.
---@param data? table<string, any> The Item's data to compare against.
---@return Item|false #The first `Item` of `baseID` that is found and there is no `data` argument or `data` was matched.
function Inventory:HasItemOfBase(baseID, data) end

---[SERVER] Sends a specific slot to a character.
--- This will *not* send all of the slots of the `Item` to the character, items can occupy multiple slots.
---
---This will call `OnSendData` on the Item using all of the `Inventory`'s receivers.
---
---This function should *not* be used to sync an entire inventory, if you need to do that, use `AddReceiver` and `Sync`.
--- You can call this, but you really shouldn't.
---@see Inventory.AddReceiver
---@see Inventory.Sync
---@param x number The Inventory x position to send.
---@param y number The Inventory y position to send.
---@param item Item? The item to send, if any.
function Inventory:SendSlot(x, y, item) end

---[SERVER] Sets whether or not an `Inventory` should save.
--- This will prevent an `Inventory` from updating in the Database, if the inventory is already saved,
--- it will not be deleted when unloaded.
---@param bNoSave? boolean Whether or not the Inventory should save.
function Inventory:SetShouldSave(bNoSave) end

---[SERVER] Gets whether or not an `Inventory` should save.
--- Inventories that are marked to not save will not update in the Database, if they inventory is already saved,
--- it will not be deleted when unloaded.
---@return boolean #Returns the field `noSave` - `true` if the field `noSave` is not registered to this inventory.
function Inventory:GetShouldSave() end

---[SERVER] Add an item to the inventory.
---@see ix.item.Instance
---@param uniqueID number|string The item unique ID (e.g `"handheld_radio"`) or instance ID (e.g `1024`) to add to the inventory
---@param quantity? number The quantity of the item to add. Defaults to `1`.
---@param data? table<string, any> Item data to add to the item
---@param x? number The X position for the item
---@param y? number The Y position for the item
---@param noReplication? boolean Whether or not the item's addition should not be replicated
---@return boolean|number #Whether the add was successful or not - or `X` position.
---@return string|number #The error, if applicable - or `Y` position.
---@return number? #The inventory ID that the item was added to
function Inventory:Add(uniqueID, quantity, data, x, y, noReplication) end

---[SERVER] Syncs the `Inventory` to the receiver.
--- This will call `Item.OnSendData` on every item in the `Inventory`.
---@param receiver Player The player to sync the data to.
function Inventory:Sync(receiver) end
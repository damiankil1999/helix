---@meta

---@class ItemFunctionStructure
---@field name string Language phrase to use when displaying this item function's name in the UI. If not specified, then it will use the unique ID of the item function
---@field tip string Language phrase to use when displaying this item function's detailed description in the UI
---@field icon string Path to the material to use when displaying this item function's icon
---@field OnRun fun(item: Item): boolean Function to call when the item function is ran. This function is **ONLY** ran on the server. The item will be removed after the item function is ran. If you want to prevent this behaviour, then you can return `false` in this function.
---@field OnCanRun fun(item: Item): boolean Function to call when checking whether or not this item function can be ran. This function is ran **BOTH** on the client and server.
---@field OnClick? fun(item: Item): boolean This function is called when the player clicks on this item function's entry in the UI. This function is ran **ONLY** on the client, and is only ran if `OnCanRun` succeeds. Returning `true` will allow the item function to be ran. Returning `false` will prevent it from running and additionally hide it from the UI.

---Changing the way an item's icon is rendered is done by modifying the location and angle of the model, as well as the FOV of the
--- camera. You can tweak the values in code, or use the `ix_dev_icon` console command to visually position the model and camera.
---
---An example entry for an item's icon is below:
--- ```
--- ITEM.iconCam = {
--- 	pos = Vector(0, 0, 60),
--- 	ang = Angle(90, 0, 0),
--- 	fov = 45
--- }
--- ```
---Note that this will probably not work for your item's specific model, since every model has a different size, origin, etc. All
---item icons need to be tweaked individually.
---@class ItemIconStructure
---@field pos Vector Location of the model relative to the camera. +X is forward, +Z is up
---@field ang Angle Angle of the model
---@field fov number FOV of the camera

---Interactable entities that can be held in inventories.
---
---Items are objects that are contained inside of an `Inventory`, or as standalone entities if they are dropped in the world. They
---usually have functionality that provides more gameplay aspects to the schema. For example, the zipties in the HL2 RP schema
---allow a player to tie up and search a player.
---
---For an item to have an actual presence, they need to be instanced (usually with `ix.item.Instance`). Items describe the
---properties, while instances are a clone of these properties that can have their own unique data (e.g an ID card will have the
---same name but different numerical IDs). You can think of items as the class, while instances are objects of the `Item` class.
---
---## Creating item classes (`ItemStructure`)
---Item classes are defined in their own file inside of your schema or plugin's `items/` folder. In these item class files you
---specify how instances of the item behave. This includes default values for basic things like the item's name and description,
---to more advanced things by overriding extra methods from an item base. See `ItemStructure` for information on how to define
---a basic item class.
---
---Item classes in this folder are automatically loaded by Helix when the server starts up.
---
---## Item bases
---If many items share the same functionality (i.e a can of soda and a bottle of water can both be consumed), then you might want
---to consider using an item base to reduce the amount of duplication for these items. Item bases are defined the same way as
---regular item classes, but they are placed in the `items/base/` folder in your schema or plugin. For example, a `consumables`
---base would be in `items/base/sh_consumables.lua`.
---
---Any items that you want to use this base must be placed in a subfolder that has the name of the base you want that item to use.
---For example, for a bottled water item to use the consumable base, it must be placed in `items/consumables/sh_bottled_water.lua`.
---This also means that you cannot place items into subfolders as you wish, since the framework will try to use an item base that
---doesn't exist.
---
---The default item bases that come with Helix are:
---
---  - `ammo` - provides ammo to any items with the `weapons` base
---  - `bags` - holds an inventory that other items can be stored inside of
---  - `outfit` - changes the appearance of the player that wears it
---  - `pacoutfit` - changes the appearance of the player that wears it using PAC3
---  - `weapons` - makes any SWEP into an item that can be equipped
---
---These item bases usually come with extra values and methods that you can define/override in order to change their functionality.
---You should take a look at the source code for these bases to see their capabilities.
---
---## Item functions (`ItemFunctionStructure`)
---Requiring players to interact with items in order for them to do something is quite common. As such, there is already a built-in
---mechanism to allow players to right-click items and show a list of available options. Item functions are defined in your item
---class file in the `ITEM.functions` table. See `ItemFunctionStructure` on how to define them.
---
---Helix comes with `drop`, `take`, and `combine` item functions by default that allows items to be dropped from a player's
---inventory, picked up from the world, and combining items together. These can be overridden by defining an item function
---in your item class file with the same name. See the `bags` base for example usage of the `combine` item function.
---
---## Item icons (`ItemIconStructure`)
---Icons for items sometimes don't line up quite right, in which case you can modify an item's `iconCam` value and line up the
---rendered model as needed. See `ItemIconStructure` for more details.
---@class Item
---@field name string Display name of the item
---@field description string Detailed description of the item
---@field model string Model to use for the item's icon and when it's dropped in the world
---@field width number Width of the item in grid cells. Defaults to `1`.
---@field height number Height of the item in grid cells. Defaults to `1`.
---@field price? number? How much money it costs to purchase this item in the business menu
---@field category? string? Name of the category this item belongs to - mainly used for the business menu
---@field noBusiness? boolean? Whether or not to disallow purchasing this item in the business menu
---@field factions? string[]? List of factions allowed to purchase this item in the business menu
---@field classes? string[]? List of character classes allowed to purchase this item in the business menu. Classes are checked after factions, so the character must also be in an allowed faction
---@field flag? string? List of flags (as a string - e.g `"a"` or `"abc"`) allowed to purchase this item in the business menu. Flags are checked last, so the character must also be in an allowed faction and class
---@field iconCam? ItemIconStructure? How to render this item's icon
---@field entity? Entity This is only set if an function is being ran by a player and the item is in the world.
---@field player? Player This is only set if an function is being ran by a player.
---@field base string
---@field id number
---@field isBase boolean
---@field uniqueID string
---@field functions table<string, ItemFunctionStructure> The `drop` and `take` function are on all items.
---@field plugin? string Automatically set if the item was registered by a plugin, this contains the plugin's uniqueID.
---@field baseTable Item
---@field hooks table<string, function>
---@field postHooks table<string, function>
local Item = {}

---[SHARED] Returns a string representation of this item.
--- ```
--- print(ix.item.instances[1]) --> "item[1]"
--- ```
---@return string #String representation
function Item:__tostring() end

---[SHARED] Returns true if this item is equal to another item. Internally, this checks item IDs.
---```
--- print(ix.item.instances[1] == ix.item.instances[2]) --> false
--- ```
---@param other Item Item to compare to
---@return boolean #Whether or not this item is equal to the given item
function Item:__eq(other) end

---[SHARED] Returns this item's database ID. This is guaranteed to be unique.
---@return number #Unique ID of item
function Item:GetID() end

---[SHARED] Returns the name of the item.
---@return string #The name of the item
function Item:GetName() end

---[SHARED] Returns the description of the item.
---@return string #The description of the item
function Item:GetDescription() end

---[SHARED] Returns the model of the item.
---@return string #The model of the item
function Item:GetModel() end

---[SHARED] Returns the skin of the item.
---@return number #The skin of the item
function Item:GetSkin() end

---[SHARED]
---@deprecated Use `Item.model` instead.
function Item:GetMaterial() end

---[SHARED] Returns the ID of the owning character, if one exists.
---@return number #The owning character's ID
function Item:GetCharacterID() end

---[SHARED] Returns the SteamID64 of the owning player, if one exists.
---@return number #The owning player's SteamID64
function Item:GetPlayerID() end

---[SHARED] A utility function which prints the item's details.
---@param detail? boolean Whether additional detail should be printed or not(Owner, X position, Y position)
function Item:Print(detail) end

---[SHARED] A utility function printing the item's stored data.
function Item:PrintData() end

---[SHARED] Calls one of the item's methods.
---@param method string The method to be called
---@param client Player The client to pass when calling the method, if applicable
---@param entity Entity The entity to pass when calling the method, if applicable
---@param ... any #Arguments to pass to the method
---@return any #The values returned by the method
function Item:Call(method, client, entity, ...) end

---[SHARED] Returns the player that owns this item.
---@return Player? player Player owning this item
function Item:GetOwner() end

---[SHARED] Sets a key within the item's data.
---@param key string The key to store the value within
---@param value any The value to store within the key
---@param receivers? Player[]|false The players to replicate the data on. Defaults to `GetOwner()`
---@param noSave? boolean Whether to disable saving the data on the database or not
---@param noCheckEntity? boolean Whether to disable setting the data on the entity, if applicable
function Item:SetData(key, value, receivers, noSave, noCheckEntity) end

---[SHARED] Returns the value stored on a key within the item's data.
---@param key string The key in which the value is stored
---@param default any The value to return in case there is no value stored in the key
---@return any #The value stored within the key
function Item:GetData(key, default) end

---[SHARED] Changes the function called on specific events for the item.
---@param name string The name of the hook
---@param func function The function to call once the event occurs
function Item:Hook(name, func) end

---[SHARED] Changes the function called after hooks for specific events for the item.
---@param name string The name of the hook
---@param func function The function to call after the original hook was called
function Item:PostHook(name, func) end

---[SHARED] Removes the item.
---@param bNoReplication? boolean Whether or not the item's removal should not be replicated.
---@param bNoDelete? boolean Whether or not the item should not be fully deleted
---@return boolean #Whether the item was successfully deleted or not
function Item:Remove(bNoReplication, bNoDelete) end

---[SERVER] Returns the item's entity.
---@return Entity? #The entity of the item
function Item:GetEntity() end

---[SERVER] Spawn an item entity based off the item table.
---@param position Vector|Player The position in which the item's entity will be spawned
---@param angles Angle The angles at which the item's entity will spawn
---@return Entity? #The spawned entity
function Item:Spawn(position, angles) end

---[SERVER] Transfers an item to a specific inventory.
---@param invID? number The inventory to transfer the item to
---@param x? number The X position to which the item should be transferred on the new inventory
---@param y? number The Y position to which the item should be transferred on the new inventory
---@param client? Player The player to which the item is being transferred
---@param noReplication? boolean Whether there should be no replication of the transferral
---@param isLogical? boolean Whether or not an entity should spawn if the item is transferred to the world
---@return boolean #Whether the transfer was successful or not
---@return string? #The error, if applicable
function Item:Transfer(invID, x, y, client, noReplication, isLogical) end

---[SHARED]
---@TODO Document `Item.OnRegistered`.
function Item:OnRegistered() end
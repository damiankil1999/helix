---@meta

--- You'll need to pass a table of options to `ix.menu.Open` to populate the menu. This table consists of strings as its keys
--- and functions as its values. These correspond to the text displayed in the menu and the callback to run, respectively.
---
---Example usage:
--- ```
--- ix.menu.Open({
--- 	Drink = function()
--- 		print("Drink option selected!")
--- 	end,
--- 	Take = function()
--- 		print("Take option selected!")
--- 	end
--- }, ents.GetByIndex(1))
--- ```
---This opens a menu with the options `"Drink"` and `"Take"` which will print a message when you click on either of the options.
---@alias MenuOptionsStructure table<string, fun()>

---Entity menu manipulation.
---
---The `menu` library allows you to open up a context menu of arbitrary options whose callbacks will be ran when they are selected
--- from the panel that shows up for the player.
ix.menu = {}

---[CLIENT] Opens up a context menu for the given entity.
---@param options MenuOptionsStructure Data describing what options to display
---@param entity? Entity Entity to send commands to
---@return boolean #Whether or not the menu opened successfully. It will fail when there is already a menu open.
function ix.menu.Open(options, entity) end

---[CLIENT] Checks whether or not an entity menu is currently open.
---@return boolean #Whether or not an entity menu is open
function ix.menu.IsOpen() end

---[CLIENT] Notifies the server of an option that was chosen for the given entity.
---@param entity Entity Entity to call option on
---@param choice string Option that was chosen
---@param data any Extra data to send to the entity
function ix.menu.NetworkChoice(entity, choice, data) end
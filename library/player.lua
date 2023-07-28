---@meta

---@class Player
local Player = {}

---[SHARED] Helix overwrites `Player.SteamID64()`. This is the original function.
---@protected
---@see Player.SteamID64
---@return string
function Player:ixSteamID64() end

---[SERVER] Forces this player's model to play an animation sequence. It also prevents the player from firing their weapon while the animation is playing.
---@see Player.LeaveSequence
---@param sequence string Name of the animation sequence to play
---@param callback? function Function to call when the animation finishes. This is also called immediately if the animation fails to play
---@param time? number How long to play the animation for. This defaults to the duration of the animation
---@param bNoFreeze? boolean Whether or not to avoid freezing this player in place while the animation is playing
function Player:ForceSequence(sequence, callback, time, bNoFreeze) end

---[SERVER] Forcefully stops this player's model from playing an animation that was started by `ForceSequence`.
---@see Player.ForceSequence
function Player:LeaveSequence() end

---[SHARED] Helix overwrites `Player.Name`. This will return the original name of the player.
---@see Player.Name
function Player:SteamName() end

---[SHARED] Returns this player's currently possessed `Character` object if it exists.
---@return Character? #Currently loaded character.
function Player:GetCharacter() end

Player.GetChar = Player.GetCharacter

---[SHARED] Returns the player's current name.
---@return string #Name of this player's currently loaded character - Steam name of the player if it has no character loaded.
function Player:GetName() end

Player.Nick = Player.GetName
Player.Name = Player.GetName

---[CLIENT]
---@TODO Document `Player.GetEntityMenu`
function Player:GetEntityMenu() end

---[SERVER]
---@TODO Document `Player.OnOptionSelected`
function Player:OnOptionSelected() end

---[SHARED] Displays a prominent notification in the top-right of this player's screen.
--- If called clientside, there will be no difference when calling this on players other than the `LocalPlayer()`
---@see ix.util.Notify
---@param message string Text to display in the notification.
function Player:Notify(message) end

---[SHARED] Displays a notification for this player with the given language phrase
--- If called clientside, there will be no difference when calling this on players other than the `LocalPlayer()`
---
---Example:
--- ```
--- Player(1):NotifyLocalized("mapRestarting", 10)
--- -- This displays "The map will restart in 10 seconds!" if the language is set to English
--- ```
---@see ix.lang.AddTable
---@see ix.util.NotifyLocalized
---@param message string ID of the language phrase.
---@param ... any #Arguments passed to the language pharser.
function Player:NotifyLocalized(message, ...) end

---[SHARED] Displays a notification for this player in the chatbox.
--- If called clientside, there will be no difference when calling this on players other than the `LocalPlayer()`
---@param message string Text to display in the notification
function Player:ChatNotify(message) end

---[SHARED] Displays a notification for this player in the chatbox with the given language phrase.
---@see Player.NotifyLocalized
---@param message string ID of the language phrase.
---@param ... any #Arguments passed to the language pharser.
function Player:ChatNotifyLocalized(message, ...) end

---[SHARED]
---@TODO Document `Player.GetData`
---@param key string
---@param default? any
function Player:GetData(key, default) end

---[SHARED]
---@TODO Document `Player.HasWhitelist`
function Player:HasWhitelist(faction) end

---[SHARED] Shortcut to get the player's current character's inventory items.
--- If you already have the character or inventory local you really should use that instead.
---@see Inventory.GetItems
---@see Inventory.Iter If you want to loop over the item table.
---@return table<number, Item>
function Player:GetItems() end

---[SHARED] Shortcut to get the player's class' data.
---@see ix.class.list
---@see Character.GetClass
---@TODO ClassData
function Player:GetClassData() end

---[SERVER] Helix overwrites `Player.SelectWeapon`. This is the original function.
---@protected
---@see Player.SelectWeapon
---@param className string Weapon classname
function Player:ixSelectWeapon(className) end

---[SERVER] Synchronizes networked variables to the client.
---@protected
function Player:SyncVars() end

---[SHARED] Retrieves a local networked variable. If it is not set, it'll return the default that you've specified.
--- Locally networked variables can only be retrieved from the owning player when used from the client.
---
---Example:
--- ```
--- print(client:GetLocalVar("secret")) --> 12345678
--- ```
---@see Player.SetLocalVar
---@param key string Identifier of the local variable
---@param default? any Default value to return if the local variable is not set
---@return any #Value associated with the key, or the default that was given if it doesn't exist
function Player:GetLocalVar(key, default) end

---[SERVER] Sets the value of a local networked variable.
---
---Example:
--- ```
--- client:SetLocalVar("secret", 12345678)
--- ```
---@see Player.GetLocalVar
---@param key string Identifier of the local variable
---@param value? any New value to assign to the local variable
function Player:SetLocalVar(key, value) end

---[SERVER]
---@TODO Document `Player.LoadData`
---@see Player.SetData
---@see Player.GetData
---@param callback fun(data?: table)
function Player:LoadData(callback) end

---[SERVER]
---@TODO Document `Player.SaveData`
---@see Player.SetData
---@see Player.GetData
function Player:SaveData() end

---[SERVER]
---@TODO Document `Player.SetData`
---@see Player.GetData
---@see Player.SaveData
---@param key string
---@param value any
---@param bNoNetworking? boolean
function Player:SetData(key, value, bNoNetworking) end

---[SERVER]
---@TODO Document `Player.SetWhitelisted`
---@param faction any
---@param whitelisted? boolean
function Player:SetWhitelisted(faction, whitelisted) end

---[SERVER] Helix overwrites `Player.Give()`. This is the original function.
---@protected
---@see Player.Give
---@return Weapon
function Player:ixGive(className, bNoAmmo) end

---[SHARED] Returns the amount of time the player has played on the server.
---@return number #Number of seconds the player has played on the server
function Player:GetPlayTime() end

---[SHARED] Returns `true` if the player has their weapon raised.
---@return boolean #Whether or not the player has their weapon raised
function Player:IsWepRaised() end

---[SHARED] Returns `true` if the player is restricted - that is to say that they are considered "bound" and cannot interact with
--- objects normally (e.g hold weapons, use items, etc). An example of this would be a player in handcuffs.
---@return boolean #Whether or not the player is restricted
function Player:IsRestricted() end

---[SHARED] Returns `true` if the player is able to shoot their weapon.
---@return boolean #Whether or not the player can shoot their weapon
function Player:CanShootWeapon() end

---[SHARED] Returns `true` if the player is running. Running in this case means that their current speed is greater than their
--- regularly set walk speed.
---@return boolean #Whether or not the player is running
function Player:IsRunning() end

---[SHARED] Returns `true` if the player currently has a female model. This checks if the model has `female`, `alyx` or `mossman` in its
--- name, or if the player's model class is `citizen_female`.
---@return boolean #Whether or not the player has a female model
function Player:IsFemale() end

---[SHARED] Whether or not this player is stuck and cannot move.
---@return boolean #Whether or not this player is stuck
function Player:IsStuck() end

---[SHARED] Returns a good position in front of the player for an entity to be placed. This is usually used for item entities.
---
---Example:
--- ```
--- local position = client:GetItemDropPos(entity)
--- entity:SetPos(position)
--- ```
---@param entity Entity Entity to get a position for
---@return Vector #Best guess for a good drop position in front of the player
function Player:GetItemDropPos(entity) end

---[SHARED] Performs a time-delay action that requires this player to look at an entity. If this player looks away from the entity
--- before the action timer completes, the action is cancelled. This is usually used in conjunction with `SetAction` to display
--- progress to the player.
---
---Example:
--- ```
--- client:SetAction("Searching...", 4) -- for displaying the progress bar
--- client:DoStaredAction(entity, function()
--- 	print("hello!")
--- end)
--- -- prints "hello!" after looking at the entity for 4 seconds
--- ```
---@see Player.SetAction
---@param entity Entity that this player must look at
---@param callback function Function to call when the timer completes
---@param time number How much time in seconds this player must look at the entity for
---@param onCancel? function Function to call when the timer has been cancelled
---@param distance? number Maximum distance a player can move away from the entity before the action is cancelled. Defaults to `96`.
function Player:DoStaredAction(entity, callback, time, onCancel, distance) end

---[SHARED] Resets all bodygroups this player's model has to their defaults (`0`).
function Player:ResetBodygroups() end

---[SERVER] Sets whether or not this player's current weapon is raised.
---@param bState boolean Whether or not the raise the weapon
---@param weapon? Weapon Weapon to raise or lower. You should pass this argument if you already have a reference to this player's current weapon to avoid an expensive lookup for this player's current weapon.
function Player:SetWepRaised(bState, weapon) end

---[SERVER] Inverts this player's weapon raised state. You should use `SetWepRaised` instead of this if you already have a reference to this player's current weapon.
function Player:ToggleWepRaised() end

---[SERVER] Performs a delayed action that requires this player to hold use on an entity. This is displayed to this player as a
--- closing ring over their crosshair.
---@param time number How much time in seconds this player has to hold use for
---@param entity Entity Entity that this player must be looking at
---@param callback fun(self: Player): boolean? Function to run when the timer completes. It will be ran right away if `time` is `0`. Returning `false` in the callback will not mark this interaction as dirty if you're managing the interaction state manually.
function Player:PerformInteraction(time, entity, callback) end

---[SERVER] Displays a progress bar for this player that takes the given amount of time to complete.
---@param text? string|false Text to display above the progress bar. If `nil` clears the current action but keeps the callback queued, if `false` will also remove the callback.
---@param time? number How much time in seconds to wait before the timer completes. Defaults to `5`.
---@param callback? fun(self: Player) Function to run once the timer completes
---@param startTime? number Game time in seconds that the timer started. If you are using `time`, then you shouldn't use this argument. Defaults to `CurTime()`.
---@param finishTime? number Game time in seconds that the timer should complete at. If you are using `time`, then you shouldn't use this argument. Defaults to `startTime + time`.
function Player:SetAction(text, time, callback, startTime, finishTime) end

---[SERVER] Opens up a text box on this player's screen for input and returns the result. Remember to sanitize the user's input if
--- it's needed!
---
---Example:
--- ```
--- client:RequestString("Hello", "Please enter your name", function(text)
--- 	client:ChatPrint("Hello, " .. text)
--- end)
--- -- prints "Hello, <text>" in the player's chat
--- ```
---@param title string Title to display on the panel
---@param subTitle string Subtitle to display on the panel
---@param callback fun(input: string) Function to run when this player enters their input. Callback is ran with the user's input string.
---@param default? string Default value to put in the text box.
function Player:RequestString(title, subTitle, callback, default) end

---[SERVER] Sets this player's restricted status.
---@param bState? boolean Whether or not to restrict this player
---@param bNoMessage? boolean Whether or not to suppress the restriction notification
function Player:SetRestricted(bState, bNoMessage) end

---[SERVER] Creates a ragdoll entity of this player that will be synced with clients. This does **not** affect the player like
--- `SetRagdolled` does.
---@param bDontSetPlayer? boolean Whether or not to avoid setting the ragdoll's owning player
---@return Entity entity Created ragdoll entity
function Player:CreateServerRagdoll(bDontSetPlayer) end

---[SERVER] Sets this player's ragdoll status.
---@param bState? boolean Whether or not to ragdoll this player
---@param time? number How long this player should stay ragdolled for. Set to `0` if they should stay ragdolled until they get back up manually. Defaults to `0`.
---@param getUpGrace? number How much time in seconds to wait before the player is able to get back up manually. Set to the same number as `time` to disable getting up manually entirely. Defaults to `5`.
function Player:SetRagdolled(bState, time, getUpGrace) end

---[SHARED] Get the player's PAC3 Parts managed by helix.
---@TODO Document `Player.GetParts`
---@return table
function Player:GetParts() end

---[SERVER] Adds PAC part using the item's PAC data.
---@TODO Document `Player.AddPart`
function Player:AddPart(uniqueID, item) end

---[SERVER] Removes PAC part that was added by an helix item.
---@TODO Document `Player.RemovePart`
function Player:RemovePart(uniqueID) end

---[SERVER]
---@TODO Document `Player.ResetParts`
function Player:ResetParts() end

---[CLIENT]
---@TODO Document `Player.CanOverrideView`
---@return boolean?
function Player:CanOverrideView() end

---[SHARED] Returns the current area the player is in, or the last valid one if the player is not in an area
---@TODO Document `Player.GetArea`
function Player:GetArea() end

---[SHARED] Returns true if the player is in any area, this does not use the last valid area like GetArea does
---@TODO Document `Player.IsInArea`
function Player:IsInArea() end

---[SERVER]
---@TODO Document `Player.RestoreStamina`
function Player:RestoreStamina(amount) end

---[SERVER]
---@TODO Document `Player.ConsumeStamina`
function Player:ConsumeStamina(amount) end
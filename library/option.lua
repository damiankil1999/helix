---@meta

---You can specify additional optional arguments for `ix.option.Add` by passing in a table of specific fields as the fourth
---@class OptionStructure
---@field key string
---The phrase to use when displaying in the UI. The default value is your option
--- key in UpperCamelCase, prefixed with `"opt"`. For example, if your key is `"exampleOption"`, the default phrase will be
--- `"optExampleOption"`.
---@field phrase string
---The phrase to use in the tooltip when hovered in the UI. The default
--- value is your option key in UpperCamelCase, prefixed with `"optd"`. For example, if your key is `"exampleOption"`, the
--- default phrase will be `"optdExampleOption"`.
---@field description string
---The category that this option should reside in. This is purely for
--- aesthetic reasons when displaying the options in the options menu. When displayed in the UI, it will take the form of
--- `L("category name")`. This means that you must create a language phrase for the category name - otherwise it will only
--- show as the exact string you've specified. If no category is set, it will default to `"misc"`.
---@field category string
---The minimum allowed amount when setting this option. This field is not
--- applicable to any type other than `ix.type.number`. Defaults to `0`.
---@field min number
---The maximum allowed amount when setting this option. This field is not
--- applicable to any type other than `ix.type.number`. Defaults to `10`.
---@field max number
---How many decimals to constrain to when using a number type. This field is not
--- applicable to any type other than `ix.type.number`. Defaults to `0`.
---@field decimals? number
---@field bNetworked? boolean Whether or not the server should be aware of this option for each client.
---The function to run when this option is changed - this includes whether it was set
--- by the player, or through code using `ix.option.Set`.
--- ```
--- OnChanged = function(oldValue, value)
--- 	print("new value is", value)
--- end
--- ```
---@field OnChanged? fun(oldValue: any, value: any)
---@field hidden? fun(): boolean The function to check whether the option should be hidden from the options menu.
---The function to run when the option needs to be added to the menu. This is a required
--- field for any array options. It should return a table of entries where the key is the value to set in `ix.option.Set`,
--- and the value is the display name for the entry. An example:
--- ```
--- populate = function()
--- 	return {
--- 		["english"] = "English",
--- 		["french"] = "French",
--- 		["spanish"] = "Spanish"
--- 	}
--- end
--- ```
---@field populate? fun(): table<string, string>

---Client-side configuration management.
---
---The `option` library provides a cleaner way to manage any arbitrary data on the client without the hassle of managing CVars. It
--- is analagous to the `ix.config` library, but it only deals with data that needs to be stored on the client.
---
---To get started, you'll need to define an option in a client realm so the framework can be aware of its existence. This can be
--- done in the `cl_init.lua` file of your schema, or in an `if (CLIENT) then` statement in the `sh_plugin.lua` file of your plugin:
---	ix.option.Add("headbob", ix.type.bool, true)
---
---If you need to get the value of an option on the server, you'll need to specify `true` for the `bNetworked` argument in
--- `ix.option.Add`. *NOTE:* You also need to define your option in a *shared* realm, since the server now also needs to be aware
--- of its existence. This makes it so that the client will send that option's value to the server whenever it changes, which then
--- means that the server can now retrieve the value that the client has the option set to. For example, if you need to get what
--- language a client is using, you can simply do the following:
---	ix.option.Get(player.GetByID(1), "language", "english")
---
---This will return the language of the player, or `"english"` if one isn't found. Note that `"language"` is a networked option
--- that is already defined in the framework, so it will always be available. All options will show up in the options menu on the
--- client, unless `hidden` returns `true` when using `ix.option.Add`.
---
---Note that the labels for each option in the menu will use a language phrase to show the name. For example, if your option is
--- named `headbob`, then you'll need to define a language phrase called `optHeadbob` that will be used as the option title.
---@class ix.option
---@field stored table<string, OptionStructure>
---@field categories table<string, string[]>
---@field clients table<string, table<string, any>>
ix.option = {}

---[SHARED] Creates a client-side configuration option with the given information.
---
---Example:
--- ```
--- ix.option.Add("animationScale", ix.type.number, 1, {
--- 	category = "appearance",
--- 	min = 0.3,
--- 	max = 2,
--- 	decimals = 1
--- })
---@param key string Unique ID for this option
---@param optionType `ix.type` Type of this option
---@param default any Default value that this option will have - this can be nil if needed
---@param data OptionStructure Additional settings for this option
function ix.option.Add(key, optionType, default, data) end

---[SHARED] Loads all saved options from disk.
function ix.option.Load() end

---[SHARED] Returns all of the available options. Note that this doesn't contain the actual values of the options, just their properties.
---
--- ```
--- PrintTable(ix.option.GetAll())
--- > language:
--- >	bNetworked = true
--- >	default = english
--- >	type = 512
--- -- etc.
--- ```
--- @return table<string, OptionStructure> #Table of all options
function ix.option.GetAll() end

---[SHARED] Returns all of the available options grouped by their categories. The returned table contains category tables, that contain
--- all the options in that category as an array (this is so you can sort them if you'd like).
---
--- ```
--- PrintTable(ix.option.GetAllByCategories())
--- > general:
--- >	1:
--- >		key = language
--- >		bNetworked = true
--- >		default = english
--- >		type = 512
--- -- etc.
--- ```
--- @param bRemoveHidden? boolean Remove entries that are marked as hidden
--- @return table<string, OptionStructure[]> #Table of all options
function ix.option.GetAllByCategories(bRemoveHidden) end

---[CLIENT] Sets an option value for the local player.
--- This function will error when an invalid key is passed.
---@param key string Unique ID of the option
---@param value any New value to assign to the option
---@param bNoSave? boolean Whether or not to avoid saving
function ix.option.Set(key, value, bNoSave) end

---[CLIENT] Retrieves an option value for the local player. If it is not set, it'll return the default that you've specified.
---@param key string Unique ID of the option
---@param default any Default value to return if the option is not set
---@return any #Value associated with the key or default if the key doesn't exist.
function ix.option.Get(key, default) end

---[CLIENT] Saves all options to disk.
function ix.option.Save() end

---[CLIENT] Syncs all networked options to the server.
function ix.option.Sync() end

---[SERVER] Retrieves an option value from the specified player. If it is not set, it'll return the default that you've specified.
--- This function will error when an invalid player is passed.
---@param client Player Player to retrieve option value from
---@string key string Unique ID of the option
---@param default any Default value to return if the option is not set
---@return any Value associated with the key or default if not set.
function ix.option.Get(client, key, default) end
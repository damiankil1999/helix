---@meta

--- [SHARED] A table of variable types that are used throughout the framework. It represents types as a table with the keys being the
--- name of the type, and the values being some number value. **You should never directly use these number values!** Using the
--- values from this table will ensure backwards compatibility if the values in this table change.
---
--- This table also contains the numerical values of the types as keys. This means that if you need to check if a type exists, or
--- if you need to get the name of a type, you can do a table lookup with a numerical value. Note that special types are not
--- included since they are not real types that can be compared with.
--- ```
--- -- checking if type exists
--- print(ix.type[2] != nil) --> true
---
--- -- getting name of type
--- print(ix.type[ix.type.string]) --> "string"
--- ```
--- @see ix.command.Add
--- @see ix.option.Add
ix.type = ix.type or {
	[2] = "string",  --- A regular string. In the case of `ix.command.Add`, this represents one word.
	[4] = "text",    --- A regular string. In the case of `ix.command.Add`, this represents all words concatenated into a string.
	[8] = "number",  --- Any number.
	[16] = "player", --- Any player that matches the given query string in `ix.util.FindPlayer`.
	[32] = "steamid", --- A string that matches the Steam ID format of `STEAM_X:X:XXXXXXXX`.
	[64] = "character", --- Any player's character that matches the given query string in `ix.util.FindPlayer`.
	[128] = "bool",  ---A string representation of a bool - `false` and `0` will return `false`, anything else will return `true`.
	[1024] = "color", --- A color represented by its red/green/blue/alpha values.
	[2048] = "vector", --- Vector A 3D vector represented by its x/y/z values.

	string = 2,      --- A regular string. In the case of `ix.command.Add`, this represents one word.
	text = 4,        --- A regular string. In the case of `ix.command.Add`, this represents all words concatenated into a string.
	number = 8,      --- Any number.
	player = 16,     --- Any player that matches the given query string in `ix.util.FindPlayer`.
	steamid = 32,    --- A string that matches the Steam ID format of `STEAM_X:X:XXXXXXXX`.
	character = 64,  --- Any player's character that matches the given query string in `ix.util.FindPlayer`.
	bool = 128,      --- A string representation of a bool - `false` and `0` will return `false`, anything else will return `true`.
	color = 1024,    --- A color represented by its red/green/blue/alpha values.
	vector = 2048,   --- Vector A 3D vector represented by its x/y/z values.

	optional = 256,  --- special type that can be bitwise OR'd with any other type to make it optional. Currently only supported in `ix.command.Add`.
	array = 512      --- special type that can be bitwise OR'd with any other type to make it an array of that type. Currently only supported in `ix.option.Add`.
}


ix.util = {}

---[SHARED] Includes a lua file based on the prefix of the file. This will automatically call `include` and `AddCSLuaFile` based on the
---current realm. This function should always be called shared to ensure that the client will receive the file from the server.
---@param fileName string Path of the Lua file to include. The path is relative to the file that is currently running this function
---@param realm #Realm this file should be included in. You should usually ignore this.
---|"\"server\"" Include the file serverside.
---|"\"shared\"" Include the file serverside and clientside.
---|"\"client\"" Include this file clientside.
---|nil Automatically choose based upon `SERVER` and `CLIENT` globals.
function ix.util.Include(fileName, realm) end

---[SHARED] Includes multiple files in a directory.
---@see ix.util.Include
---@param directory string Directory to include files from
---@param bFromLua? boolean Whether or not to search from the base `lua/` folder, instead of contextually basing from `schema/` or `gamemode/`.
function ix.util.IncludeDir(directory, bFromLua) end

---[SHARED] Removes the realm prefix from a file name. The returned string will be unchanged if there is no prefix found.
---
---```
---print(ix.util.StripRealmPrefix("sv_init.lua")) --> "init.lua"
---```
---@param name string String to strip prefix from
---@return string String stripped of prefix
function ix.util.StripRealmPrefix(name) end

---[SHARED] Returns `true` if the given input is a color table. This is necessary since the engine `IsColor` function only checks for
--- color metatables - which are not used for regular Lua color types.
---@param input table Input to check
---@return boolean #Whether or not the input is a color
function ix.util.IsColor(input) end

---[SHARED] Returns a dimmed version of the given color by the given scale.
--- ```
--- print(ix.util.DimColor(Color(100, 100, 100, 255), 0.5)) --> 50 50 50 255
--- ```
---@param color Color Color to dim
---@param multiplier number What to multiply the red, green, and blue values by
---@param alpha? number Alpha to use in dimmed color
---@return Color #Dimmed color
function ix.util.DimColor(color, multiplier, alpha) end

---[SHARED] Sanitizes an input value with the given type. This function ensures that a valid type is always returned. If a valid value
--- could not be found, it will return the default value for the type. This only works for simple types - e.g it does not work
--- for player, character, or Steam ID types.
--- ```
--- print(ix.util.SanitizeType(ix.type.number, "123")) --> 123
--- print(ix.util.SanitizeType(ix.type.bool, 1)) --> true
--- ```
---@param type `ix.type` to check for
---@param input any Value to sanitize
---@return any #Sanitized value
function ix.util.SanitizeType(type, input) end

---[SHARED] Returns the `ix.type` of the given value.
--- ```
--- print(ix.util.GetTypeFromValue("hello")) --> 2 -- i.e the value of ix.type.string
--- ```
--- @see ix.type
--- @param value any Value to get the type of
--- @return number? #Type of value
function ix.util.GetTypeFromValue(value) end

---[SHARED]
---@TODO Document `ix.util.Bind`.
function ix.util.Bind(self, callback) end

---[SHARED] Returns the address:port of the server.
---@return string
function ix.util.GetAddress() end

---[SHARED] Returns a cached copy of the given material, or creates and caches one if it doesn't exist. This is a quick helper function
--- if you aren't locally storing a `Material()` call.
---@deprecated Garry's Mod caches the material in the `Material()` call nowadays.
---@param materialPath string Path to the material
---@return IMaterial? #The cached material - `nil` if it doesn't exist in the filesystem
function ix.util.GetMaterial(materialPath) end

---[SHARED] Attempts to find a player by matching their name or Steam ID.
---@param identifier string Search query
---@param bAllowPatterns? boolean Whether or not to accept Lua patterns in `identifier`
---@return Player? #Player that matches the given search query - this will be `nil` if a player could not be found
function ix.util.FindPlayer(identifier, bAllowPatterns) end

---[SHARED] Checks to see if two strings are equivalent using a fuzzy manner. Both strings will be lowered, and will return `true` if
--- the strings are identical, or if `b` is a substring of `a`.
---@param a string First string to check
---@param b string Second string to check
---@return boolean #Whether or not the strings are equivalent
function ix.util.StringMatches(a, b) end

---[SHARED] Returns a string that has the named arguments in the format string replaced with the given arguments.
--- ```
--- print(ix.util.FormatStringNamed("Hi, my name is {name}.", {name = "Bobby"})) --> Hi, my name is Bobby.
--- print(ix.util.FormatStringNamed("Hi, my name is {name}.", "Bobby")) --> Hi, my name is Bobby
--- ```
---@param format string Format string
---@param ... string|table Arguments to pass to the formatted string. If passed a table, it will use that table as the lookup table for the named arguments. If passed multiple arguments, it will replace the arguments in the string in order.
---@return string
function ix.util.FormatStringNamed(format, ...) end

---[SHARED] Returns a string that is the given input with spaces in between each CamelCase word. This function will ignore any words
--- that do not begin with a capital letter. The words `ooc`, `looc`, `afk`, and `url` will be automatically transformed
--- into uppercase text. This will not capitalize non-ASCII letters due to limitations with Lua's pattern matching.
--- ```
--- print(ix.util.ExpandCamelCase("HelloWorld")) --> Hello World
--- ```
---@param input string String to expand
---@param bNoUpperFirst? boolean Whether or not to avoid capitalizing the first character. This is useful for lowerCamelCase
---@return string #Expanded CamelCase string
function ix.util.ExpandCamelCase(input, bNoUpperFirst) end

---[SHARED]
---@TODO Document `ix.util.GridVector`.
function ix.util.GridVector(vec, gridSize) end

---[SHARED] Returns an iterator for characters. The resulting key/values will be a player and their corresponding characters. This
--- iterator skips over any players that do not have a valid character loaded.
--- ```
--- for client, character in ix.util.GetCharacters() do
--- 	print(client, character)
--- end
--- > Player [1][Bot01]    character[1]
--- > Player [2][Bot02]    character[2]
--- -- etc.
--- ```
---@return fun(table: table): Player, Character
---@return Player[]
function ix.util.GetCharacters() end

---[CLIENT] Blurs the content underneath the given panel. This will fall back to a simple darkened rectangle if the player has
--- blurring disabled.
--- ```
--- function PANEL:Paint(width, height)
--- 	ix.util.DrawBlur(self)
--- end
--- ```
---@param panel Panel Panel to draw the blur for
---@param amount? number Intensity of the blur. This should be kept between 0 and 10 for performance reasons defaults to `5`
---@param passes? number Quality of the blur. This should be kept as default, defaults to `0.2`
---@param alpha? number Opacity of the blur, defaults to `255`
function ix.util.DrawBlur(panel, amount, passes, alpha) end

---[CLIENT] Draws a blurred rectangle with the given position and bounds. This shouldn't be used for panels, see `ix.util.DrawBlur`
--- instead.
--- ```
--- hook.Add("HUDPaint", "MyHUDPaint", function()
--- 	ix.util.DrawBlurAt(0, 0, ScrW(), ScrH())
--- end)
--- ```
---@param x number X-position of the rectangle
---@param y number Y-position of the rectangle
---@param width number Width of the rectangle
---@param height number Height of the rectangle
---@param amount? number Intensity of the blur. This should be kept between 0 and 10 for performance reasons defaults to `5`
---@param passes? number Quality of the blur. This should be kept as default, defaults to `0.2`
---@param alpha? number Opacity of the blur, defaults to `255`
function ix.util.DrawBlurAt(x, y, width, height, amount, passes, alpha) end

---[CLIENT] Pushes a 3D2D blur to be rendered in the world. The draw function will be called next frame in the
--- `PostDrawOpaqueRenderables` hook.
---@param drawFunc function Function to call when it needs to be drawn
function ix.util.PushBlur(drawFunc) end

--- [CLIENT] Draws some text with a shadow.
--- @param text string Text to draw
--- @param x number X-position of the text
--- @param y number Y-position of the text
--- @param color? Color Color of the text to draw. Defaults to `color_white`
--- @param alignX? number Horizontal alignment of the text, using one of the `TEXT_ALIGN_*` constants. Defaults to `TEXT_ALIGN_LEFT`
--- @param alignY? number Vertical alignment of the text, using one of the `TEXT_ALIGN_*` constants. Defaults to `TEXT_ALIGN_LEFT`
--- @param font? string Font to use for the text. Defaults to "ixGenericFont"
--- @param alpha? number Alpha of the shadow. Defaults to `color.a * 0.575`
function ix.util.DrawText(text, x, y, color, alignX, alignY, font, alpha) end

---[CLIENT] Wraps text so it does not pass a certain width. This function will try and break lines between words if it can,
--- otherwise it will break a word if it's too long.
---@param text string Text to wrap
---@param maxWidth number Maximum allowed width in pixels
---@param font string Font to use for the text. Defaults to "ixChatFont"
function ix.util.WrapText(text, maxWidth, font) end

---[CLIENT]
---@TODO Document `ix.util.DrawArc`.
function ix.util.DrawArc(cx, cy, radius, thickness, startang, endang, roughness, color) end

---[CLIENT]
---@TODO Document `ix.util.DrawPrecachedArc`.
function ix.util.DrawPrecachedArc(arc) end

---[CLIENT]
---@TODO Document `ix.util.PrecacheArc`.
function ix.util.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness) end

---[CLIENT] Resets all stencil values to known good (i.e defaults)
function ix.util.ResetStencilValues() end

---[CLIENT] Alternative to SkinHook that allows you to pass more arguments to skin methods
function derma.SkinFunc(name, panel, a, b, c, d, e, f, g) end

---[CLIENT] Alternative to Color that retrieves from the SKIN.Colours table
function derma.GetColor(name, panel, default) end

---[SHARED]
---@TODO Document `ix.util.IsUseableEntity`.
function ix.util.IsUseableEntity(entity, requiredCaps) end

---[SHARED]
---@TODO Document `ix.util.FindUseEntity`.
function ix.util.FindUseEntity(player, origin, forward) end

---[SHARED]
---@TODO Document `ix.util.FindEmptySpace`.
function ix.util.FindEmptySpace(entity, filter, spacing, size, height, tolerance) end

---[SHARED] Gets the current time in the UTC time-zone.
--- Note: This seems to only return the differance in seconds between the local timezone and UTC. You might be looking for `os.time(os.date("!*t"))`
---@return number #Current time in UTC
function ix.util.GetUTCTime() end

---[SHARED] Gets the amount of seconds from a given formatted string. If no time units are specified, it is assumed minutes.
--- The valid values are as follows:
---
--- - `s` - Seconds
--- - `m` - Minutes
--- - `h` - Hours
--- - `d` - Days
--- - `w` - Weeks
--- - `mo` - Months
--- - `y` - Years
--- ```
--- print(ix.util.GetStringTime("5y2d7w")) --> 162086400 -- 5 years, 2 days, 7 weeks
--- ```
---@param text string Text to interpret a length of time from
---@return number #Amount of seconds from the length interpreted from the given string - 0 If the given string does not have a valid time
function ix.util.GetStringTime(text) end

---[SHARED] Emits sounds one after the other from an entity.
---@param entity Entity Entity to play sounds from
---@param sounds string[] Sound paths to play
---@param delay? number How long to wait before starting to play the sounds. Defaults to `0`
---@param spacing? number How long to wait between playing each sound. Defaults to `0.1`
---@param volume? number The sound level of each sound. Defaults to `75`
---@param pitch? number Pitch percentage of each sound. Defaults to `100`
---@return number #How long the entire sequence of sounds will take to play
function ix.util.EmitQueuedSounds(entity, sounds, delay, spacing, volume, pitch) end

---[SHARED] Merges the contents of the second table with the content in the first one. The destination table will be modified.
--- If element is table but not metatable object, value's elements will be changed only.
---@param destination table The table you want the source table to merge with
---@param source table The table you want to merge with the destination table
---@return table #destination
function ix.util.MetatableSafeTableMerge(destination, source) end

---[SERVER] Sends a notification to a specified recipient.
---@param message string Message to notify
---@param recipient? Player|Player[]|CRecipientFilter Player to be notified - or everyone
function ix.util.Notify(message, recipient) end

---[CLIENT] Sends a notifycation.
---@param message string Message to notify
function ix.util.Notify(message) end

---[SERVER] Sends a translated notification to a specified recipient.
---@param message string Message to notify
---@param recipient? Player|Player[]|CRecipientFilter Player to be notified - or everyone
---@param ... any #Arguments to pass to the translated message
function ix.util.NotifyLocalized(message, recipient, ...) end

---[CLIENT] Creates a translated notification.
---@param message string Message to notify
function ix.util.NotifyLocalized(message, ...) end
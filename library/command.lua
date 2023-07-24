---@meta

---When registering commands with `ix.command.Add`, you'll need to pass in a valid command structure. This is simply a table
--- with various fields defined to describe the functionality of the command.
---@class CommandStructure
---This function is called when the command has passed all the checks and can execute. The first two
--- arguments will be the running command table and the calling player. If the arguments field has been specified, the arguments
--- will be passed as regular function parameters rather than in a table.
---
---When the arguments field is defined: `OnRun(self, client, target, length, message)`
---
---When the arguments field is NOT defined: `OnRun(self, client, arguments)`
---@field OnRun fun(self: CommandStructure, client: Player, target: Player, length: number, message: string)|fun(self: CommandStructure, client: Player, arguments: unknown)
---The help text that appears when the user types in the command. If the string is
--- prefixed with `"@"`, it will use a language phrase.
---@field description? string
---@field GetDescription? fun(): string Dynamically set a description. This is automatically populated with the `description` if it is set.
---An array of strings corresponding to each argument of the command. This ignores the
--- name that's specified in the `OnRun` function arguments and allows you to use any string to change the text that displays
--- in the command's syntax help. When using this field, make sure that the amount is equal to the amount of arguments, as such:
---```
--- COMMAND.arguments = {ix.type.character, ix.type.number}
--- COMMAND.argumentNames = {"target char", "cash (1-1000)"}
--- ```
---@field argumentNames? string[]
---If this field is defined, then additional checks will be performed to ensure that the
--- arguments given to the command are valid. This removes extra boilerplate code since all the passed arguments are guaranteed
--- to be valid. See `CommandArgumentsStructure` for more information.
---@field arguments? number[]
---@field adminOnly? boolean Provides an additional check to see if the user is an admin before running.
---@field superAdminOnly? boolean Provides an additional check to see if the user is a superadmin before running.
---Manually specify a privilege name for this command. It will always be prefixed with
--- `"Helix - "`. This is used in the case that you want to group commands under the same privilege, or use a privilege that
--- you've already defined (i.e grouping `/CharBan` and `/CharUnban` into the `Helix - Ban Character` privilege).
---@field privilege? string
---This callback checks whether or not the player is allowed to run the command.
--- This callback should **NOT** be used in conjunction with `adminOnly` or `superAdminOnly`, as populating those
--- fields create a custom a `OnCheckAccess` callback for you internally. This is used in cases where you want more fine-grained
--- access control for your command.
---
--- Keep in mind that this is a **SHARED** callback; the command will not show up the client if the callback returns `false`.
---@field OnCheckAccess? fun(client: Player): boolean
---@field uniqueID string Automatically set with `ix.command.Add` this is the `command` argument.
---@field alias? string|string[]

--- Rather than checking the validity for arguments in your command's `OnRun` function, you can have Helix do it for you to
--- reduce the amount of boilerplate code that needs to be written. This can be done by populating the `arguments` field.
---
---When using the `arguments` field in your command, you are specifying specific types that you expect to receive when the
--- command is ran successfully. This means that before `OnRun` is called, the arguments passed to the command from a user will
--- be verified to be valid. Each argument is an `ix.type` entry that specifies the expected type for that argument. Optional
--- arguments can be specified by using a bitwise OR with the special `ix.type.optional` type. When specified as optional, the
--- argument can be `nil` if the user has not entered anything for that argument - otherwise it will be valid.
---
---Note that optional arguments must always be at the end of a list of arguments - or rather, they must not follow a required
--- argument. The `syntax` field will be automatically populated when using strict arguments, which means you shouldn't fill out
--- the `syntax` field yourself. The arguments you specify will have the same names as the arguments in your OnRun function.
---
---Consider this example command:
--- ```
--- ix.command.Add("CharSlap", {
--- 	description = "Slaps a character with a large trout.",
--- 	adminOnly = true,
--- 	arguments = {
--- 		ix.type.character,
--- 		bit.bor(ix.type.number, ix.type.optional)
--- 	},
--- 	OnRun = function(self, client, target, damage)
--- 		-- WHAM!
--- 	end
--- })
--- ```
---Here, we've specified the first argument called `target` to be of type `character`, and the second argument called `damage`
--- to be of type `number`. The `damage` argument is optional, meaning that the command will still run if the user has not
--- specified any value for the damage. In this case, we'll need to check if it was specified by doing a simple
--- `if (damage) then`. The syntax field will be automatically populated with the value `"<target: character> [damage: number]"`.
---@class CommandArgumentsStructure

---@class ix.command
---@field list table<string, CommandStructure>
ix.command = {}

---[SHARED] reates a new command.
---@param command string Name of the command (recommended in UpperCamelCase)
---@param data CommandStructure Data describing the command
---@see CommandStructure
---@see CommandArgumentsStructure
function ix.command.Add(command, data) end

---[SHARED] Returns true if a player is allowed to run a certain command.
---@param client Player Player to check access for
---@param command string Name of the command to check access for
---@return boolean #Whether or not the player is allowed to run the command
function ix.command.HasAccess(client, command) end

---[SHARED] Returns a table of arguments from a given string.
--- Words separated by spaces will be considered one argument. To have an argument containing multiple words, they must be
--- contained within quotation marks.
---
---Example:
--- ```
--- PrintTable(ix.command.ExtractArgs("these are \"some arguments\""))
--- > 1 = these
--- > 2 = are
--- > 3 = some arguments
--- ```
---@param text string String to extract arguments from
---@return string[] Arguments extracted from string
function ix.command.ExtractArgs(text) end

---[SHARED] Returns an array of potential commands by unique id.
--- When bSorted is true, the commands will be sorted by name. When bReorganize is true, it will move any exact match to the top
--- of the array. When bRemoveDupes is true, it will remove any commands that have the same NAME.
--- @param identifier string Search query
--- @param bSorted? boolean Whether or not to sort the commands by name
--- @param bReorganize? boolean Whether or not any exact match will be moved to the top of the array
--- @param bRemoveDupes? boolean Whether or not to remove any commands that have the same name
--- @return CommandStructure[] #Array of command tables whose name partially or completely matches the search query
function ix.command.FindAll(identifier, bSorted, bReorganize, bRemoveDupes) end

---[SERVER] Attempts to find a player by an identifier. If unsuccessful, a notice will be displayed to the specified player. The
--- search criteria is derived from `ix.util.FindPlayer`.
---@see ix.util.FindPlayer
---@param client Player Player to give a notification to if the player could not be found
---@param name string Search query
---@return Player? #Player that matches the given search query
function ix.command.FindPlayer(client, name) end

---[SERVER] Forces a player to execute a command by name.
---
---Example:
--- ```
--- ix.command.Run(player.GetByID(1), "Roll", {10})
---```
---@param client Player Player who is executing the command
---@param command string Full name of the command to be executed. This string gets lowered, but it's good practice to stick with the exact name of the command
---@param arguments table Array of arguments to be passed to the command
function ix.command.Run(client, command, arguments) end

---[SERVER] Parses a chat string and runs the command if one is found. Specifically, it checks for commands in a string with the
--- format `/CommandName some arguments`
---
---Example:
--- ```
--- ix.command.Parse(player.GetByID(1), "/roll 10")
--- ```
---@param client Player Player who is executing the command
---@param text string Input string to search for the command format
---@param realCommand? string Specific command to check for. If this is specified, it will not try to run any command that's found at the beginning - only if it matches `realCommand`
---@param arguments? table Array of arguments to pass to the command. If not specified, it will try to extract it from the string specified in `text` using `ix.command.ExtractArgs`
---@return boolean #Whether or not a command has been found
function ix.command.Parse(client, text, realCommand, arguments) end

---[CLIENT] Request the server to run a command. This mimics similar functionality to the client typing `/CommandName` in the chatbox.
---
---Example:
--- ```
--- ix.command.Send("roll", 10)
--- ```
---@param command string Unique ID of the command
---@param ... any #Arguments to pass to the command
function ix.command.Send(command, ...) end
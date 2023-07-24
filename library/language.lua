---@meta

---Multi-language phrase support.
---
---Helix has support for multiple languages, and you can easily leverage this system for use in your own schema, plugins, etc.
--- Languages will be loaded from the schema and any plugins in `languages/sh_languagename.lua`, where `languagename` is the id of a
--- language (`english` for English, `french` for French, etc). The structure of a language file is a table of phrases with the key
--- as its phrase ID and the value as its translation for that language.
---
---For example, in `plugins/area/sh_english.lua`:
--- ```
--- LANGUAGE = {
--- 	area = "Area",
--- 	areas = "Areas",
--- 	areaEditMode = "Area Edit Mode",
--- 	-- etc.
--- }
--- ```
---
---The phrases defined in these language files can be used with the `L` global function:
--- ```
---	print(L("areaEditMode")) --	> Area Edit Mode
--- ```
---
---All phrases are formatted with `string.format`, so if you wish to add some info in a phrase you can use standard Lua string
--- formatting arguments:
--- ```
---	print(L("areaDeleteConfirm", "Test")) --> Are you sure you want to delete the area "Test"?
--- ```
---
---Phrases are also usable on the server, but only when trying to localize a phrase based on a client's preferences. The server
--- does not have a set language. An example:
--- ```
---	Entity(1):ChatPrint(L("areaEditMode")) --> "Area Edit Mode" will print in the player's chatbox
--- ```
---@class ix.lang
---@field stored table
---@field names table
ix.lang = {}

---[SHARED] Loads language files from a directory.
---@param directory string Directory to load language files from
function ix.lang.LoadFromDir(directory) end

---[SHARED] Adds phrases to a language. This is used when you aren't adding entries through the files in the `languages/` folder. A
--- common use case is adding language phrases in a single-file plugin.
---
---Example:
--- ```
--- ix.lang.AddTable("english", {
--- 	myPhrase = "My Phrase"
--- })
--- ```
---@param language string The ID of the language
---@param data table Language data to add to the given language
function ix.lang.AddTable(language, data) end

---[CLIENT] Translates the given key with the arguments.
--- This will fall back to the english language if they key doesn't exist.
---@param key string language key.
---@param ...any
---@return string
function _G.L(key, ...) end

---[CLIENT] Translates the given key with the arguments.
---@param key string language key.
---@param ...any
---@return string?
function _G.L2(key, ...) end

---[SERVER] Translate the given key with the arguments.
--- This will fall back to the english language if they key doesn't exist.
---@param key string language key.
---@param client Player the player to get their language.
---@param ...any
---@return string
function _G.L(key, client, ...) end

---[SERVER] Translate the given key with the arguments.
---@param key string language key.
---@param client Player the player to get their language.
---@param ...any
---@return string?
function _G.L2(key, client, ...) end
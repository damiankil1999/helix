---@class ix.log
---@field color table<number, Color>
---@field handlers table
ix.log = {}

---[SERVER]
---@TODO Document `ix.log.LoadTables`.
function ix.log.LoadTables() end

---[SERVER] Adds a log type
---@param logType string Log category
---@param format string The string format that log messages should use
---@param flag number Log level
function ix.log.AddType(logType, format, flag) end

---[SERVER]
---@TODO Document `ix.log.Parse`.
function ix.log.Parse(client, logType, ...) end

---[SERVER]
---@TODO Document `ix.log.AddRaw`.
function ix.log.AddRaw(logString, bNoSave) end

---[SERVER] Add a log message
---@param client Player Player who instigated the log
---@param logType string Log category
---@param ...any #Arguments to pass to the log
function ix.log.Add(client, logType, ...) end

---[SERVER]
---@TODO Document `ix.log.Send`.
function ix.log.Send(client, logString, flag) end

---[SERVER]
---@TODO Document `ix.log.Send`.
function ix.log.CallHandler(event, ...) end

---[SERVER]
---@TODO Document `ix.log.RegisterHandler`.
function ix.log.RegisterHandler(name, data) end
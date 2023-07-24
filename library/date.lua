---@meta

---Persistent date and time handling.
---
---All of Lua's time functions are dependent on the Unix epoch, which means we can't have dates that go further than 1970. This
--- library remedies this problem. Time/date is represented by a `date` object that is queried, instead of relying on the seconds
--- since the epoch.
---
---## Futher documentation
---This library makes use of a third-party date library found at https://github.com/Tieske/date - you can find all documentation
--- regarding the `date` object and its methods there.
---@class ix.date
---@field lib unknown
---@field timeScale number Seconds per minute. Defaults to `ix.config.Get("secondsPerMinute", 60)`.
---@field current unknown Current in-game date/time.
---@field start number Arbitrary start time for calculating date/time offset. Defaults to `CurTime()`.
ix.date = {}

---[SERVER] Loads the date from disk.
function ix.date.Initialize() end

---[SERVER] Updates the internal in-game date/time representation and resets the offset.
function ix.date.ResolveOffset() end

---[SERVER] Updates the time scale of the in-game date/time. The time scale is given in seconds per minute (i.e how many real life
--- seconds it takes for an in-game minute to pass). You should avoid using this function and use the in-game config menu to
--- change the time scale instead.
---@param secondsPerMinute number New time scale
function ix.date.UpdateTimescale(secondsPerMinute) end

---[SERVER] Sends the current date to a player. This is done automatically when the player joins the server.
---@param client? Player Player to send the date to, or `nil` to send to everyone
function ix.date.Send(client) end

---[SERVER] Saves the current in-game date to disk.
function ix.date.Save() end

---[SHARED] Returns the currently set date.
---@return unknown #Current in-game date
function ix.date.Get() end

---[SHARED] Returns a string formatted version of a date.
---@param format string Format string
---@param currentDate? unknown Date to format. If nil, it will use the currently set date
---@return string #Formatted date
function ix.date.GetFormatted(format, currentDate) end

---[SHARED] Returns a serialized version of a date. This is useful when you need to network a date to clients, or save a date to disk.
---@param currentDate? unknown Date to serialize. If nil, it will use the currently set date
---@return table Serialized date
function ix.date.GetSerialized(currentDate) end

---[SHARED] Returns a date object from a table or serialized date.
---@param currentDate unknown Date to construct
---@return unknown #Constructed date object
function ix.date.Construct(currentDate) end
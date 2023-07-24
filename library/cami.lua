---@meta

---CAMI - Common Admin Mod Interface.
---Copyright 2020 CAMI Contributors
---
---Makes admin mods intercompatible and provides an abstract privilege interface
---for third party addons.
---
---Follows the specification on this page:
---https://github.com/glua/CAMI/blob/master/README.md
---@class CAMI
---@field Version number Version number in YearMonthDay format.
CAMI = {}

---defines the charactaristics of a usergroup
---@class CAMI_USERGROUP
---@field Name string The name of the usergroup
---@field Inherits string The name of the usergroup this usergroup inherits from
---@field CAMI_Source string The source specified by the admin mod which registered this usergroup (if any, converted to a string)

---defines the charactaristics of a privilege
---@class CAMI_PRIVILEGE
---@field Name string The name of the privilege
---@field MinAccess "'user'" | "'admin'" | "'superadmin'" Default group that should have this privilege
---@field Description string | nil Optional text describing the purpose of the privilege
local CAMI_PRIVILEGE = {}

---Optional function to check if a player has access to this privilege
--- (and optionally execute it on another player)
---
---⚠ **Warning**: This function may not be called by all admin mods
---@param actor Player The player
---@param target? Player The target
---@return boolean #If they can or not
---@return string? #Optional reason
function CAMI_PRIVILEGE:HasAccess(actor, target) end

--- Registers a usergroup with CAMI.
---
--- Use the source parameter to make sure CAMI.RegisterUsergroup function and
--- the CAMI.OnUsergroupRegistered hook don't cause an infinite loop
--- @param usergroup CAMI_USERGROUP The structure for the usergroup you want to register
--- @param source any Identifier for your own admin mod. Can be anything.
--- @return CAMI_USERGROUP #The usergroup given as an argument
function CAMI.RegisterUsergroup(usergroup, source) end

---Unregisters a usergroup from CAMI. This will call a hook that will notify
--- all other admin mods of the removal.
---
---⚠ **Warning**: Call only when the usergroup is to be permanently removed.
---
---Use the source parameter to make sure CAMI.UnregisterUsergroup function and
--- the CAMI.OnUsergroupUnregistered hook don't cause an infinite loop
---@param usergroupName string The name of the usergroup.
---@param source any Identifier for your own admin mod. Can be anything.
---@return boolean #Whether the unregistering succeeded.
function CAMI.UnregisterUsergroup(usergroupName, source) end

---Retrieves all registered usergroups.
---@return table<string, CAMI_USERGROUP> #Usergroups indexed by their names.
function CAMI.GetUsergroups() end

---Receives information about a usergroup.
---@param usergroupName string
---@return CAMI_USERGROUP? #Returns `nil` when the usergroup does not exist.
function CAMI.GetUsergroup(usergroupName) end

---Checks to see if potentialAncestor is an ancestor of usergroupName.
--- All usergroups are ancestors of themselves.
---
---Examples:
--- * `user` is an ancestor of `admin` and also `superadmin`
--- * `admin` is an ancestor of `superadmin`, but not `user`
---@param usergroupName string The usergroup to query
---@param potentialAncestor string The ancestor to query
---@return boolean #Whether usergroupName inherits potentialAncestor.
function CAMI.UsergroupInherits(usergroupName, potentialAncestor) end

---Find the base group a usergroup inherits from.
---
---This function traverses down the inheritence chain, so for example if you have
--- `user` -> `group1` -> `group2`
--- this function will return `user` if you pass it `group2`.
---
---ℹ **NOTE**: All usergroups must eventually inherit either user, admin or superadmin.
---@param usergroupName string The name of the usergroup
---@return "\"user\"" | "\"admin\"" | "\"superadmin\"" #The name of the root usergroup
function CAMI.InheritanceRoot(usergroupName) end

---Registers an addon privilege with CAMI.
---
---⚠ **Warning**: This should only be used by addons. Admin mods must *NOT*
--- register their privileges using this function.
---@param privilege CAMI_PRIVILEGE
---@return CAMI_PRIVILEGE #The privilege given as argument.
function CAMI.RegisterPrivilege(privilege) end

---Unregisters a privilege from CAMI.
--- This will call a hook that will notify any admin mods of the removal.
---
---⚠ **Warning**: Call only when the privilege is to be permanently removed.
---@param privilegeName string The name of the privilege.
---@return boolean #Whether the unregistering succeeded.
function CAMI.UnregisterPrivilege(privilegeName) end

---Retrieves all registered privileges.
---@return table<string, CAMI_PRIVILEGE> #All privileges indexed by their names.
function CAMI.GetPrivileges() end

---Receives information about a privilege.
---@param privilegeName string
---@return CAMI_PRIVILEGE?
function CAMI.GetPrivilege(privilegeName) end

---@class CAMI_ACCESS_EXTRA_INFO
---@field Fallback "\"user\"" | "\"admin\"" | "\"superadmin\"" Fallback status for if the privilege doesn't exist. Defaults to `admin`.
---@field IgnoreImmunity boolean Ignore any immunity mechanisms an admin mod might have.
---@field CommandArguments table Extra arguments that were given to the privilege command.

---Checks if a player has access to a privilege
--- (and optionally can execute it on targetPly)
---
---This function is designed to be asynchronous but will be invoked
--- synchronously if no callback is passed.
---
---⚠ **Warning**: If the currently installed admin mod does not support
--- synchronous queries, this function will throw an error!
---@param actorPly Player The player to query
---@param privilegeName string The privilege to query
---@param callback? fun(hasAccess: boolean, reason?: string) Callback to receive the answer, or nil for synchronous
---@param targetPly? Player target for if the privilege effects another player (eg kick/ban)
---@param extraInfoTbl? CAMI_ACCESS_EXTRA_INFO Table of extra information for the admin mod
---@return boolean? #Synchronous only - if the player has the privilege
---@return string? #Synchronous only - optional reason from admin mod
function CAMI.PlayerHasAccess(actorPly, privilegeName, callback, targetPly, extraInfoTbl) end

---Get all the players on the server with a certain privilege
--- (and optionally who can execute it on targetPly)
---
---ℹ **NOTE**: This is an asynchronous function!
---@param privilegeName string The privilege to query
---@param callback fun(players: Player[]) Callback to receive the answer
---@param targetPly? Player target for if the privilege effects another player (eg kick/ban)
---@param extraInfoTbl? CAMI_ACCESS_EXTRA_INFO Table of extra information for the admin mod
function CAMI.GetPlayersWithAccess(privilegeName, callback, targetPly, extraInfoTbl) end

---@class CAMI_STEAM_ACCESS_EXTRA_INFO
---@field IgnoreImmunity boolean @Ignore any immunity mechanisms an admin mod might have.
---@field CommandArguments table @Extra arguments that were given to the privilege command.

---Checks if a (potentially offline) SteamID has access to a privilege
--- (and optionally if they can execute it on a target SteamID)
---
---ℹ **NOTE**: This is an asynchronous function!
---@param actorSteam string? The SteamID to query
---@param privilegeName string The privilege to query
---@param callback fun(hasAccess: boolean, reason?: string) @Callback to receive  the answer
---@param targetSteam? string target SteamID for if the privilege effects another player (eg kick/ban)
---@param extraInfoTbl? CAMI_STEAM_ACCESS_EXTRA_INFO Table of extra information for the admin mod
function CAMI.SteamIDHasAccess(actorSteam, privilegeName, callback, targetSteam, extraInfoTbl) end

---Signify that your admin mod has changed the usergroup of a player. This
--- function communicates to other admin mods what it thinks the usergroup
--- of a player should be.
---
---Listen to the hook to receive the usergroup changes of other admin mods.
---@param ply Player The player for which the usergroup is changed
---@param old string The previous usergroup of the player.
---@param new string The new usergroup of the player.
---@param source any Identifier for your own admin mod. Can be anything.
function CAMI.SignalUserGroupChanged(ply, old, new, source) end

---Signify that your admin mod has changed the usergroup of a disconnected
--- player. This communicates to other admin mods what it thinks the usergroup
--- of a player should be.
---
---Listen to the hook to receive the usergroup changes of other admin mods.
---@param steamId string The steam ID of the player for which the usergroup is changed
---@param old string The previous usergroup of the player.
---@param new string The new usergroup of the player.
---@param source any Identifier for your own admin mod. Can be anything.
function CAMI.SignalSteamIDUserGroupChanged(steamId, old, new, source) end
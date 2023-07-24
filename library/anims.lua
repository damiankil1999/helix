---@meta

---Player model animation.
---
---Helix comes with support for using NPC animations/models as regular player models by manually translating animations. There are
--- a few standard animation sets that are built-in that should cover most non-player models:
---* citizen_male
---* citizen_female
---* metrocop
---* overwatch
---* vortigaunt
---* player
---* zombie
---* fastZombie
---
---If you find that your models are T-posing when they work elsewhere, you'll probably need to set the model class for your
--- model with `ix.anim.SetModelClass` in order for the correct animations to be used. If you'd like to add your own animation
--- class, simply add to the `ix.anim` table with a model class name and the required animation translation table.
---@class ix.anim
ix.anim = {}

---[SHARED] Sets a model's animation class.
---
---Example:
--- ```
--- ix.anim.SetModelClass("models/police.mdl", "metrocop")
--- ```
---@param model string Model name to set the animation class for
---@param class string Animation class to assign to the model
function ix.anim.SetModelClass(model, class) end

---[SHARED] Gets a model's animation class.
---
---Example:
--- ```
--- ix.anim.GetModelClass("models/police.mdl") --> metrocop
--- ```
---@param model string Model to get the animation class for
---@return string? #Animation class of the model - `nil` If there was no animation associated with the given model
function ix.anim.GetModelClass(model) end
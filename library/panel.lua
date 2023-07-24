---@meta

---@class Panel
local Panel = {}

---[CLIENT]
---@TODO Document `Panel.GetTweenAnimation`.
function Panel:GetTweenAnimation(index, bNoPlay) end

---[CLIENT]
---@TODO Document `Panel.IsPlayingTweenAnimation`.
function Panel:IsPlayingTweenAnimation(index) end

---[CLIENT]
---@TODO Document `Panel.StopAnimations`.
function Panel:StopAnimations(bRemove) end

---[CLIENT]
---@TODO Document `Panel.CreateAnimation`.
function Panel:CreateAnimation(length, data) end
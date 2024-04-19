wait(0.5)
local PhysicsService = game:GetService("PhysicsService")

local function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		PhysicsService:SetPartCollisionGroup(object,"RaceCars")
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

setCollisionGroupRecursive(script.Parent)
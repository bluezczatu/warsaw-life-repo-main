local PhysicsService = game:GetService("PhysicsService")
 
PhysicsService:CreateCollisionGroup("RaceCars")
PhysicsService:CollisionGroupSetCollidable("RaceCars", "RaceCars", false)

local function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		PhysicsService:SetPartCollisionGroup(object, "RaceCars")
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end
 
local function onCharacterAdded(character)
	setCollisionGroupRecursive(character)
end
 
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end
 
game.Players.PlayerAdded:Connect(onPlayerAdded)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local ReplicaController = require(ReplicatedStorage:WaitForChild("ReplicaController"))

local Player = Players.LocalPlayer

local function update_food(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightList.Food.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end

local function update_water(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightList.Water.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end

local function update_health(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightList.Health.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end

ReplicaController.ReplicaOfClassCreated("DataToken_"..Player.UserId,function(replica) 
	print(replica)

	replica:ListenToChange({"Thirst"},function(newVal) 
		update_water(newVal)
	end)
	update_water(replica.Data["Thirst"])

	replica:ListenToChange({"Saturation"},function(newVal) 
		update_food(newVal)
	end)
	update_food(replica.Data["Saturation"])
end)



ReplicaController.RequestData()

-------------------------------------------
local BWSync = game.ReplicatedStorage:WaitForChild("BWSync")

healthconnection = game.Workspace:FindFirstChild(Player.Name).Humanoid.HealthChanged:Connect(function(health)
	update_health(health)
	if health == 0 then
		BWSync:FireServer()
		
		local SG = game:GetService("StarterGui")
		SG:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end
	if health > 0 then
		local SG = game:GetService("StarterGui")
		SG:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	end
end)


local health = game.Workspace:FindFirstChild(Player.Name).Humanoid.Health
warn(health)
update_health(health)

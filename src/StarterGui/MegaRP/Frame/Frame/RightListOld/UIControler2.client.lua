local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local ReplicaController = require(ReplicatedStorage:WaitForChild("ReplicaController"))

local function update_food(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightListOld.Food.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end

local function update_water(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightListOld.Water.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end

local function update_health(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightListOld.Health.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end

local function update_stamina(health)
	Player.PlayerGui.MegaRP.Frame.Frame.RightListOld.Stamina.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end



local UIGradient = script.Parent.Water.ImageLabelColor.UIGradient


local function updatevalue(value)
	value = -1 + value

	local TransOfPercentPart = 0.75 -- main color
	local TransOfMissingPart = 0

	local progress = value - 0.01
	local progress2 = value

	UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,TransOfPercentPart),
		NumberSequenceKeypoint.new(progress,TransOfPercentPart),
		NumberSequenceKeypoint.new(progress2,TransOfMissingPart),
		NumberSequenceKeypoint.new(1,TransOfMissingPart)
	})


end



ReplicaController.ReplicaOfClassCreated("DataToken_"..Player.UserId,function(replica)  
	
	replica:ListenToChange({"Thirst"},function(newVal) 
		update_water(newVal)
	end)
	update_water(replica.Data["Thirst"])
	
	replica:ListenToChange({"Saturation"},function(newVal) 
		update_food(newVal)
	end)
	update_food(replica.Data["Saturation"])
	
end)

ReplicaController.ReplicaOfClassCreated("Stamina_"..Player.UserId,function(replica)  
	
	replica:ListenToChange({"Stamina"},function(newVal) 
		update_stamina(newVal)
	end)
	update_stamina(replica.Data["Stamina"])
	
end)


ReplicaController.RequestData()

healthconnection = game.Workspace:FindFirstChild(Player.Name).Humanoid.HealthChanged:Connect(function(health)
	update_health(health)
end)
update_health(game.Workspace:FindFirstChild(Player.Name).Humanoid.Health)


updatevalue(0.9)

wait(5)

updatevalue(0.5)

wait(3)


updatevalue(0.1)
















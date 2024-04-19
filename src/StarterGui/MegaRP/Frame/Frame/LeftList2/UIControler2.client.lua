local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local ReplicaController = require(ReplicatedStorage:WaitForChild("ReplicaController"))


local HealthGradient = script.Parent.Health.ImageLabelColor.UIGradient
local StaminaGradient = script.Parent.Stamina.ImageLabelColor.UIGradient

local FoodGradient = script.Parent.Food.ImageLabelColor.UIGradient
local WaterGradient = script.Parent.Water.ImageLabelColor.UIGradient

local function updatevalue(value, UIGradient)
	--warn(value)

	value = (-1 + value) * -1

	--warn(value)

	local TransOfPercentPart = 0.75 -- main color
	local TransOfMissingPart = 0

	local progress = value - 0.01
	local progress2 = value

	if value - 0.01 <= 0 then
		progress = value 
		progress2 = value + 0.01
	end


	--warn(progress,progress2)

	pcall(function()
		
		UIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0,TransOfPercentPart),
			NumberSequenceKeypoint.new(progress,TransOfPercentPart),
			NumberSequenceKeypoint.new(progress2,TransOfMissingPart),
			NumberSequenceKeypoint.new(1,TransOfMissingPart)
		})
	
	end)

end

local function update_food(health)
	updatevalue(math.round(health) / 100, FoodGradient)
end

local function update_water(health)
	updatevalue(math.round(health) / 100, WaterGradient)
end

local function update_health(health)
	updatevalue(math.round(health) / 100, HealthGradient)
end

local function update_stamina(health)
	updatevalue(math.round(health) / 100, StaminaGradient)
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













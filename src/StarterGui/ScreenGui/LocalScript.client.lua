local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local ReplicaController = require(ReplicatedStorage:WaitForChild("ReplicaController"))

local function update_stamina(health)
	print(math.round(health))
	Player.PlayerGui.MegaRP.Frame.Frame.RightList.Stamina.Value.Size = UDim2.new(1, 0, math.round(health) / 100, 0)
end



ReplicaController.ReplicaOfClassCreated("DataToken_"..Player.UserId,function(replica)  
	
	warn(replica)
	
	--Listen to Thirst
	replica:ListenToChange({"Thirst"},function(newVal) 
		script.Parent.Thirst.Text = "Thirst: "..newVal
	end)
	script.Parent.Thirst.Text = "Thirst: " .. replica.Data["Thirst"]
	
	--Listen to saturation
	replica:ListenToChange({"Saturation"},function(newVal) 
		script.Parent.Saturation.Text = "Saturation: "..newVal
	end)
	script.Parent.Saturation.Text = "Saturation: " .. replica.Data["Saturation"]
end)

ReplicaController.ReplicaOfClassCreated("Stamina_"..Player.UserId,function(replica)  
	replica:ListenToChange({"Stamina"},function(newVal) 
		script.Parent.Stamina.Text = "Stamina: "..newVal
		update_stamina(newVal)
	end)
	script.Parent.Stamina.Text = "Stamina: " .. replica.Data["Stamina"]
	update_stamina(replica.Data["Stamina"])
end)
	

ReplicaController.RequestData()





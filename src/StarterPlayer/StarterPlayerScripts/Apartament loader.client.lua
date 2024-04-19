local UserInputService = game.UserInputService
wait(2)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerVisibilityModule = require(ReplicatedStorage.Modules:WaitForChild("PlayerVisibility"))

local ShowOnlyWhitelistedPlayers = ReplicatedStorage.Events.ShowOnlyWhitelistedPlayers
local HideOnlyWhitelistedPlayers = ReplicatedStorage.Events.HideOnlyWhitelistedPlayers
local ShowAllPlayers  = ReplicatedStorage.Events.ShowAllPlayers

local playerData = {
	["91"] = {
		["type"] = "apartament",
		["model"] = "test1",
		["owner"] = "327155328",
		["owners"] = "327155328 1159513210148356156 396350180791943168",
		["furniture"] = {
			["wardrobe"] = {
				["name"] = "Test1"
			},
			["storage"] = {
				["name"] = "Test1",
				["id"] = "25"
			}

		}

	}
}



-- function buildApartament(apartamentData)
-- 	warn(apartamentData["type"])
-- 	warn(apartamentData["model"])
-- 	local apartamentModel = game.Workspace.Apartaments:FindFirstChild(apartamentData["type"]):FindFirstChild(apartamentData["model"])
	
-- 	if apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage"):FindFirstChild("Storage") then
-- 		apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage"):FindFirstChild("Storage"):Destroy()
-- 	end

-- 	if apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe"):FindFirstChild("Wardrobe") then
-- 		apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe"):FindFirstChild("Wardrobe"):Destroy()
-- 	end
	

-- 	if apartamentData["furniture"]["wardrobe"] then
		
-- 		local wardrobe = game.ReplicatedStorage.Apartaments.furniture.wardrobe:FindFirstChild(apartamentData["furniture"]["wardrobe"]["name"]):Clone()

-- 		wardrobe:SetPrimaryPartCFrame(apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe").Part.CFrame)
-- 		wardrobe.Parent = apartamentModel.furniture.wardrobe
-- 		wardrobe.Name = "Wardrobe"
-- 	end
	
-- 	if apartamentData["furniture"]["storage"] then

-- 		local storage = game.ReplicatedStorage.Apartaments.furniture.storage:FindFirstChild(apartamentData["furniture"]["storage"]["name"]):Clone()

-- 		storage:SetPrimaryPartCFrame(apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage").Part.CFrame)
-- 		storage.Parent = apartamentModel.furniture.storage
-- 		storage.Name = "Storage"
-- 	end
	
-- 	--if apartamentData["furniture"]["storage"] then
-- 	--	warn(apartamentData["furniture"]["storage"])
			
-- 	--	warn(apartamentData["furniture"]["storage"]["Name"])	
			
-- 	--	local storage = game.ReplicatedStorage.Apartaments.furniture.storage:FindFirstChild(apartamentData["furniture"]["storage"]["Name"]):Clone()
		
		
-- 	--	storage.Postion =  apartamentModel:FindFirstChild("storage").Position
-- 	--	storage.Parent = apartamentModel
		
-- 	--end

	
-- 	--apartamentModel:Destroy()
-- end


-- UserInputService.InputBegan:Connect(function(Input)
	

-- 	if Input.KeyCode == Enum.KeyCode.M then
-- 		warn(playerData["91"])
-- 		buildApartament(playerData["91"])
-- 	end
-- 	--if Input.KeyCode == Enum.KeyCode.Y then
-- 	--	PlayerVisibilityModule.ShowAllPlayers()
-- 	--end
	
-- end)

--local ReplicatedStorage = game.ReplicatedStorage
local ApartamentJoin = ReplicatedStorage.Events.ApartamentJoin
local ApartamentExit = ReplicatedStorage.Events.ApartamentExit
local LocalPlayer = game.Players.LocalPlayer

ApartamentJoin.OnClientEvent:Connect(function(ApartamentType, ApartamentName)

	LocalPlayer.PlayerGui.Group.AparamentEnter.Enabled = true
	
	--warn(ApartamentType, ApartamentName)
	local apartamentModel = game.Workspace.Apartaments:FindFirstChild(ApartamentType):FindFirstChild(ApartamentName)
	
	LocalPlayer.Character.HumanoidRootPart.CFrame = apartamentModel.JoinTeleport.CFrame
	
	local apartamentData = playerData["91"]
	
	--local apartamentModel = game.Workspace.Apartaments:FindFirstChild(apartamentData["type"]):FindFirstChild(apartamentData["model"])

	if apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage"):FindFirstChild("Storage") then
		apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage"):FindFirstChild("Storage"):Destroy()
	end

	if apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe"):FindFirstChild("Wardrobe") then
		apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe"):FindFirstChild("Wardrobe"):Destroy()
	end


	if apartamentData["furniture"]["wardrobe"] then

		local wardrobe = game.ReplicatedStorage.Apartaments.furniture.wardrobe:FindFirstChild(apartamentData["furniture"]["wardrobe"]["name"]):Clone()

		wardrobe:SetPrimaryPartCFrame(apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe").Part.CFrame)
		wardrobe.Parent = apartamentModel.furniture.wardrobe
		wardrobe.Name = "Wardrobe"
	end

	if apartamentData["furniture"]["storage"] then

		local storage = game.ReplicatedStorage.Apartaments.furniture.storage:FindFirstChild(apartamentData["furniture"]["storage"]["name"]):Clone()

		storage:SetPrimaryPartCFrame(apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage").Part.CFrame)
		storage.Parent = apartamentModel.furniture.storage
		storage.Name = "Storage"
	end
	
	
	
	
	
end)

ApartamentExit.OnClientEvent:Connect(function(ApartamentType, ApartamentName)
	
	LocalPlayer.PlayerGui.Group.AparamentEnter.Enabled = false
	
	--warn(ApartamentType, ApartamentName)
	local apartamentModel = game.Workspace.Apartaments:FindFirstChild(ApartamentType):FindFirstChild(ApartamentName)

	LocalPlayer.Character.HumanoidRootPart.CFrame = apartamentModel.ExitTeleport.CFrame
	
	if apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage"):FindFirstChild("Storage") then
		apartamentModel:FindFirstChild("furniture"):FindFirstChild("storage"):FindFirstChild("Storage"):Destroy()
	end

	if apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe"):FindFirstChild("Wardrobe") then
		apartamentModel:FindFirstChild("furniture"):FindFirstChild("wardrobe"):FindFirstChild("Wardrobe"):Destroy()
	end
	
end)



ShowOnlyWhitelistedPlayers.OnClientEvent:Connect(function(list)
	--warn("remote event xd")
	PlayerVisibilityModule.ShowOnlyWhitelistedPlayers(list)
end)

HideOnlyWhitelistedPlayers.OnClientEvent:Connect(function(list)
	--warn("remote event xd2")
	PlayerVisibilityModule.HideOnlyWhitelistedPlayers(list)
end)

ShowAllPlayers.OnClientEvent:Connect(function()
	--warn("remote event xd")
	PlayerVisibilityModule.ShowAllPlayers()
end)
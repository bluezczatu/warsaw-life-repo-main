local ReplicatedStorage = game.ReplicatedStorage

local UIStatusEvent = ReplicatedStorage.Events.UIStatus
local ServerScriptService = game.ServerScriptService

local DataManager = require(ServerScriptService.CharacterData)

local ShowDocumentClient = ReplicatedStorage.Events.ShowDocumentClient
local ShowDocumentServer = ReplicatedStorage.Events.ShowDocumentServer

local CreateCharacter = ReplicatedStorage.Functions:WaitForChild("CreateCharacter")

local Players = game:GetService("Players")

local function DetectPlayersInRadius(centerPosition, radius)
	local playersInRadius = {}
	local players = Players:GetPlayers()
	for _, player in players do
		local character = player.Character
		if not character then return end
		
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then return end
		
		local distance = (humanoidRootPart.Position - centerPosition).magnitude
		if distance <= radius then
			table.insert(playersInRadius, player)
		end
	end
	return playersInRadius
end

ShowDocumentServer.OnServerEvent:Connect(function(player)
	--local example = {
	--	Name = "MAREK",
	--	LastName = "STONOGA",
	--	BirthDate = "01.03.2137"
	--}
	--DataManager:SetData(player, "CharacterInfo", example)
	
	local documentData = DataManager:GetData(player).Data.CharacterInfo
	documentData["ID"] = player.UserId
	warn(documentData)

	local documentData = {
		["Type"] = "ID",
		["Info"] = documentData,
	}
	
	local playercharacter = player.Character
	local humanoidRootPart = playercharacter:FindFirstChild("HumanoidRootPart")
	
	local playersNearby = DetectPlayersInRadius(humanoidRootPart.Position, 20)
	for _, nearbyPlayer in playersNearby do
		warn(nearbyPlayer.Name)
		ShowDocumentClient:FireClient(nearbyPlayer, documentData)
	end
	
end)

game.Players.PlayerAdded:Connect(function(player)
	task.wait(10)
	local documentData = DataManager:GetData(player).Data.CharacterInfo
	warn(documentData)

	if not documentData then
		warn("chuj")
		--warn(DataManager:GetData(player).Data)
		warn(documentData)
		UIStatusEvent:FireClient(player, player.PlayerGui.Group.CreateCharacterUI, nil, true)
	else
		--UIStatusEvent:FireClient(player, player.PlayerGui.Group.CreateCharacterUI, nil, true)
			player:SetAttribute("Name", documentData.Name)
			player:SetAttribute("LastName", documentData.LastName)
			player:SetAttribute("BirthDate", documentData.BirthDate)
		
	end
end)
CreateCharacter.OnServerInvoke = function(player, Name, LastName, Date, Gender)
	warn(Name)
	warn(LastName)
	warn(Date)
	warn(Gender)
	local example = {
		Name = Name,
		LastName = LastName,
		BirthDate = Date
	}
	warn("testttt")
	DataManager:SetData(player, "CharacterInfo", example)

	wait(0.1)
	local documentData = DataManager:GetData(player).Data.CharacterInfo
	
	player:SetAttribute("Name", documentData.Name)
	player:SetAttribute("LastName", documentData.LastName)
	player:SetAttribute("BirthDate", documentData.BirthDate)
	
	return true
end

--CreateCharacter.OnServerInvoke:Connect(function(player, Name, LastName, Date, Gender)
--	warn(Name)
--	warn(LastName)
--	warn(Date)
--	warn(Gender)
--	local example = {
--		Name = Name:upper(),
--		LastName = LastName:upper(),
--		BirthDate = Date
--	}
--	warn("testttt")
--	DataManager:SetData(player, "CharacterInfo", example)
	
--	return true
--end)

--CreateCharacter.OnServerInvoke = function(player, amount)
--	warn(player)
--end
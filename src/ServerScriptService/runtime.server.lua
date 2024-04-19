--!nocheck
local Players = game.Players
local ServerScriptStorage = game:GetService("ServerScriptService")
local EconomyHandler = require(ServerScriptStorage:WaitForChild("EconomyHandler"))
local CharacterData = require(ServerScriptStorage:WaitForChild("CharacterData"))
--//Private functions

local function onPlayerAdded(Player: Player)
	EconomyHandler:MakePlayerProfile(Player)
	CharacterData:OnPlayerAdded(Player)
end

local function onPlayerRemoving(Player: Player)
	EconomyHandler:exit(Player)
	CharacterData:OnPlayerRemoved(Player)
end

--//Runner

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
--local ReplicatedStorage = game.ReplicatedStorage
--local ServerScriptService = game.ServerScriptService

--local DataManager = require(ServerScriptService.CharacterData)

--game.Players.PlayerAdded:Connect(function(player)
--	task.wait(5)
--	local documentData = DataManager:GetData(player).Data.CharacterInfo

--	warn(documentData)
	
--	if not documentData then
--		warn("chuj")
--		warn(DataManager:GetData(player).Data)
--		warn(documentData)
--	else
--		warn("idk")
--		warn(documentData)
--	end
--end)
local ReplicatedStorage = game.ReplicatedStorage
local ApartamentJoin = ReplicatedStorage.Events.ApartamentJoin
local ApartamentExit = ReplicatedStorage.Events.ApartamentExit

local ShowOnlyWhitelistedPlayers = ReplicatedStorage.Events.ShowOnlyWhitelistedPlayers
local HideOnlyWhitelistedPlayers = ReplicatedStorage.Events.HideOnlyWhitelistedPlayers
local ShowAllPlayers  = ReplicatedStorage.Events.ShowAllPlayers

local ApartamentPlayerList = {}

local playerData = {
	["91"] = {
		["type"] = "apartament",
		["model"] = "test1",
		["id"] = "91",
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


return {
	tagName = "Apartament",
	
	--- Zwraca instancje do janitora
	onInstanceAdded = function(instance: BasePart): () -> ()

		local prompt = Instance.new("ProximityPrompt")
		prompt.Parent = instance
		
		if instance:GetAttribute("ApartamentJoin") then
			prompt.ActionText = "Wejdz do mieszkania"
		else
			prompt.ActionText = "Wyjdz z mieszkania"
		end

		prompt.HoldDuration = 1

		prompt.Triggered:Connect(function(player)

			local ApartamentNameJoin = instance:GetAttribute("ApartamentJoin")
			local ApartamentNameExit = instance:GetAttribute("ApartamentExit")
			local ApartamentType = instance:GetAttribute("ApartamentType")
			
			local AparamentId = 91

			if instance:GetAttribute("ApartamentJoin") then

				local FrameList = player.PlayerGui.Group.AparamentEnter.Frame.Frame.Frame


				for _, child in pairs(FrameList:GetChildren()) do
					if child:IsA("TextButton") and child.Name ~= "Exit" then
						child:Destroy()
					end
				end

				for _, playerData in pairs(playerData) do
					if playerData.type == "apartament" then
							if playerData.owner == tostring(player.UserId) then
								warn("jest wlascicielem")

								

								local ApartamentFrame = FrameList.UIListLayout.TextButton:Clone()

								ApartamentFrame.LayoutOrder = 1

								ApartamentFrame.Name = playerData.id
								ApartamentFrame.ApartamentLabel.Text = "Apartament " ..playerData.id
								ApartamentFrame.OwnerLabel.Text = "OWNER - " .. playerData.owner

								ApartamentFrame.Parent = FrameList
							else
								warn("nie jest wlascicielem")
							end
					end
				end

				-- InBuilding - id aparamentu
				
				--local ApartamentTeleport = game.Workspace:WaitForChild("Apartaments"):WaitForChild(ApartamentType):WaitForChild(ApartamentNameJoin).Teleport
				
				--player.Character.HumanoidRootPart.CFrame = ApartamentTeleport.CFrame

				--add player to array in ApartamentPlayerList[AparamentId]
				-- ApartamentPlayerList[AparamentId] = {
				-- 	ApartamentPlayerList[AparamentId],
				-- 	[player.UserId] = true
				-- }

				if not ApartamentPlayerList[AparamentId] then
					ApartamentPlayerList[AparamentId] = {}
				end

				table.insert(ApartamentPlayerList[AparamentId], player)

				-- jesli wchodze do apartamentu to mam widziec tylko graczy którzy są w nim w srodku 
				-- i tak samo oni maja mnie zobaczyć ze tez tam jestem czyli reload whitelisted viisblity

				warn(ApartamentPlayerList[AparamentId])
				ApartamentJoin:FireClient(player, ApartamentType, ApartamentNameJoin, AparamentId)

				ShowOnlyWhitelistedPlayers:FireClient(player, ApartamentPlayerList[AparamentId])

				for _, playerInApartament in pairs(ApartamentPlayerList[AparamentId]) do
					if player == playerInApartament then return end
					ShowOnlyWhitelistedPlayers:FireClient(playerInApartament, ApartamentPlayerList[AparamentId])
				end

			end
			
			
			if instance:GetAttribute("ApartamentExit") then
				--remove player from array in ApartamentPlayerList[AparamentId]
				
				-- get index of player in array

				local index = table.find(ApartamentPlayerList[AparamentId], player)

				-- warn(ApartamentPlayerList[AparamentId])
				-- warn(player)
				table.remove(ApartamentPlayerList[AparamentId], index)
				
				-- warn(index)
				-- warn(ApartamentPlayerList[AparamentId])

				-- warn(ApartamentPlayerList[AparamentId])
				ApartamentExit:FireClient(player, ApartamentType, ApartamentNameExit, AparamentId)
				
				ShowAllPlayers:FireClient(player)


				-- jesli wychodze z apartamentu to mam widziec wszystkich graczy
				-- ale ci co tam zostali to mnie juz nie mają widzieć

				--ShowOnlyWhitelistedPlayers
				for _, playerInApartament in pairs(ApartamentPlayerList[AparamentId]) do
					if player == playerInApartament then return end
					ShowOnlyWhitelistedPlayers:FireClient(playerInApartament, ApartamentPlayerList[AparamentId])
				end
			end
			
		end)

		return function()
			prompt:Destroy()
		end
	end,
}
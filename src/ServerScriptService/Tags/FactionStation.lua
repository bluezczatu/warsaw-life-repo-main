local CollectionService = game:WaitForChild("CollectionService")
local ReplicatedStorage = game:WaitForChild("ReplicatedStorage")

return {
	tagName = "FactionStation",

	onInstanceAdded = function(instance: Instance): () -> ()
		local circleRemoveButton = ReplicatedStorage.Events.CircleRemoveButton -- TODO: <- NIGDZIE NIE UZYTY VARIABLE
		local circleAddButton = ReplicatedStorage.Events.CircleAddButton -- TODO: <- SAME CASE AS ABOVE
		local test = 1 -- TODO: KOLEJNY NIE UZYTY VARIABLE XD

		local prompt = Instance.new("ProximityPrompt"):Clone()
		prompt.Parent = instance
		prompt.ActionText = "Wejdz lub zejdz z służby"
		prompt.HoldDuration = 0.5

		prompt.Triggered:Connect(function(player)
			local faction = instance:GetAttribute("Faction")
			local factions = player:GetAttribute("Factions")
			if not factions:match(faction) then return end
			
			if player:GetAttribute("FactionDuty") then
				player:SetAttribute("FactionDuty",nil)
				CollectionService:RemoveTag(player, "FactionDuty")
				warn("ZSZEDŁ Z SŁUŻBY: "..faction)
			else
				player:SetAttribute("FactionDuty",faction)
				CollectionService:AddTag(player, "FactionDuty")
				warn("WSZEDŁ NA SŁUŻBE: "..faction)
			end
		end)

		return function()
			-- TODO: CLEANUP
		end
	end,
}

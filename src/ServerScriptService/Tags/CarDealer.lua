local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIStatusEvent = ReplicatedStorage.Events.UIStatus

return {
	tagName = "CarDealer",

	onInstanceAdded = function(instance: Instance): () -> ()
		
		local prompt = Instance.new("ProximityPrompt")
		prompt.Parent = instance
		prompt.ActionText = "Otwórz Bagażnik"
		prompt.HoldDuration = 0.5
		prompt.Triggered:Connect(function(player)
			UIStatusEvent:FireClient(player, player.PlayerGui.Group.CarDealer, nil, true)
		end)
		
		prompt.PromptButtonHoldBegan :Connect(function(player)
			-- TODO: tutaj akcja po uzyciu proximity prompta
		end)

		return function()
			prompt:Destroy()
		end
	end
}

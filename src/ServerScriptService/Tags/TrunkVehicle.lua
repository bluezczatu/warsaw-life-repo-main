local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	tagName = "TrunkVehicle",

	onInstanceAdded = function(instance: Instance): () -> ()
		local gui = ReplicatedStorage.GuiAssets:WaitForChild("CarDealer")

		local prompt = Instance.new("ProximityPrompt")
		prompt.Parent = instance
		prompt.ActionText = "Otwórz CarDealera"
		prompt.HoldDuration = 0.5
		prompt.MaxActivationDistance = 5

		prompt.PromptButtonHoldBegan:Connect(function(player)
			local m1 = instance.Parent.BL.SS.Motor
			local m2 = instance.Parent.BR.SS.Motor
				
				
			
				warn("xd")
				if m1.DesiredAngle == 0 then
					m1.DesiredAngle = -2
					--script.Parent.Parent.DoorOpen:Play()
				elseif m1.DesiredAngle == -2 then
					warn("xd2")
					m1.DesiredAngle = 0
					while m1.CurrentAngle < 0 do wait() end
					--script.Parent.Parent.DoorClose:Play()
				end
				
			warn("xd")
			if m2.DesiredAngle == 0 then
				m2.DesiredAngle = -2
				--script.Parent.Parent.DoorOpen:Play()
			elseif m2.DesiredAngle == -2 then
				warn("xd2")
				m2.DesiredAngle = 0
				while m2.CurrentAngle < 0 do wait() end
				--script.Parent.Parent.DoorClose:Play()
			end

		end)

		return function()
			prompt:Destroy()
		end
	end
}

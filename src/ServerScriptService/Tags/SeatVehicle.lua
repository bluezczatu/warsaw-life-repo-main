
return {
	tagName = "SeatVehicle",
	--- Zwraca instancje do janitora
	onInstanceAdded = function(instance: Instance): () -> ()
		local m = nil

		--warn(instance)
		
		local prompt = Instance.new("ProximityPrompt")
		local part = Instance.new("Part")
		
		local weld = Instance.new("WeldConstraint")
		
		weld.Parent = instance
		
		part.Anchored = true
		part.CanCollide = false
		part.Transparency = 1
		part.Size = Vector3.new(1,1,1)
		
		--local m = instance.Parent.Misc.FL.SS
		
		local doors = nil
		
		
		local exitCframe = nil
		if instance:GetAttribute("Seat") == "Left" then
			exitCframe = instance.CFrame * CFrame.new(-2, 0, 0)
			doors = "FL"
		end

		if instance:GetAttribute("Seat") == "Right" then
			exitCframe = instance.CFrame * CFrame.new(2, 0, 0)
			doors = "FR"
		end
		
		part.CFrame = exitCframe
		
		weld.Part0 = instance
		weld.Part1 = part
		part.Parent = instance
		
		prompt.Parent = part
		prompt.ActionText = "wejdz do auta"
		prompt.HoldDuration = 0.5
		prompt.MaxActivationDistance = 5

		prompt.Triggered:Connect(function(player)
			local character = player.Character or player.CharacterAdded:Wait()

			local m = instance.Parent.Misc:FindFirstChild(doors).SS.Motor

			if m.DesiredAngle == 0 then
				m.DesiredAngle = -1
				script.DoorOpen:Play()
			end
			
			task.wait(0.5)
			
			character.Humanoid.Sit = false
			warn(player)
			prompt.Enabled = false
			local character = player.Character or player.CharacterAdded:Wait()
			instance:Sit(character.Humanoid)
			character.Humanoid.JumpPower = 0.1
			character.Humanoid.UseJumpPower = true
			
			task.wait(0.5)
			
			if m.DesiredAngle == -1 then
				warn("xd2")
				m.DesiredAngle = 0
				while m.CurrentAngle < 0 do wait() end
				script.DoorClose:Play()
			end
			
			character.Humanoid:GetPropertyChangedSignal("Sit"):Once(function()
				local charexitCframe = nil
				if instance:GetAttribute("Seat") == "Left" then
					charexitCframe = instance.CFrame * CFrame.new(-4, 0, 0)
				end

				if instance:GetAttribute("Seat") == "Right" then
					charexitCframe = instance.CFrame * CFrame.new(4, 0, 0)
				end
				
				if m.DesiredAngle == 0 then
					m.DesiredAngle = -1
					script.DoorOpen:Play()
				end

				
				--character.HumanoidRootPart.Anchored = true
				
				character.HumanoidRootPart.CFrame = charexitCframe
				prompt.Enabled = true
				

				wait(0.5)
				
				if m.DesiredAngle == -1 then
					warn("xd2")
					m.DesiredAngle = 0
					while m.CurrentAngle < 0 do wait() end
					script.DoorClose:Play()
				end
				
				--character.HumanoidRootPart.Anchored = false
				character.Humanoid.UseJumpPower = false
			end)


			
			--wait(1)
			--warn(character.Humanoid.Animator:GetPlayingAnimationTracks())
			--wait(2)
			--character.Humanoid.Sit = false
			--wait(0.1)
			
			--local exitCframe = nil
			--if instance:GetAttribute("Seat") == "Left" then
			--	exitCframe = character.HumanoidRootPart.CFrame * CFrame.new(-5, 0, 0)
			--end
			
			--if instance:GetAttribute("Seat") == "Right" then
			--	exitCframe = character.HumanoidRootPart.CFrame * CFrame.new(5, 0, 0)
			--end
			
			--character.HumanoidRootPart.CFrame = exitCframe
			--prompt.Enabled = true
			--character.Humanoid.UseJumpPower = false
			
			
		end)
			

		return function()
			-- tutaj jak sie tag usunie to sie wykona  (cleanup)
			

		end
	end,
}

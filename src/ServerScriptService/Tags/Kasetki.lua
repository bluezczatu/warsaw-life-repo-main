local Utils = game.ServerScriptService.Utils

local EconomyHandler = require(game.ServerScriptService.EconomyHandler)
local ProgressionBar = require(Utils.ProgressionBar)


return {
	tagName = "Kasetka",
	
	--- Zwraca instancje do janitora
	onInstanceAdded = function(instance: BasePart): () -> ()
		local prompt = Instance.new("ProximityPrompt")
		prompt.Parent = instance
		prompt.ActionText = "Opierdol kasetke"
		prompt.HoldDuration = 1
		
		prompt.Triggered:Connect(function(player)
			print(instance:GetAttribute("regenerating"))
			if instance:GetAttribute("regenerating") then return end
			
			local character = player.Character
			if instance:GetAttribute("stealing") then 
				if game.Players:GetPlayerByUserId(instance:GetAttribute("stealing")) then
					return
				end
			end

			instance:SetAttribute("stealing", player.UserId)
			prompt.Parent = nil
			
			character.HumanoidRootPart.Anchored = true
			character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, Vector3.new(instance.Position.X, character.HumanoidRootPart.Position.Y, instance.Position.Z))

			ProgressionBar.new(player, "Opierdalanie kasetki", 5, function(success)
				print(success)
				
				character.HumanoidRootPart.Anchored = false

				if not success then
					
					instance:SetAttribute("stealing", nil)
					prompt.Parent = instance
					
				else
					if instance:GetAttribute("stealing") ~= player.UserId then return end
					instance:SetAttribute("stealing", nil)

					--EconomyHandler:AddMoney(player, "Cash", math.random(instance:GetAttribute("MinCash"), instance:GetAttribute("MaxCash")))
					
					
					-- regenerating
					instance:SetAttribute("regenerating", true)
					local oldText = prompt.ActionText
					prompt.ActionText = "Regenerowanie..."
					wait(10)
					instance:SetAttribute("regenerating", nil)
					prompt.Parent = instance
					prompt.ActionText = oldText
				end
			end)
		end)

		return function()
			prompt:Destroy()
		end
	end
}
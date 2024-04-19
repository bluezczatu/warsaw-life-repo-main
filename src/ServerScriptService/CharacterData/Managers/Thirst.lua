return function(data)
	--reset thirst on character added
	data.player.CharacterAdded:Connect(function()
		data.SetData("Thirst", 100)	
	end)

	--damage player if points <= 0
	local function DamagePlayer()
		local Humanoid = data.player.Character.Humanoid
		Humanoid:TakeDamage(15)
	end

	--take points from player data
	local function TakePoints()
		if data.player.Character then
			local Data = data:GetData()
			if not Data.Data.Thirst then return end
			local Thirst = Data.Data.Thirst
			if Thirst > 0 then
				data.SetData("Thirst", Thirst-1)
			else
				DamagePlayer()
			end	
		end
	end

	--loop
	while data.player do
		task.wait(7.5)
		TakePoints()
	end
end


--init
return function(data)
	warn(data)
	--reset saturation on character added
	data.player.CharacterAdded:Connect(function()
		data.SetData("Saturation", 100)	
	end)
	
	--damage data.player if points <= 0
	local function DamagePlayer()
		local Character = data.player.Character
		local Humanoid = Character.Humanoid
		Humanoid:TakeDamage(15)
	end

	--take points from data.player data
	local function TakePoints()
		if data.player.Character then
			local Data = data:GetData(data.player)
			if not Data.Data.Saturation then return end
			local Saturation = Data.Data.Saturation
			if Saturation > 0 then
				data.SetData("Saturation", Saturation-1)
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
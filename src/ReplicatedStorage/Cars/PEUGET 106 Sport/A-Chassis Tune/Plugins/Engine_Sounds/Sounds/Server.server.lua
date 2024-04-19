newsounds={}
local function create(car,t)
	for k=0,4 do
		local ns=Instance.new('Sound')
		if k==1 then
			ns.Name='Exhaust'
			ns.Parent=car.Body.Exhaust
			ns.SoundId='rbxassetid://'..t[1]
			ns.Volume=0
			ns.RollOffMaxDistance=t[2]
			ns.RollOffMinDistance=t[3]
			local e1=Instance.new('EqualizerSoundEffect',ns)
			e1.Name='E1'
			e1.HighGain=t[13][1]
			e1.MidGain=t[13][2]
			e1.LowGain=t[13][3]
			local e2=Instance.new('DistortionSoundEffect',ns)
			e2.Name='E2'
			local e3=Instance.new('EqualizerSoundEffect',ns)
			e3.Name='E3'
			e3.MidGain=0
		elseif k==2 then
			ns.Name='Engine'
			ns.Parent=car.Body.Engine
			ns.SoundId='rbxassetid://'..t[4]
			ns.Volume=0
			ns.RollOffMaxDistance=t[5]
			ns.RollOffMinDistance=t[6]
			local e1=Instance.new('EqualizerSoundEffect',ns)
			e1.Name='E1'
			e1.HighGain=t[14][1]
			e1.MidGain=t[14][2]
			e1.LowGain=t[14][3]
			local e2=Instance.new('DistortionSoundEffect',ns)
			e2.Name='E2'
			local e3=Instance.new('EqualizerSoundEffect',ns)
			e3.Name='E3'
			e3.MidGain=0
		elseif k==3 then
			ns.Name='Idle'
			ns.Parent=car.Body.Exhaust
			ns.SoundId='rbxassetid://'..t[7]
			ns.Volume=0
			ns.RollOffMaxDistance=t[8]
			ns.RollOffMinDistance=t[9]
		elseif k==4 then
			ns.Name='Redline'
			ns.Parent=car.Body.Engine
			ns.SoundId='rbxassetid://'..t[10]
			ns.Volume=0
			ns.RollOffMaxDistance=t[11]
			ns.RollOffMinDistance=t[12]
		end
		ns.Looped=true
		table.insert(newsounds,k,ns)
	end
end

local function update(sounds,info)
	if newsounds[1].Volume~=info[1] then 
		newsounds[1].Volume=info[1]
		newsounds[1].Pitch=info[2]
		newsounds[2].Volume=info[3]
		newsounds[2].Pitch=info[4]
		newsounds[3].Volume=info[5] 
		newsounds[4].Volume=info[6]
		newsounds[1].E2.Level=info[7]
		newsounds[1].E3.HighGain=info[9][1]
		newsounds[1].E3.MidGain=info[9][2]
		newsounds[1].E3.LowGain=info[9][3]
		newsounds[2].E2.Level=info[8]
		newsounds[2].E3.HighGain=info[10][1]
		newsounds[2].E3.MidGain=info[10][2]
		newsounds[2].E3.LowGain=info[10][3]
	end
end

script.Parent.OnServerEvent:Connect(function(plr,car,func,...)
	if func=='create' then
		if #newsounds<1 then create(car,...) end
		
	elseif func=='update' then
		update(...)
	elseif func=='stop' then
		for _,s in pairs(newsounds) do s:Stop() end
	elseif func=='play' then
		for _,s in pairs(newsounds) do s:Play() end
		
	end
end)
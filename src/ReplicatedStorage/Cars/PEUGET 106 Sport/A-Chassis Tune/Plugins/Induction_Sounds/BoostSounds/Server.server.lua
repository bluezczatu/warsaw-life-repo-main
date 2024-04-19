newsounds={}
local function create(car,info)
	for k=0,3 do
		local ns=Instance.new('Sound')
		ns.Parent=car.Body.Engine
		if k==1 then
			ns.Name='Turbo'
			ns.SoundId='rbxassetid://'..info[1]
			ns.Volume=0
			ns.RollOffMaxDistance=info[2]
			ns.RollOffMinDistance=info[3]
			ns.Looped=true
		elseif k==2 then
			ns.Name='Super'
			ns.SoundId='rbxassetid://'..info[4]
			ns.Volume=0
			ns.RollOffMaxDistance=info[5]
			ns.RollOffMinDistance=info[6]
			ns.Looped=true
		elseif k==3 then
			ns.Name='Bov'
			ns.SoundId='rbxassetid://'..info[7]
			ns.Volume=0
			ns.RollOffMaxDistance=info[8]
			ns.RollOffMinDistance=info[9]
			ns.Looped=false
		end
		ns:Play()
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
		newsounds[3].Pitch=info[6]
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
	elseif func=='bovplay' then
		newsounds[3]:Play()
	end
end)
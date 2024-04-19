-- Editable Values
local TurboId = 240323039
local SuperId = 404779487
local BovId = 3568930062

local TurboVol = .025				--Per Psi
local TurboRollOffMax = 1000
local TurboRollOffMin = 10

local SuperVol = .025				--Per Psi
local SuperRollOffMax = 1000
local SuperRollOffMin = 10

local BovVol = .025				--Per Psi
local BovRollOffMax = 1000
local BovRollOffMin = 10
local BovSensitivity = .5

local TurboSetPitch = 1		--Base Pitch
local SuperSetPitch = .8	--Base Pitch
local BovSetPitch = .7		--Base Pitch
local TurboPitchIncrease = .05	--Per Psi
local SuperPitchIncrease = .05	--Per Psi
local BovPitchIncrease = .05	--Per Psi

local FE=true
-- End of Editable Values

local car = script.Parent.Car.Value
local values = script.Parent.Values
local tune = require(car["A-Chassis Tune"])
local event = car:WaitForChild('BoostSounds')
local newsounds={}

local bst=values.Boost
local throt=values.Throttle
local pbst=-1000

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
local function play()
	for _,s in pairs(newsounds) do s:Play() end
end
local function stop()
	for _,s in pairs(newsounds) do s:Stop() end
end
local function turboupd(x)
	info[1]=TurboVol*math.floor(values.BoostTurbo.Value)
	info[2]=TurboSetPitch+(TurboPitchIncrease*values.BoostTurbo.Value)
	info[5]=BovVol*math.floor(values.BoostTurbo.Value)
	info[6]=BovSetPitch+(BovPitchIncrease*values.BoostTurbo.Value)
end
local function superupd(x)
	info[3]=SuperVol*values.BoostSuper.Value
	info[4]=SuperSetPitch+(SuperPitchIncrease*values.BoostSuper.Value)
end
local function twinupd(x)
	info[1]=TurboVol*math.floor(values.BoostTurbo.Value)
	info[2]=TurboSetPitch+(TurboPitchIncrease*values.BoostTurbo.Value)
	info[3]=SuperVol*values.BoostSuper.Value
	info[4]=SuperSetPitch+(SuperPitchIncrease*values.BoostSuper.Value)
	info[5]=BovVol*math.floor(values.BoostTurbo.Value)
	info[6]=BovSetPitch+(BovPitchIncrease*values.BoostTurbo.Value)
end

info = {TurboId,TurboRollOffMax,TurboRollOffMin,SuperId,SuperRollOffMax,SuperRollOffMin,BovId,BovRollOffMax,BovRollOffMin}
if FE==true then
	event:FireServer(car,'create',info)
	
	if values.Parent.IsOn.Value==true then
		event:FireServer(car,'play')
	else event:FireServer(car,'stop')
	end
elseif FE==false then
	create(car,info)
	
	if values.Parent.IsOn.Value==true then
		play()
	else
		stop()
	end
end

if BovId>0 then
	throt.Changed:Connect(function()
		local pbst=bst.Value
		wait(.1)
		if bst.Value+BovSensitivity<pbst then
			if FE==true then
				event:FireServer(car,'bovplay')
			else
				newsounds[3]:Play()
			end
		end
	end)
end

if tune.Turbochargers>0 and tune.Superchargers==0 then
	info[3]=0
	info[4]=0
	bst.Changed:Connect(function(x)
		turboupd()
		if FE==true then
			event:FireServer(car,'update',nil,info)
		else
			update(newsounds,info)
		end
	end)
	
elseif tune.Superchargers>0 and tune.Turbochargers==0 then
	info[1]=0
	info[2]=0
	info[5]=0
	info[6]=0
	bst.Changed:Connect(function(x)
		superupd(x)
		if FE==true then
			event:FireServer(car,'update',nil,info)
		else
			update(newsounds,info)
		end
	end)
	
elseif tune.Turbochargers>0 and tune.Superchargers>0 then
	bst.Changed:Connect(function(x)
		twinupd(x)
		if FE==true then
			event:FireServer(car,'update',nil,info)
		else
			update(newsounds,info)
		end
	end)
end
	
values.Parent.IsOn.Changed:Connect(function(v)
	if v==false and FE==true then event:FireServer(car,'stop')
	elseif v==true and FE==true then event:FireServer(car,'play')
	elseif v==false and FE==false then stop()
	elseif v==true and FE==false then play() end
end)
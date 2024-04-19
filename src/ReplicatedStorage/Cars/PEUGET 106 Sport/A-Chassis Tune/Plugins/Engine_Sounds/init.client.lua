-- Editable Values
local ExhaustId = 1520959507
local EngineId = 1520959507
local IdleId = 5226685480
local RedlineId = 5070456793

local ExhaustVol = .5
local ExhaustRollOffMax = 1000
local ExhaustRollOffMin = 10
local ExhaustVolMult = 1.05

local EngineVol = .05
local EngineRollOffMax = 1000
local EngineRollOffMin = 15
local EngineVolMult = 1.25

local IdleVol = 1
local IdleRollOffMax = 1000
local IdleRollOffMin = 5
local IdleRPMScale = 1500

local RedlineVol = .5
local RedlineRollOffMax = 1000
local RedlineRollOffMin = 5

local ExhaustPitch = .3
local EnginePitch = .5
local ExhaustRev = 1
local EngineRev = .8

local ExhaustEqualizer = {0,4,6}
local EngineEqualizer = {0,4,6}

local ExhaustDecelEqualizer = {-25,0,5}
local EngineDecelEqualizer = {-25,0,5}

local ThrottleVolMult = .5
local ThrottlePitchMult = .1

local ExhaustDistortion = .0
local ExhaustRevDistortion = .3
local EngineDistortion = .2
local EngineRevDistortion = .5

local FE=true
-- End of Editable Values

local car = script.Parent.Car.Value
local values = script.Parent.Values
local tune = require(car["A-Chassis Tune"])
local event = car:WaitForChild('Sounds')
local newsounds={}
local info={}

local rpm=values.RPM
local throt=values.Throttle
local redl=tune.Redline
local bounce=tune.RevBounce+100
local vmult=1-ThrottleVolMult
local pmult=1-ThrottlePitchMult

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

local function stop()
	for _,s in pairs(newsounds) do s:Stop() end
end

local function play()
	for _,s in pairs(newsounds) do s:Play() end
end

local function rpmupdate(x)
	local throtv=throt.Value
	local rpmscale=(x/redl)
	info[1]=((x^ExhaustVolMult)/redl)*((throtv*ThrottleVolMult)+vmult)*ExhaustVol								-- Exhaust Volume
	info[2]=math.max(ExhaustPitch + ExhaustRev *rpmscale*((throtv*ThrottlePitchMult)+pmult),ExhaustPitch)		-- Exhaust Pitch
	info[3]=((x^EngineVolMult)/redl)*((throtv*ThrottleVolMult)+vmult)*EngineVol									-- Engine Volume
	info[4]=math.max(EnginePitch + EngineRev *rpmscale*((throtv*ThrottlePitchMult)+pmult),EnginePitch)			-- Engine Pitch
	info[5]=IdleVol+(x/(-tune.IdleRPM-IdleRPMScale))															-- Idle Volume
	info[6]=(((x+bounce)-redl)/redl)*throtv*RedlineVol*100														-- Redline Volume
	info[7]=throtv*(ExhaustDistortion+(ExhaustRevDistortion*rpmscale))											-- Exhaust Distortion
	info[8]=throtv*(EngineDistortion+(EngineRevDistortion*rpmscale))											-- Engine Distortion
	info[9]={ExhaustDecelEqualizer[1]*(1-throtv),ExhaustDecelEqualizer[2]*(1-throtv),ExhaustDecelEqualizer[3]*(1-throtv)}	-- Exhaust Decel Equalizer
	info[10]={EngineDecelEqualizer[1]*(1-throtv),EngineDecelEqualizer[2]*(1-throtv),EngineDecelEqualizer[3]*(1-throtv)}		-- Engine Decel Equalizer
	if FE==true then
		event:FireServer(car,'update',nil,info)
	else
		update(newsounds,info)
	end
end

createinfo = {
	ExhaustId,
	ExhaustRollOffMax,
	ExhaustRollOffMin,
	EngineId,
	EngineRollOffMax,
	EngineRollOffMin,
	IdleId,
	IdleRollOffMax,
	IdleRollOffMin,
	RedlineId,
	RedlineRollOffMax,
	RedlineRollOffMin,
	ExhaustEqualizer,
	EngineEqualizer,
}

if FE==true then
	event:FireServer(car,'create',createinfo)
else
	create(car,createinfo)
end

if FE==true then
	if values.Parent.IsOn.Value==true then
		event:FireServer(car,'play')
		else event:FireServer(car,'stop')
	end
else
	if values.Parent.IsOn.Value==true then
		play() else stop()
	end
end

values.Parent.IsOn.Changed:Connect(function(v)
	if FE==true then
		if v==false then event:FireServer(car,'stop')
		else event:FireServer(car,'play') end
	else
		if v==true then
			play() else stop()
		end
	end
end)

rpm.Changed:Connect(rpmupdate)
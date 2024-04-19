  				    --//AC6 Ported Plugin [SS6]//--
				  --//SecondLogic x INSPARE 2017//--

-- RTRA Edition: specifically tuned to meet our guidelines
-- Altering any of the values below past their maximum will get your slot deleted and a week in muted
-- Any values that have a note beside of them are allowed to be changed. 
-- Any values with nothing next to them are to be left as is, i'll kick your ass too


local _Select = "Summer"

-- Current presets:
-- AllSeason
-- Summer
-- Slicks
-- SemiSlicks

-- Read notes below for an explanation on tire behavior. Do not exceed the maximum set limit.
-- If running staggered friction (different front and rear friction) the front-rear variation cannot exceed .1

-- Example

-- Legal:
-- Rear Target .7 
-- Front Target .6 

-- Illegal:
-- Rear Target .7 
-- Front Target .5

local _AllSeason = { 

--[[ ALL SEASON - Tires designed for everyday use.

PROS

- Good wet and snow traction
- Doesn't wear as quickly as other compounds
- Retains most of its grip even after fully way down

 CONS

- Worst overall initial grip

STREET LEGAL - YES

--]]

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed			= .2    , 
    FTargetFriction   	= .4   	, --MAX .5
    FMinFriction      	= 0.25   ,

    RWearSpeed        	= .2    , 
    RTargetFriction    	= .4	 	, --MAX .5
    RMinFriction    	= 0.25   ,

    --Tire Slip
    TCSOffRatio        	= 1     ,
    WheelLockRatio    	= 1/6   , 
    WheelspinRatio    	= 1/1.2 ,  

    --Wheel Properties
    FFrictionWeight    	= 2     , 
    RFrictionWeight    	= 2     , 
    FLgcyFrWeight    	= 0     , 
    RLgcyFrWeight    	= 0     , 

    FElasticity        	= 0     , 
    RElasticity        	= 0     , 
    FLgcyElasticity    	= 0     , 
    RLgcyElasticity    	= 0     , 

    FElastWeight    	= 1     , 
    RElastWeight    	= 1     , 
    FLgcyElWeight    	= 10    , 
    RLgcyElWeight    	= 10    , 

    --Wear Regen
    RegenSpeed        	= 3.6	, 
}

local _Summer = {

--[[ SUMMER - Tires designed for spirited driving on roads.

PROS

- Good balance between wet/snow and dry performance
- Doesn't wear as quickly as other compounds

 CONS

- Wears faster than all-seasons
- Keeps less grip once fully worn down

- STREET LEGAL - YES

--]]

	TireWearOn         = true    ,

    --Friction and Wear
    FWearSpeed			= .35   , 
    FTargetFriction   	= .6   	, --MAX .6
    FMinFriction      	= 0.35  ,

    RWearSpeed        	= .35   , 
    RTargetFriction    	= .6 	, --MAX .6
    RMinFriction    	= 0.35  ,

    --Tire Slip
    TCSOffRatio        	= 1     ,
    WheelLockRatio    	= 1/6   , 
    WheelspinRatio    	= 1/1.2 ,  

    --Wheel Properties
    FFrictionWeight    	= 1     , 
    RFrictionWeight    	= 1     , 
    FLgcyFrWeight    	= 0     , 
    RLgcyFrWeight    	= 0     , 

    FElasticity        	= 0     , 
    RElasticity        	= 0     , 
    FLgcyElasticity    	= 0     , 
    RLgcyElasticity    	= 0     , 

    FElastWeight    	= 1     , 
    RElastWeight    	= 1     , 
    FLgcyElWeight    	= 10    , 
    RLgcyElWeight    	= 10    , 

    --Wear Regen
    RegenSpeed        	= 3.6	, 
}

local _Slicks = {

--[[ SLICKS - Tires designed for racetrack driving, good for a few laps before needing to cool off

PROS

- Highest initial grip

 CONS

- Super soft compound wears very fast
- Keeps least amount of grip once fully worn down
- Worthless in adverse weather conditions

STREET LEGAL - ABSOLUTELY NOT

--]]

	TireWearOn         = true   ,

    --Friction and Wear
    FWearSpeed        	= .05  	, 
    FTargetFriction    	= 1	, --MAX .8
    FMinFriction     	= 0.2	,

    RWearSpeed        	= .05   	, 
    RTargetFriction    	= 1.6  	, --MAX .8
    RMinFriction    	= 0.2   ,

    --Tire Slip
    TCSOffRatio        	= 1     , 
    WheelLockRatio    	= 1/6   , 
    WheelspinRatio    	= 1/1.2 ,  

    --Wheel Properties
    FFrictionWeight    	= 0.3   , 
    RFrictionWeight    	= 0.3   , 
    FLgcyFrWeight    	= 0     , 
    RLgcyFrWeight    	= 0     , 

    FElasticity        	= 0     , 
    RElasticity        	= 0     , 
    FLgcyElasticity    	= 0     , 
    RLgcyElasticity    	= 0     , 

    FElastWeight    	= 1    	, 
    RElastWeight    	= 1    	, 
    FLgcyElWeight    	= 10   	, 
    RLgcyElWeight    	= 10   	, 

    --Wear Regen
    RegenSpeed        = 3.6		, 
}

local _SemiSlicks = {

--[[ SEMI SLICKS - Tires for people who need a road legal car but also want to put in a few laps
	
PROS

- Happy balance between dry grip and wear speed

 CONS

- Slightly less worthless than slicks in adverse weather conditions but still worthless nonetheless
- Sacrifices grip for street legality
- Still wears pretty quickly

STREET LEGAL - JUST BARELY

--]]

	TireWearOn         = true   ,

    --Friction and Wear
    FWearSpeed        	= .5    ,
    FTargetFriction    	= .7   	, --MAX .7
    FMinFriction     	= 0.3 	, 

    RWearSpeed        	= .5   	, 
    RTargetFriction    	= .7  	, --MAX .7
    RMinFriction    	= 0.3	, 

    --Tire Slip
    TCSOffRatio        	= 1     , 
    WheelLockRatio    	= 1/6   , 
    WheelspinRatio   	= 1/1.2 ,  

    --Wheel Properties
    FFrictionWeight    	= 0.7   , 
    RFrictionWeight    	= 0.7   , 
    FLgcyFrWeight    	= 0     , 
    RLgcyFrWeight    	= 0     , 

    FElasticity        	= 0     , 
    RElasticity        	= 0     , 
    FLgcyElasticity    	= 0     , 
    RLgcyElasticity    	= 0     , 

    FElastWeight    	= 1     , 
    RElastWeight    	= 1     , 
    FLgcyElWeight    	= 10    , 
    RLgcyElWeight    	= 10    , 

    --Wear Regen
    RegenSpeed        	= 3.6	, 
}

--leave everything down here alone

local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local cValues = script.Parent.Parent:WaitForChild("Values")
local _WHEELTUNE = _AllSeason

if _Select == "Slicks" then
	_WHEELTUNE = _Slicks
elseif _Select == "SemiSlicks" then
	_WHEELTUNE = _SemiSlicks
elseif _Select == "Summer" then
	_WHEELTUNE = _Summer
else
	_WHEELTUNE = _AllSeason
end

car.DriveSeat.TireStats.Fwear.Value = _WHEELTUNE.FWearSpeed
car.DriveSeat.TireStats.Ffriction.Value = _WHEELTUNE.FTargetFriction
car.DriveSeat.TireStats.Fminfriction.Value = _WHEELTUNE.FMinFriction
car.DriveSeat.TireStats.Ffweight.Value = _WHEELTUNE.FFrictionWeight
		
car.DriveSeat.TireStats.Rwear.Value = _WHEELTUNE.RWearSpeed
car.DriveSeat.TireStats.Rfriction.Value = _WHEELTUNE.RTargetFriction
car.DriveSeat.TireStats.Rminfriction.Value = _WHEELTUNE.RMinFriction
car.DriveSeat.TireStats.Rfweight.Value = _WHEELTUNE.RFrictionWeight

car.DriveSeat.TireStats.TCS.Value = _WHEELTUNE.TCSOffRatio
car.DriveSeat.TireStats.Lock.Value = _WHEELTUNE.WheelLockRatio
car.DriveSeat.TireStats.Spin.Value = _WHEELTUNE.WheelspinRatio
car.DriveSeat.TireStats.Reg.Value = _WHEELTUNE.RegenSpeed

--Wheels Array
local fDensity = _Tune.FWheelDensity
local rDensity = _Tune.RWheelDensity
local fFwght = _WHEELTUNE.FFrictionWeight
local rFwght = _WHEELTUNE.RFrictionWeight
local fElast = _WHEELTUNE.FElasticity
local rElast = _WHEELTUNE.RElasticity
local fEwght = _WHEELTUNE.FElastWeight
local rEwght = _WHEELTUNE.RElastWeight
if not workspace:PGSIsEnabled() then
	fDensity = _Tune.FWLgcyDensity
	rDensity = _Tune.RWLgcyDensity
	fFwght = _WHEELTUNE.FLgcyFrWeight
	rFwght = _WHEELTUNE.FLgcyFrWeight
	fElast = _WHEELTUNE.FLgcyElasticity
	rElast = _WHEELTUNE.RLgcyElasticity
	fEwght = _WHEELTUNE.FLgcyElWeight
	rEwght = _WHEELTUNE.RLgcyElWeight
end
local Wheels = {}
for i,v in pairs(car.Wheels:GetChildren()) do
	local w = {}
	w.wheel = v
	local ca
	w.x = 0
	if v.Name == "FL" or v.Name == "FR" or v.Name == "F" then
		ca = (12-math.abs(_Tune.FCamber))/15
		w.x = fDensity
		w.BaseHeat = _WHEELTUNE.FTargetFriction-_WHEELTUNE.FMinFriction
		w.WearSpeed = _WHEELTUNE.FWearSpeed
		w.fWeight = fFwght
		w.elast = fElast
		w.eWeight = fEwght
	else
		ca = (12-math.abs(_Tune.RCamber))/15
		w.x = rDensity
		w.BaseHeat = _WHEELTUNE.RTargetFriction-_WHEELTUNE.RMinFriction
		w.WearSpeed = _WHEELTUNE.RWearSpeed
		w.fWeight = rFwght
		w.elast = rElast
		w.eWeight = rEwght
	end
	--if car:FindFirstChild("WearData")~=nil then
	--	w.Heat = math.min(w.BaseHeat,car.WearData[v.Name].Value+(((tick()-car.WearData.STime.Value)*_WHEELTUNE.RegenSpeed*15/10000)))
	--else
		w.Heat = w.BaseHeat
	--end
	w.stress = 0
	table.insert(Wheels,w)
end

--Close/Store Wear Data
car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		local wD=car:FindFirstChild("WearData")
		if car:FindFirstChild("WearData")==nil then
			wD = script.Parent.WearData:Clone()
			wD.Parent=car
		end
		for i,v in pairs(Wheels) do
			wD[v.wheel.Name].Value = v.Heat
		end
		wD.STime.Value=tick()
	end
end)

--Runtime Loop
while wait() do
	for i,v in pairs(Wheels) do
		--Vars
		local speed = car.DriveSeat.Velocity.Magnitude
		local wheel = v.wheel.RotVelocity.Magnitude
		local z = 0		
		local deg = 0.000126
		
		--Tire Wear
		local cspeed = (speed/1.298)*(2.6/v.wheel.Size.Y) 
		local wdif = math.abs(wheel-cspeed)
		if _WHEELTUNE.TireWearOn then
			if speed < 4 then
				--Wear Regen
				v.Heat = math.min(v.Heat + _WHEELTUNE.RegenSpeed/10000,v.BaseHeat)
			else
				--Tire Wear
				if wdif > 1 then
					v.Heat = v.Heat - wdif*deg*v.WearSpeed/28
				elseif v.Heat >= v.BaseHeat then
					v.Heat = v.BaseHeat
				end
			end
		end
		
		--Apply Friction
		if v.wheel.Name == "FL" or v.wheel.Name == "FR" or v.wheel.Name == "F" then
			z = _WHEELTUNE.FMinFriction+v.Heat
			deg = ((deg - 0.0001188*cValues.Brake.Value)*(1-math.abs(cValues.SteerC.Value))) + 0.00000126*math.abs(cValues.SteerC.Value)
		else
			z = _WHEELTUNE.RMinFriction+v.Heat
		end
		
		--Tire Slip
		if math.ceil((wheel/0.774/speed)*100) < 8 then
			--Lock Slip
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.WheelLockRatio,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.max(v.Heat,0)
		elseif (_Tune.TCSEnabled and cValues.TCS.Value == false and math.ceil((wheel/0.774/speed)*100) > 80) then
			--TCS Off
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.TCSOffRatio,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.max(v.Heat,0)
		elseif math.ceil((wheel/0.774/speed)*100) > 130 then
			--Wheelspin
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.WheelspinRatio,v.elast,v.fWeight,v.eWeight)		
			v.Heat = math.max(v.Heat,0)
		else
			--No Slip
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.min(v.Heat,v.BaseHeat)
		end 
		
		--Update UI
		local vstress = math.abs(((((wdif+cspeed)/0.774)*0.774)-cspeed)/15)
		if vstress > 0.05 and vstress > v.stress then 
			v.stress = math.min(v.stress + 0.03,1)
		else
			v.stress = math.max(v.stress - 0.03,vstress)	
		end
		script.Parent:WaitForChild("Tires")
		local UI = script.Parent.Tires[v.wheel.Name]
		UI.First.Second.Image.ImageColor3 = Color3.new(math.min((v.stress*2),1), 1-v.stress, 0)
		UI.First.Position = UDim2.new(0,0,1-v.Heat/v.BaseHeat,0)
		UI.First.Second.Position = UDim2.new(0,0,v.Heat/v.BaseHeat,0)
	end
end
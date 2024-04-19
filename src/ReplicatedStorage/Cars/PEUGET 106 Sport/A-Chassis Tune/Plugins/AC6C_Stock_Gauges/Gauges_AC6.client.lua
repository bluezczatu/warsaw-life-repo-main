--[[
	    ___      _______                _       _______
	   / _ |____/ ___/ /  ___ ____ ___ (_)__   /__  __/
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<     / /
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/	/_/   
						SecondLogic @ Inspare
						Avxnturador @ Novena
]]


local autoscaling	= true					--Estimates top speed

local UNITS	= {								--Click on speed to change units
											--First unit is default	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 370				,
		spInc			= 40				, -- Increment between labelled notches
	}
}

-----------------------------------------------------------------------------------------------

local player=game.Players.LocalPlayer
local mouse=player:GetMouse()

local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])

local gauges = script.Parent
local values = script.Parent.Parent.Values
local isOn = script.Parent.Parent.IsOn

gauges:WaitForChild("Speedo")
gauges:WaitForChild("Tach")
gauges:WaitForChild("Boost")
gauges:WaitForChild("ln")
gauges:WaitForChild("bln")
gauges:WaitForChild("Gear")
gauges:WaitForChild("Speed")

car.DriveSeat.HeadsUpDisplay = false

local _pRPM = _Tune.PeakRPM
local _lRPM = _Tune.Redline

if not _Tune.Engine and _Tune.Electric then _lRPM = _Tune.ElecRedline _pRPM = _Tune.ElecTransition2 end

local currentUnits = 1
local revEnd = math.ceil(_lRPM/1000)

--Automatic Gauge Scaling
if autoscaling then
	local Drive={}
	if _Tune.Config == "FWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("FL")~= nil then
			table.insert(Drive,car.Wheels.FL)
		end
		if car.Wheels:FindFirstChild("FR")~= nil then
			table.insert(Drive,car.Wheels.FR)
		end
		if car.Wheels:FindFirstChild("F")~= nil then
			table.insert(Drive,car.Wheels.F)
		end
	end
	if _Tune.Config == "RWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("RL")~= nil then
			table.insert(Drive,car.Wheels.RL)
		end
		if car.Wheels:FindFirstChild("RR")~= nil then
			table.insert(Drive,car.Wheels.RR)
		end
		if car.Wheels:FindFirstChild("R")~= nil then
			table.insert(Drive,car.Wheels.R)
		end
	end

	local wDia = 0
	for i,v in pairs(Drive) do
		if v.Size.x>wDia then wDia = v.Size.x end
	end
	Drive = nil
	for i,v in pairs(UNITS) do
		v.maxSpeed = math.ceil(v.scaling*wDia*math.pi*_lRPM/60/_Tune.Ratios[#_Tune.Ratios]/_Tune.FinalDrive/_Tune.FDMult)
		v.spInc = math.max(math.ceil(v.maxSpeed/150)*10,10)
	end
end

for i=0,revEnd*2 do
	local ln = gauges.ln:clone()
	ln.Parent = gauges.Tach
	ln.Rotation = 45 + i * 225 / (revEnd*2)
	ln.Num.Text = i/2
	ln.Num.Rotation = -ln.Rotation
	if i*500>=math.floor(_pRPM/500)*500 then
		ln.Frame.BackgroundColor3 = Color3.new(1,0,0)
		if i<revEnd*2 then
			ln2 = ln:clone()
			ln2.Parent = gauges.Tach
			ln2.Rotation = 45 + (i+.5) * 225 / (revEnd*2)
			ln2.Num:Destroy()
			ln2.Visible=true
		end
	end
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,3,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,100)
		ln.Num.Visible = true
	else
		ln.Num:Destroy()
	end
	ln.Visible=true
end

local lns = Instance.new("Frame",gauges.Speedo)
lns.Name = "lns"
lns.BackgroundTransparency = 1
lns.BorderSizePixel = 0
lns.Size = UDim2.new(0,0,0,0)
for i=1,90 do
	local ln = gauges.ln:clone()
	ln.Parent = lns
	ln.Rotation = 45 + 225*(i/90)
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,2,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,100)
	else
		ln.Frame.Size = UDim2.new(0,3,0,5)
	end
	ln.Num:Destroy()
	ln.Visible=true
end

local blns = Instance.new("Frame",gauges.Boost)
blns.Name = "blns"
blns.BackgroundTransparency = 1
blns.BorderSizePixel = 0
blns.Size = UDim2.new(0,0,0,0)
for i=0,12 do
	local bln = gauges.bln:clone()
	bln.Parent = blns
	bln.Rotation = 45+270*(i/12)
	if i%2==0 then
		bln.Frame.Size = UDim2.new(0,2,0,7)
		bln.Frame.Position = UDim2.new(0,-1,0,40)
	else
		bln.Frame.Size = UDim2.new(0,3,0,5)
	end
	bln.Num:Destroy()
	bln.Visible=true
end

for i,v in pairs(UNITS) do
	local lnn = Instance.new("Frame",gauges.Speedo)
	lnn.BackgroundTransparency = 1
	lnn.BorderSizePixel = 0
	lnn.Size = UDim2.new(0,0,0,0)
	lnn.Name = v.units
	if i~= 1 then lnn.Visible=false end
	
	for i=0,v.maxSpeed,v.spInc do
		local ln = gauges.ln:clone()
		ln.Parent = lnn
		ln.Rotation = 45 + 225*(i/v.maxSpeed)
		ln.Num.Text = i
		ln.Num.TextSize = 14
		ln.Num.Rotation = -ln.Rotation
		ln.Frame:Destroy()
		ln.Num.Visible=true
		ln.Visible=true
	end
end

if isOn.Value then
	gauges:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
end

isOn.Changed:connect(function()
	if isOn.Value then
		gauges:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)

values.RPM.Changed:connect(function()
	gauges.Tach.Needle.Rotation = 45 + 225 * math.min(1,values.RPM.Value / (revEnd*1000))
end)

local _TCount = _Tune.Turbochargers
local _SCount = _Tune.Superchargers

if _TCount~=0 or _SCount~=0 then
	values.Boost.Changed:connect(function()
		local _T = 0
		local _S = 0
		if _TCount~=0 then _T = _Tune.T_Boost*_TCount end
		if _SCount~=0 then _S = _Tune.S_Boost*_SCount end
		local tboost = (math.floor(values.BoostTurbo.Value)*1.2)-(_T/5)
		local sboost = math.floor(values.BoostSuper.Value)
		gauges.Boost.Needle.Rotation = 45 + 270 * math.min(1,values.Boost.Value/(_T+_S))
		gauges.PSI.Text = tostring(math.floor(tboost+sboost).." PSI")
	end)
else
	gauges.Boost:Destroy()
end

values.Gear.Changed:connect(function()
	local gearText = values.Gear.Value
	if gearText == 0 then gearText = "N"
	elseif gearText == -1 then gearText = "R"
	end
	gauges.Gear.Text = gearText
end)

values.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if values.TCS.Value then
			gauges.TCS.TextColor3 = Color3.new(1,170/255,0)
			gauges.TCS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if values.TCSActive.Value then
				wait()
				gauges.TCS.Visible = not gauges.TCS.Visible
			else
				wait()
				gauges.TCS.Visible = false
			end
		else
			gauges.TCS.Visible = true
			gauges.TCS.TextColor3 = Color3.new(1,0,0)
			gauges.TCS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		gauges.TCS.Visible = false
	end
end)

values.TCSActive.Changed:connect(function()
	if _Tune.TCSEnabled then
		if values.TCSActive.Value and values.TCS.Value then
			wait()
			gauges.TCS.Visible = not gauges.TCS.Visible
		elseif not values.TCS.Value then
			wait()
			gauges.TCS.Visible = true
		else
			wait()
			gauges.TCS.Visible = false
		end
	else
		gauges.TCS.Visible = false
	end
end)

gauges.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if values.TCSActive.Value and values.TCS.Value then
			wait()
			gauges.TCS.Visible = not gauges.TCS.Visible
		elseif not values.TCS.Value then
			wait()
			gauges.TCS.Visible = true
		end
	else
		if gauges.TCS.Visible then
			gauges.TCS.Visible = false
		end
	end
end)

values.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if values.ABS.Value then
			gauges.ABS.TextColor3 = Color3.new(1,170/255,0)
			gauges.ABS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if values.ABSActive.Value then
				wait()
				gauges.ABS.Visible = not gauges.ABS.Visible
			else
				wait()
				gauges.ABS.Visible = false
			end
		else
			gauges.ABS.Visible = true
			gauges.ABS.TextColor3 = Color3.new(1,0,0)
			gauges.ABS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		gauges.ABS.Visible = false
	end
end)

values.ABSActive.Changed:connect(function()
	if _Tune.ABSEnabled then
		if values.ABSActive.Value and values.ABS.Value then
			wait()
			gauges.ABS.Visible = not gauges.ABS.Visible
		elseif not values.ABS.Value then
			wait()
			gauges.ABS.Visible = true
		else
			wait()
			gauges.ABS.Visible = false
		end
	else
		gauges.ABS.Visible = false
	end
end)

gauges.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if values.ABSActive.Value and values.ABS.Value then
			wait()
			gauges.ABS.Visible = not gauges.ABS.Visible
		elseif not values.ABS.Value then
			wait()
			gauges.ABS.Visible = true
		end
	else
		if gauges.ABS.Visible then
			gauges.ABS.Visible = false
		end
	end
end)


function PBrake()
	gauges.PBrake.Visible = values.PBrake.Value
end
values.PBrake.Changed:connect(PBrake)

function Gear()
	if values.TransmissionMode.Value == "Auto" then
		gauges.TMode.Text = "A/T"
		gauges.TMode.BackgroundColor3 = Color3.new(1,170/255,0)
	elseif values.TransmissionMode.Value == "Semi" then
		gauges.TMode.Text = "S/T"
		gauges.TMode.BackgroundColor3 = Color3.new(0, 170/255, 127/255) 
	else
		gauges.TMode.Text = "M/T"
		gauges.TMode.BackgroundColor3 = Color3.new(1,85/255,.5)
	end
end
values.TransmissionMode.Changed:connect(Gear)

values.Velocity.Changed:connect(function(property)
	gauges.Speedo.Needle.Rotation = 45 + 225 * math.min(1,UNITS[currentUnits].scaling*values.Velocity.Value.Magnitude/UNITS[currentUnits].maxSpeed)
	gauges.Speed.Text = math.floor(UNITS[currentUnits].scaling*values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
end)

mouse.KeyDown:connect(function(key)
	if key=="v" then
		gauges.Visible=not gauges.Visible
	end
end)

gauges.Speed.MouseButton1Click:connect(function()
	if currentUnits==#UNITS then
		currentUnits = 1
	else
		currentUnits = currentUnits+1
	end
	for i,v in pairs(gauges.Speedo:GetChildren()) do
		v.Visible=v.Name==UNITS[currentUnits].units or v.Name=="Needle" or v.Name=="lns"
	end
	gauges.Speed.Text = math.floor(UNITS[currentUnits].scaling*values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
	warn(math.floor(UNITS[currentUnits].scaling*values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units)
end)

wait(.1)
Gear()
PBrake()

local RunService = game:GetService("RunService")
local Radiator = require(script.Parent.RadiatorSettings)
local DriveSeat = script.Parent.Parent
local LoadF = script.Parent.Load
local temp_val = script.Parent.CoolantTemp
local event = DriveSeat.Parent:WaitForChild("RadiatorUpdate")
local effects = DriveSeat.Parent.Body.RadiatorEffects

local IsOn = false
local core = ((((Radiator.CoreLength*10)*(Radiator.CoreHeight*10)*(Radiator.CoreThickness*0.05))*(math.cosh(Radiator.Rows/3)*0.07)/15))+2
local temp_decay = 0.05
local fanspeed = 0

local math_max = math.max

function toF(v)
	return ((v*(9/5))+32)
end

function toC(v)
	return ((v-32)*(5/9))
end

if Radiator.TempUnit == "C" then
	Radiator.OperatingTemp = toF(Radiator.OperatingTemp)
	Radiator.AmbientTemp = toF(Radiator.AmbientTemp)
	Radiator.OverheatTemp = toF(Radiator.OverheatTemp)
	Radiator.FanActivateTemp = toF(Radiator.OverheatTemp)
end

RunService.Stepped:Connect(function()
	local load = ((((LoadF.RPM.Value*0.0075)*1.4)*((LoadF.HP.Value*0.075)*1.2))*(LoadF.Throttle.Value))/10000
	local c_fac = ((core*6)*((1+(DriveSeat.Velocity.Magnitude*0.015))/8))/(9000/core)
	local coef
	if temp_val.Value >= Radiator.FanActivateTemp and Radiator.CoolingFan then
		fanspeed = -((Radiator.FanCFM*0.01)/4)
		if not effects.Fan.Playing then effects.Fan:Play() end
	else
		fanspeed = 0
		if effects.Fan.Playing then effects.Fan:Stop() end
	end
	if temp_val.Value >= Radiator.OverheatTemp-30 then
		effects.Smoke.Enabled = true
		effects.Steam.Volume = math.abs(((Radiator.OverheatTemp-temp_val.Value)-10)/10)
		effects.Smoke.Transparency = NumberSequence.new((Radiator.OverheatTemp-temp_val.Value)/10,1)
	elseif temp_val.Value >= Radiator.OverheatTemp then
		effects.Smoke.Enabled = true
		effects.Steam.Volume = math.abs(((Radiator.OverheatTemp-temp_val.Value)-10)/10)
		effects.Smoke.Transparency = NumberSequence.new((Radiator.OverheatTemp-temp_val.Value)/10,1)
		effects.EngineBreak:Play()
	else
		effects.Smoke.Enabled = false
		effects.Steam.Volume = 0
	end
	if IsOn then
		if temp_val.Value < Radiator.OperatingTemp and IsOn then
			coef = math.abs((-((c_fac*0.5)-(load*3))+temp_decay+0.2)*0.03)
			temp_val.Value = math_max(Radiator.AmbientTemp, temp_val.Value+((coef*1.5)+fanspeed))
		elseif temp_val.Value >= Radiator.OperatingTemp and IsOn then
			coef = (-(c_fac-load)-temp_decay+0.1)*0.03
			temp_val.Value = math_max(Radiator.OperatingTemp, temp_val.Value+((coef*1.5)+fanspeed))
		end
	else
		coef = (-(c_fac-load)-(temp_decay+0.1))*0.02
		temp_val.Value = math_max(Radiator.AmbientTemp, temp_val.Value+((coef*1.5)+fanspeed))
	end 
	if Radiator.DebugEnabled then
		print("CORE: "..core)
		print("TEMP COEFFICIENT: "..coef)
		print("TEMP: "..temp_val.Value)
	end
end)

event.OnServerEvent:Connect(function(p, t, x, y, z)
	if t == "IsOn" then IsOn = x
	else LoadF.Throttle.Value = x; LoadF.RPM.Value = y; LoadF.HP.Value = z end
end)
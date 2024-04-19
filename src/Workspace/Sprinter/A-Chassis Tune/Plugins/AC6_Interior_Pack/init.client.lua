--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare		Interior Pack by STK
]]

--Main Settings:
HANDBRAKE		= false
PADDLE_SHIFTER	= false
PEDALS		 	= false
SHIFTER			= true
STEERING_WHEEL	= false

--Miscellaneous Settings:
HANDBRAKE_ANG	= 15	--Angle of handbrake when active in degrees
PADDLE_ANG		= 15	--Angle of paddle shifter
PADDLE_INVERTED	= false	--Sets right paddle to shift down and vice versa
PEDAL_ANGLE		= 55	--Angle of pedals when active in degrees
PED_INVERTED	= false	--Inverts the pedal angle (for top mounted pedals)
SHIFTER_TYPE	= "H"	--"H" for H-Pattern, "Seq" for sequential shifter
SEQ_INVERTED	= false	--Inverts the sequential shifter motion
SHIFT_TIME		= 0.25	--Time it takes to shift between all parts (Clutch pedal, Paddle shifter, Shifter
VERTICAL_ANG	= 8.5	--Vertical shifter movement angle in degrees
HORIZONTAL_ANG	= 10.0	--Horizontal shifter increments in degrees (H-Pattern only)
STEER_MULT		= 7.0	--Steering multiplier angle (Arbitrary)

--------------------------------------------------------------------------------

local Car		= script.Parent.Car.Value
local Values 	= script.Parent.Values
local _Tune 	= require(Car["A-Chassis Tune"])
local Handler	= Car:WaitForChild("INTERIOR_PACK")
local FE		= workspace.FilteringEnabled

local INT_PCK = nil
for _,Child in pairs(Car.Misc:GetDescendants()) do
	if Child:IsA("ObjectValue") and Child.Name == "INTERIOR_PACK" then INT_PCK = Child.Value end
end
if INT_PCK == nil then script:Destroy() end

local HB = INT_PCK:FindFirstChild("Handbrake")
local PS = INT_PCK:FindFirstChild("Paddle_Shifter")
local PD = INT_PCK:FindFirstChild("Pedals")
local SH = INT_PCK:FindFirstChild("Shifter")
local SW = INT_PCK:FindFirstChild("Steering_Wheel")

local Val = 0
local SEQ = 1
if SEQ_INVERTED then SEQ = -1 end
local PED = 1
if PED_INVERTED then PED = -1 end

local Gear = Values.Gear.Changed:Connect(function()
	local Gear = Values.Gear.Value
	local Shift = "Down"
	if Gear > Val then Shift = "Up" end
	Val = Gear

	if FE then
		Handler:FireServer("Gear",Gear,Shift,PADDLE_SHIFTER,PEDALS,SHIFTER,PS,PD,SH,PADDLE_ANG,PADDLE_INVERTED,SHIFTER_TYPE,SEQ,SHIFT_TIME,VERTICAL_ANG,HORIZONTAL_ANG)
	else

		if PEDALS and PD ~= nil then
			PD.C.Motor.DesiredAngle = math.rad(PEDAL_ANGLE)*PED
		end

		if PADDLE_SHIFTER and PS ~= nil then
			if Shift == "Up" then
				if PADDLE_INVERTED then
					PS.L.Motor.DesiredAngle = math.rad(PADDLE_ANG)
				else
					PS.R.Motor.DesiredAngle = math.rad(PADDLE_ANG)
				end
			else
				if PADDLE_INVERTED then
					PS.R.Motor.DesiredAngle = math.rad(PADDLE_ANG)
				else
					PS.L.Motor.DesiredAngle = math.rad(PADDLE_ANG)
				end
			end
			wait(SHIFT_TIME/2)
			PS.R.Motor.DesiredAngle = 0
			PS.L.Motor.DesiredAngle = 0
		end

		if SHIFTER and SH ~= nil then
			local MOT1 = SH.W1.Motor
			local MOT2 = SH.W2.Motor
			MOT2.DesiredAngle = 0
			wait(SHIFT_TIME/2)
			if SHIFTER_TYPE == "Seq" then
				if Shift == "Up" then
					MOT2.DesiredAngle = math.rad(VERTICAL_ANG)*SEQ
					wait(SHIFT_TIME/2)
					MOT2.DesiredAngle = 0
				else
					MOT2.DesiredAngle = -math.rad(VERTICAL_ANG)*SEQ
					wait(SHIFT_TIME/2)
					MOT2.DesiredAngle = 0
				end
			else
				if Gear == -1 then
					MOT1.DesiredAngle = math.floor((#_Tune["Ratios"]-1)/4)*2*math.rad(HORIZONTAL_ANG)
					wait(SHIFT_TIME/2)

					if #_Tune["Ratios"] % 2 == 0 then MOT2.DesiredAngle = math.rad(VERTICAL_ANG)
					else MOT2.DesiredAngle = -math.rad(VERTICAL_ANG) end

				elseif Gear == 0 then
					MOT1.DesiredAngle = 0

				elseif Gear > 0 then
					if Shift == "Up" then
						if Val == 0 then
							MOT1.DesiredAngle = -math.floor((#_Tune["Ratios"]-1)/4)*math.rad(HORIZONTAL_ANG)
							wait(SHIFT_TIME/2)
							MOT2.DesiredAngle = math.rad(VERTICAL_ANG)
						elseif Gear % 2 == 0 then
							MOT2.DesiredAngle = -math.rad(VERTICAL_ANG)
						else
							MOT1.DesiredAngle = MOT1.DesiredAngle + math.rad(HORIZONTAL_ANG)
							wait(SHIFT_TIME/2)
							MOT2.DesiredAngle = math.rad(VERTICAL_ANG)
						end
					else
						if Gear % 2 == 0 then
							MOT1.DesiredAngle = MOT1.DesiredAngle - math.rad(HORIZONTAL_ANG)
							wait(SHIFT_TIME/2)
							MOT2.DesiredAngle = -math.rad(VERTICAL_ANG)
						else
							MOT2.DesiredAngle = math.rad(VERTICAL_ANG)
						end
					end
				end
			end
		end

		if PEDALS and PD ~= nil then
			PD.C.Motor.DesiredAngle = 0
		end
	end
end)

local Throttle = Values.Throttle.Changed:Connect(function()
	local Throttle = Values.Throttle.Value
	if FE then
		Handler:FireServer("Throttle",Throttle,PEDALS,PD,PEDAL_ANGLE,PED)
	else

		if PEDALS and PD ~= nil then
			PD.T.Motor.DesiredAngle = math.rad(PEDAL_ANGLE*Throttle)*PED
		end
	end
end)

local Brake = Values.Brake.Changed:Connect(function()
	local Brake = Values.Brake.Value
	if FE then
		Handler:FireServer("Brake",Brake,PEDALS,PD,PEDAL_ANGLE,PED)
	else

		if PEDALS and PD ~= nil then
			PD.B.Motor.DesiredAngle = math.rad(PEDAL_ANGLE*Brake)*PED
		end
	end
end)

local PBrake = Values.PBrake.Changed:Connect(function()
	local PBrake = Values.PBrake.Value
	if FE then
		Handler:FireServer("PBrake",PBrake,HANDBRAKE,HB,HANDBRAKE_ANG)
	else

		if HANDBRAKE and HB ~= nil then
			if PBrake then
				HB.W.Motor.DesiredAngle = math.rad(HANDBRAKE_ANG)
			else
				HB.W.Motor.DesiredAngle = 0
			end
		end
	end
end)


game["Run Service"].Stepped:connect(function()
	local direction = Car.Wheels.FR.Base.CFrame:vectorToObjectSpace(Car.Wheels.FR.Arm.CFrame.lookVector)
	local direction2 = Car.Wheels.FL.Base.CFrame:vectorToObjectSpace(Car.Wheels.FL.Arm.CFrame.lookVector)
	local angle = ((math.atan2(-direction.Z, direction.X))+(math.atan2(-direction2.Z, direction2.X)))/2

	local Steer = -(angle-1.57)*STEER_MULT

	if STEERING_WHEEL and SW ~= nil then
		SW.W.Motor.DesiredAngle = Steer
	end
end)
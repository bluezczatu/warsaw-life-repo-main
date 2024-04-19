local Car = script.Parent.Parent
local _Tune = require(Car["A-Chassis Tune"])
local F = {}
local Val = 0

F.Gear = function(Gear,Shift,PADDLE_SHIFTER,PEDALS,SHIFTER,PS,PD,SH,PADDLE_ANG,PADDLE_INVERTED,SHIFTER_TYPE,SEQ,SHIFT_TIME,VERTICAL_ANG,HORIZONTAL_ANG)
	if PEDALS and PD ~= nil then
		PD.C.Motor.DesiredAngle = 1
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
		Val = Gear
	end
	
	if PEDALS and PD ~= nil then
		PD.C.Motor.DesiredAngle = 0
	end
end

F.Throttle = function(Throttle,PEDALS,PD,PEDAL_ANGLE,PED)
	if PEDALS and PD ~= nil then
		PD.T.Motor.DesiredAngle = math.rad(PEDAL_ANGLE*Throttle)*PED
	end
end

F.Brake = function(Brake,PEDALS,PD,PEDAL_ANGLE,PED)
	if PEDALS and PD ~= nil then
		PD.B.Motor.DesiredAngle = math.rad(PEDAL_ANGLE*Brake)*PED
	end
end

F.PBrake = function(PBrake,HANDBRAKE,HB,HANDBRAKE_ANG)
	if HANDBRAKE and HB ~= nil then
		if PBrake then
			HB.W.Motor.DesiredAngle = math.rad(HANDBRAKE_ANG)
		else
			HB.W.Motor.DesiredAngle = 0
		end
	end
end

F.Steering = function(Steer,STEERING_WHEEL,SW,STEER_MULT)
	if STEERING_WHEEL and SW ~= nil then
		SW.W.Motor.DesiredAngle = math.rad(Steer*STEER_MULT*70)
	end
end

F.Loop = function(STEERING_WHEEL,SW,STEER_MULT)
	spawn(function()
		while wait() do
			local direction = Car.Wheels.FR.Base.CFrame:vectorToObjectSpace(Car.Wheels.FR.Arm.CFrame.lookVector)
			local direction2 = Car.Wheels.FL.Base.CFrame:vectorToObjectSpace(Car.Wheels.FL.Arm.CFrame.lookVector)
			local angle = ((math.atan2(-direction.Z, direction.X))+(math.atan2(-direction2.Z, direction2.X)))/2
			
			local Steer = -(angle-1.57)*STEER_MULT
			
			if STEERING_WHEEL and SW ~= nil then
				print(Steer)
				SW.W.Motor.DesiredAngle = Steer
			end
		end
	end)
end

script.Parent.OnServerEvent:connect(function(Plr,Fnc,...)
	F[Fnc](...)
end)
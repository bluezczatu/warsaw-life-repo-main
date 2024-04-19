local F = {}
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent

F.UpdateSmoke = function(rl,rr,fl,fr,rlstop,rrstop,flstop,frstop,rlt,rrt,flt,frt,sd)
--F.UpdateSmoke = function(rl,rr,rlstop,rrstop,rlt,rrt)
	car.Wheels.RL.WheelFixed.SmokePart.Smoke.Rate = rl*3
	car.Wheels.RR.WheelFixed.SmokePart.Smoke.Rate = rr*3
	car.Wheels.FL.WheelFixed.SmokePart.Smoke.Rate = fl*3
	car.Wheels.FR.WheelFixed.SmokePart.Smoke.Rate = fr*3
	
	car.Wheels.RL.WheelFixed.SmokePart.SmokeFast.Rate = rl*2
	car.Wheels.RR.WheelFixed.SmokePart.SmokeFast.Rate = rr*2
	car.Wheels.FL.WheelFixed.SmokePart.SmokeFast.Rate = fl*2
	car.Wheels.FR.WheelFixed.SmokePart.SmokeFast.Rate = fr*2
	
	car.Wheels.RL.WheelFixed.SmokePart.SmokeStop.Rate = rlstop*1.2
	car.Wheels.RR.WheelFixed.SmokePart.SmokeStop.Rate = rrstop*1.2
	car.Wheels.FL.WheelFixed.SmokePart.SmokeStop.Rate = flstop*1.2
	car.Wheels.FR.WheelFixed.SmokePart.SmokeStop.Rate = frstop*1.2
	
	car.Wheels.RL.SQ.Volume = math.min(rl/10,1.5) + math.min(rlstop/20,1)
	car.Wheels.RR.SQ.Volume = math.min(rr/10,1.5) + math.min(rrstop/20,1)
	car.Wheels.FL.SQ.Volume = math.min(fl/10,1.5) + math.min(flstop/20,1)
	car.Wheels.FR.SQ.Volume = math.min(fr/10,1.5)  +math.min(flstop/20,1)
	
	car.Wheels.RL.WheelFixed.SmokePart.T.Enabled = rlt
	car.Wheels.RR.WheelFixed.SmokePart.T.Enabled = rrt
	car.Wheels.FL.WheelFixed.SmokePart.T.Enabled = flt
	car.Wheels.FR.WheelFixed.SmokePart.T.Enabled = frt
	
	car.Wheels.RL.WheelFixed.SmokePart.Smoke.Speed = NumberRange.new(math.min((math.max(rl/10,3)),6), math.min((math.max(rl,6)),50))
	car.Wheels.RR.WheelFixed.SmokePart.Smoke.Speed = NumberRange.new(math.min((math.max(rr/10,3)),6), math.min((math.max(rr,6)),50))
	car.Wheels.FL.WheelFixed.SmokePart.Smoke.Speed = NumberRange.new(math.min((math.max(fl/10,3)),6), math.min((math.max(fl,6)),50))
	car.Wheels.FR.WheelFixed.SmokePart.Smoke.Speed = NumberRange.new(math.min((math.max(fr/10,3)),6), math.min((math.max(fr,6)),50))
	
	car.Wheels.RL.WheelFixed.SmokePart.Smoke.Lifetime = NumberRange.new(math.min((math.max(rl/9,2)),7), math.min((math.max(rl/7,3)),10))
	car.Wheels.RR.WheelFixed.SmokePart.Smoke.Lifetime = NumberRange.new(math.min((math.max(rr/9,2)),7), math.min((math.max(rr/7,3)),10))
	
	car.Wheels.RL.WheelFixed.SmokePart.SmokeFast.Speed = NumberRange.new(math.min((math.max(rl*2,25)),100), math.min((math.max(rl*2.3,50)),150))
	car.Wheels.RR.WheelFixed.SmokePart.SmokeFast.Speed = NumberRange.new(math.min((math.max(rr*2,25)),100), math.min((math.max(rr*2.3,50)),150))
	car.Wheels.FL.WheelFixed.SmokePart.SmokeFast.Speed = NumberRange.new(math.min((math.max(fl*2,25)),100), math.min((math.max(fl*2.3,50)),150))
	car.Wheels.FR.WheelFixed.SmokePart.SmokeFast.Speed = NumberRange.new(math.min((math.max(fr*2,25)),100), math.min((math.max(fr*2.3,50)),150))

	if sd == false then
		car.Wheels.RL.WheelFixed.SmokePart.Smoke.EmissionDirection = "Back"
		car.Wheels.RR.WheelFixed.SmokePart.Smoke.EmissionDirection = "Back"
		car.Wheels.RL.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Back"
		car.Wheels.RR.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Back"
		
		car.Wheels.FL.WheelFixed.SmokePart.Smoke.EmissionDirection = "Back"
		car.Wheels.FR.WheelFixed.SmokePart.Smoke.EmissionDirection = "Back"
		car.Wheels.FL.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Back"
		car.Wheels.FR.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Back"
	elseif sd == true then
		car.Wheels.RL.WheelFixed.SmokePart.Smoke.EmissionDirection = "Front"
		car.Wheels.RR.WheelFixed.SmokePart.Smoke.EmissionDirection = "Front"
		car.Wheels.RL.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Front"
		car.Wheels.RR.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Front"
		
		car.Wheels.FL.WheelFixed.SmokePart.Smoke.EmissionDirection = "Front"
		car.Wheels.FR.WheelFixed.SmokePart.Smoke.EmissionDirection = "Front"
		car.Wheels.FL.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Front"
		car.Wheels.FR.WheelFixed.SmokePart.SmokeFast.EmissionDirection = "Front"
	end

end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Wheels.RL.SQ:Stop()
		car.Wheels.RR.SQ:Stop()
		car.Wheels.FL.SQ:Stop()
		car.Wheels.FR.SQ:Stop()
		
		car.Wheels.RL.WheelFixed.SmokePart.Smoke.Rate=0
		car.Wheels.RR.WheelFixed.SmokePart.Smoke.Rate=0
		car.Wheels.FL.WheelFixed.SmokePart.Smoke.Rate=0
		car.Wheels.FR.WheelFixed.SmokePart.Smoke.Rate=0
		
		car.Wheels.RL.WheelFixed.SmokePart.SmokeFast.Rate=0
		car.Wheels.RR.WheelFixed.SmokePart.SmokeFast.Rate=0
		car.Wheels.FL.WheelFixed.SmokePart.SmokeFast.Rate=0
		car.Wheels.FR.WheelFixed.SmokePart.SmokeFast.Rate=0
		
		car.Wheels.RL.WheelFixed.SmokePart.SmokeStop.Rate=0
		car.Wheels.RR.WheelFixed.SmokePart.SmokeStop.Rate=0
		car.Wheels.FL.WheelFixed.SmokePart.SmokeStop.Rate=0
		car.Wheels.FR.WheelFixed.SmokePart.SmokeStop.Rate=0
		
		car.Wheels.RL.WheelFixed.SmokePart.T.Enabled = false
		car.Wheels.RR.WheelFixed.SmokePart.T.Enabled = false
		car.Wheels.FL.WheelFixed.SmokePart.T.Enabled = false
		car.Wheels.FR.WheelFixed.SmokePart.T.Enabled = false
	end
end)

for i,v in pairs(car.Wheels:GetChildren()) do
	if v.Name=="RL" or v.Name=="RR" or v.Name=="R" or v.Name=="FL" or v.Name=="FR" then
		local sq = script.Parent.SQ:Clone()
		sq.Parent=v
		local sm = script.Parent.Smoke:Clone()
		sm.Parent=v.WheelFixed.SmokePart
		local smf = script.Parent.SmokeFast:Clone()
		smf.Parent=v.WheelFixed.SmokePart
		local sms = script.Parent.SmokeStop:Clone()
		sms.Parent=v.WheelFixed.SmokePart
	end
end
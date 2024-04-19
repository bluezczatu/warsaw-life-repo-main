-- version 1.0 - MIK0_San

local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
car.Wheels.RL.SQ:Play()
car.Wheels.RR.SQ:Play()
car.Wheels.FL.SQ:Play()
car.Wheels.FR.SQ:Play()
local values = script.Parent.Values
local handler = car:WaitForChild("Smoke_FE")

while wait(.2) do
	local r1 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RL.Size.x/2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then
		r1hit=1
	end

	local r2 = Ray.new(car.Wheels.RR.Position,(car.Wheels.RR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.RR.Size.x/2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then
		r2hit=1
	end
	
	local f1 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.FL.Size.x/2))
	local f1hit = 0
	if workspace:FindPartOnRay(f1,car)~=nil then
		f1hit=1
	end

	local f2 = Ray.new(car.Wheels.FR.Position,(car.Wheels.FR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(.05+car.Wheels.FR.Size.x/2))
	local f2hit = 0
	if workspace:FindPartOnRay(f2,car)~=nil then
		f2hit=1
	end
	
	local rl = math.min((math.max(((car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/1.5)^0.9 - (car.Wheels.RL.Velocity.Magnitude))-12,0)),400)*r1hit
	local rr = math.min((math.max(((car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/1.5)^0.9 - (car.Wheels.RR.Velocity.Magnitude))-12,0)),400)*r2hit
	local fl = math.min((math.max(((car.Wheels.FL.RotVelocity.Magnitude*car.Wheels.FL.Size.x/1.5)^0.9 - (car.Wheels.FL.Velocity.Magnitude))-12,0)),400)*f1hit
	local fr = math.min((math.max(((car.Wheels.FR.RotVelocity.Magnitude*car.Wheels.FR.Size.x/1.5)^0.9 - (car.Wheels.FR.Velocity.Magnitude))-12,0)),400)*f2hit
	
	local rlstop = math.min((math.max(  ( (car.Wheels.RL.Velocity.Magnitude) - (car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/2) ) -25,0)),50)*r1hit
	local rrstop = math.min((math.max(  ( (car.Wheels.RR.Velocity.Magnitude) - (car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/2) ) -25,0)),50)*r2hit
	local flstop = math.min((math.max(  ( (car.Wheels.FL.Velocity.Magnitude) - (car.Wheels.FL.RotVelocity.Magnitude*car.Wheels.FL.Size.x/2) ) -25,0)),50)*f1hit
	local frstop = math.min((math.max(  ( (car.Wheels.FR.Velocity.Magnitude) - (car.Wheels.FR.RotVelocity.Magnitude*car.Wheels.FR.Size.x/2) ) -25,0)),50)*f2hit
	
	local rlt = false
	if rl >= 5 or rlstop >= 5 then
		rlt = true
	elseif rl <= 5 and rlstop <= 5 then
		rlt = false
	end
	local rrt = false
	if rr >= 5 or rrstop >= 5 then
		rrt = true
	elseif rr <= 5 and rrstop <= 5 then
		rrt = false
	end
	local flt = false
	if fl >= 5 or flstop >= 5 then
		flt = true
	elseif fl <= 5 and flstop <= 5 then
		flt = false
	end
	local frt = false
	if fr >= 5 or frstop >= 5 then
		frt = true
	elseif fr <= 5 and frstop <= 5 then
		frt = false
	end
	
	local sd = false
	if values.Gear.Value == -1 then
		sd = true
	else 
		sd = false
		
	end
	
	
	
	handler:FireServer("UpdateSmoke",rl,rr,fl,fr,rlstop,rrstop,flstop,frstop,rlt,rrt,flt,frt,sd)
	--handler:FireServer("UpdateSmoke",rl,rr,rlstop,rrstop,rlt,rrt)

end
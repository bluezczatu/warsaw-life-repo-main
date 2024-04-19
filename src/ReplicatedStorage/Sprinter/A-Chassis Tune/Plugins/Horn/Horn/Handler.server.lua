local F = {}
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent

F.Horn = function(value)
	if value == true then
		car.DriveSeat.Horn:Play()
	elseif value == false then
		car.DriveSeat.Horn:Stop()
	end
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)
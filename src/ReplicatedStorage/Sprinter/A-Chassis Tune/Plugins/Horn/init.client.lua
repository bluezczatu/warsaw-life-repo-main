local mouse = game.Players.LocalPlayer:GetMouse()
car = script.Parent.Car.Value
local handler = car.Horn
local FE = workspace.FilteringEnabled

if not FE then
mouse.KeyDown:connect(function (key)
key = string.lower(key)
	if key == "j" then
		car.DriveSeat.Horn:Play()
	end
end)

mouse.KeyUp:connect(function (key)
key = string.lower(key)
	if key == "j" then
		car.DriveSeat.Horn:Stop()
	end
end)
else
	mouse.KeyDown:connect(function (key)
	key = string.lower(key)
		if key == "j" then
			handler:FireServer("Horn",true)
		end
	end)

	mouse.KeyUp:connect(function (key)
	key = string.lower(key)
		if key == "j" then
			handler:FireServer("Horn",false)
		end
	end)
end
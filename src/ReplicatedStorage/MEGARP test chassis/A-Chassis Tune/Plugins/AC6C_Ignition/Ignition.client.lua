local mouse = game.Players.LocalPlayer:GetMouse()
script.Parent.Parent:WaitForChild("Car")
local car = script.Parent.Parent.Car.Value
local on = script.Parent.Parent.IsOn
local _Tune = require(car["A-Chassis Tune"])

if not _Tune.Engine and not _Tune.Electric then return end

script.Parent:WaitForChild("TextLabel").Visible = not on.Value

script.Parent.Parent.IsOn.Changed:connect(function() 
	script.Parent.TextLabel.Visible = not on.Value
end)

mouse.keyDown:connect(function(k) 
	if k=="f" then 
		if not on.Value then
			script.Parent.TextLabel.Visible=false
			on.Value = true
		else
			on.Value = false
			script.Parent.TextLabel.Visible=true
		end
	end 
end)
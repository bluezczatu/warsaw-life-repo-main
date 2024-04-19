local F = {}
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent

F.SoundPlay = function()
	DriveSeat.Parent.Body.Drag.Wind:Play()
end

F.SoundUpdate = function(volume)
	if DriveSeat.Parent.Body.Drag.Wind.Volume ~= volume then
		DriveSeat.Parent.Body.Drag.Wind.Volume = volume
	end
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)
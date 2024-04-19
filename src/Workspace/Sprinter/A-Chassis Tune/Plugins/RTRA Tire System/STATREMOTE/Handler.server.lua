local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent
local Reader = script.Parent.STATREADER
Reader.statreaderscript.V.Value = script.Parent.Parent

script.Parent.OnServerEvent:connect(function(pl)

	if pl and (not pl.PlayerGui:FindFirstChild("statreaderscript")) then
		script.Parent.STATREADER.statreaderscript:Clone().Parent = pl.PlayerGui
		pl.PlayerGui.statreaderscript.Disabled = false
	end
	
	if car and (not car:FindFirstChild("STATREADER")) then
		script.Parent.STATREADER:Clone().Parent = car
		car.STATREADER.Enabled = true
		car.STATREADER.Frame:TweenSize(UDim2.new(0.4, 0, 0.4, 0), "InOut", "Quint",.8)
		wait(.8)
	else
		if car.STATREADER.Enabled == false then
			car.STATREADER.Enabled = true
			car.STATREADER.Frame:TweenSize(UDim2.new(0.4, 0, 0.4, 0), "InOut", "Quint",.8)
			wait(.8)
		else
			car.STATREADER.Frame:TweenSize(UDim2.new(0.4, 0, 0, 0), "InOut", "Quint",.8)
			wait(.8)
			car.STATREADER.Enabled = false
		end
end
end)
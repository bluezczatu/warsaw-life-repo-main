local car = script.Parent.Car.Value
while wait(.001) do
	if script.Parent.IsOn.Value == true then
car.Misc.Engine.Hinge.Vib.CurrentAngle = math.min((5/script.Parent.Values.RPM.Value),.005)
wait(.001)
car.Misc.Engine.Hinge.Vib.CurrentAngle = math.max(-(5/script.Parent.Values.RPM.Value),-.005)
	else
car.Misc.Engine.Hinge.Vib.CurrentAngle = 0
	end
	end
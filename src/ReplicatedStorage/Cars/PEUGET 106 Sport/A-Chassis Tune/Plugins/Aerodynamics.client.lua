--Editable Values
local Drag = .34  	--Drag Coefficient
local F = 125		--Downforce at 300 SPS
local R = 150		--Downforce at 300 SPS
local Vol = 1 		
--End of Editable Values

local car = script.Parent.Car.Value
local hb = game:GetService('RunService').Heartbeat
local sound = car.Body.Drag.Wind
local sound2 = car.Body.Drag.Body
sound:Play()
sound2:Play()

local function update()
	sound.Volume=Vol*(car.DriveSeat.Velocity.Magnitude/500)
	sound2.Volume=Vol*(car.DriveSeat.Velocity.Magnitude/500)
	car.Body.DownforceF.T.Force = Vector3.new(0,(car.DriveSeat.Velocity.Magnitude/-300)*F,0)
	car.Body.DownforceR.T.Force = Vector3.new(0,(car.DriveSeat.Velocity.Magnitude/-300)*R,0)
	car.Body.Drag.T.Force = Vector3.new(0,0,(car.DriveSeat.Velocity.magnitude^2*(Drag/30)))
end

hb:Connect(update)
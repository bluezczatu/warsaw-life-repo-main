--Aerodynamics script by RikOne2--
--				1.1				--
--Fixed NaN angle issue (car spazzing)--
--Script is now FE+

local Drag = 80  	--Drag 	| Higher value = Less Downforce | Min 30
local F = 550		--Front | Higher value = Less Downforce | 
local R = 250		--Rear 	| Higher value = Less Downforce | 
local Vol = 10 		-- Wind | Defines wind sound effect volume  

local car = script.Parent.Car.Value
local sound = car.Body.Drag.Wind
local handler = car.Aerodynamics
sound:Play()
handler:FireServer("SoundPlay")

while wait() do
	local angle = math.acos(math.abs(car.Body.DownforceF.Velocity.unit:Dot(car.Body.DownforceF.CFrame.lookVector)))
	if angle > 0 then
	car.Body.DownforceF.T.Force = Vector3.new(0,-(((car.DriveSeat.Velocity.magnitude^2)/F)*(angle^2)),0)
	car.Body.DownforceR.T.Force = Vector3.new(0,-(((car.DriveSeat.Velocity.magnitude^2)/R)*(angle^2)),0)
	end
	car.Body.Drag.T.Force = Vector3.new(0,0,((car.DriveSeat.Velocity.magnitude^2)/Drag))
	sound.Volume = car.DriveSeat.Velocity.magnitude/Vol
	
	handler:FireServer("SoundUpdate",sound.Volume)
end
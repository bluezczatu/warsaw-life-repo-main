wait(2)
local function test()

end
local speedtext = script.Parent.Frame.Frame.Speed

local speedmeter = script.Parent.Frame.Frame.CanvasGroup.Frame.Frame.ImageLabel




warn(script.Parent.Parent)
warn(script.Parent.Parent.Parent)
warn(script.Parent.Parent.Parent.Parent)



--local playergui = game.Players.LocalPlayer.PlayerGui
--local SpeedValue = playergui.ScreenCar.Speed




--script.Parent.Speed.Changed:Connect(function(speed)
	
--end)


local function xd(speed)
	warn(speed)

	local numbers = math.ceil(math.log10(speed))

	if numbers == 3 then
		speedtext.Text = speed
	else

		if numbers == 2 then
			speedtext.Text = speed
			speedtext.Text = "0".. tostring(speed)
		end

		if numbers == 1 then
			speedtext.Text = speed
			speedtext.Text = "00".. tostring(speed)
		end

	end



	if speed <= 300 then

		local speedrotation = (speed / 1.5 ) - 180

		speedmeter.Rotation = speedrotation

		local Speed2 = speedmeter.UIGradient

		if speedrotation < - 100 then
			Speed2.Enabled = true
		else
			Speed2.Enabled = false
		end



	end


end




script.Parent.Parent.Parent.Parent.AC6C_Stock_Gauges.Speed:GetPropertyChangedSignal("Text"):Connect(function(text)
	text = script.Parent.Parent.Parent.Parent.AC6C_Stock_Gauges.Speed.Text
	warn(string.split(text," KM")[1])
	local speed = tonumber(string.split(text," KM")[1])
	xd(speed)
end)













-- make function to calculate speedmeter if is starting from - 180 degres and exit on 22
local function calculatespeedmeter()

end
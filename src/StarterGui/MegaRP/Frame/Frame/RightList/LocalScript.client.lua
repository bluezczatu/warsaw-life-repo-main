
local function test()

end
local speedtext = script.Parent.Frame.Frame.Speed

local speedmeter = script.Parent.Frame.Frame.CanvasGroup.Frame.Frame.ImageLabel

script.Parent.Speed.Changed:Connect(function(speed)
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


end)




-- make function to calculate speedmeter if is starting from - 180 degres and exit on 22
local function calculatespeedmeter()

end
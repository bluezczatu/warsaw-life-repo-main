local playergui = game.Players.LocalPlayer.PlayerGui


local SpeedValue = playergui.ScreenCar.Speed







local speedtext = playergui.MegaRP.Frame.Frame.RightList.Frame.Frame.Speed
local speedmeter = playergui.MegaRP.Frame.Frame.RightList.Frame.Frame.CanvasGroup.Frame.Frame.ImageLabel




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


script.Parent.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
	warn(script.Parent.Parent)
	warn("XDDDDDDDDDDDDDDDDDDDDDDDDD")
end)

script.Parent:GetPropertyChangedSignal("Text"):Connect(function(text)
	text = script.Parent.Text
	warn(string.split(text," KM")[1])
	SpeedValue.Value = tonumber(string.split(text," KM")[1])


	local speed = tonumber(string.split(text," KM")[1])
	xd(speed)
end)




--script.Parent.Speed.Changed:Connect(function(speed)
--	warn(speed)

--	local numbers = math.ceil(math.log10(speed))

--	if numbers == 3 then
--		speedtext.Text = speed
--	else

--		if numbers == 2 then
--			speedtext.Text = speed
--			speedtext.Text = "0".. tostring(speed)
--		end

--		if numbers == 1 then
--			speedtext.Text = speed
--			speedtext.Text = "00".. tostring(speed)
--		end

--	end



--	if speed <= 300 then

--		local speedrotation = (speed / 1.5 ) - 180

--		speedmeter.Rotation = speedrotation

--		local Speed2 = speedmeter.UIGradient

--		if speedrotation < - 100 then
--			Speed2.Enabled = true
--		else
--			Speed2.Enabled = false
--		end



--	end


--end)

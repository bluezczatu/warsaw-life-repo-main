--[[

   ____ ___   ____ _____ __    ____ _____ __ __ ______ ____  _   __ ____
  / __// _ \ /  _// ___// /   /  _// ___// // //_  __// __/ | | / // / /
 / _/ / ___/_/ / / /__ / /__ _/ / / (_ // _  /  / /  _\ \   | |/ //_  _/
/___//_/   /___/ \___//____//___/ \___//_//_/  /_/  /___/   |___/  /_/  
                            by VG3O_J
                 discord: https://discord.gg/Vk7uGNnX9M  
                            
]]--

local TweenService, UserInputService = game:GetService("TweenService"), game:GetService("UserInputService")
local car = script.Parent.Parent.Car.Value
local carvalues = script.Parent.Parent.Values
local event = car:WaitForChild("LIGHTS")
local values = event.Values
local GUI = script.Parent.GUI
local sounds = script.Parent.Sounds

local config = require(event.Configuration)

local lstate = values.Lights.Value
local running = values.Running.Value
local flashing = false

function doTween(i, t, es, ed, pt)
	TweenService:Create(i, TweenInfo.new(t, es, ed), pt):Play()
end

local d = false
carvalues.Brake.Changed:Connect(function()
	if carvalues.Brake.Value > 0.02 and not d then
		d = true
		event:FireServer("Brake", true)
	elseif carvalues.Brake.Value <= 0.02 and d then
		d = false
		event:FireServer("Brake", false)
	end
end)

carvalues.Gear.Changed:Connect(function()
	if carvalues.Gear.Value == -1 then
		event:FireServer("Reverse", true)
	else
		event:FireServer("Reverse", false)
	end
end)

car.DriveSeat.ChildAdded:Connect(function(c)
	if not config.RunningHeadlight and config.RunningOnOpen then
		doTween(GUI.ParkLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
		event:FireServer("Lights", values.Lights.Value, true)
	end
end)

task.spawn(function()
	while task.wait() do
		if values.Indicators.Left.Value then
			sounds.TickOn:Play()
			doTween(GUI.LeftInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			task.wait(config.IndicatorFlashRate)
			sounds.TickOff:Play()
			doTween(GUI.LeftInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
			task.wait(config.IndicatorFlashRate)
		end
		if values.Indicators.Right.Value then
			sounds.TickOn:Play()
			doTween(GUI.RightInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			task.wait(config.IndicatorFlashRate)
			sounds.TickOff:Play()
			doTween(GUI.RightInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
			task.wait(config.IndicatorFlashRate)
		end
		if values.Indicators.Hazard.Value then
			sounds.TickOn:Play()
			doTween(GUI.LeftInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			doTween(GUI.RightInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			task.wait(config.IndicatorFlashRate)
			sounds.TickOff:Play()
			doTween(GUI.LeftInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
			doTween(GUI.RightInd, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
			task.wait(config.IndicatorFlashRate)
		end
	end
end)

UserInputService.InputEnded:Connect(function(i, gp)
	if not gp then
		if i.KeyCode == config.HighBeamFlash and lstate ~= 2 then
			flashing = false
			doTween(GUI.HighBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
			if lstate == 1 then
				doTween(GUI.LowBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			end
			event:FireServer("Flash", false)
		end
	end
end)

UserInputService.InputBegan:Connect(function(i, gp)
	if not gp then
		if i.KeyCode == config.Headlights and not flashing then
			lstate = lstate + 1
			if lstate > 2 then
				lstate = 0
			end
			event:FireServer("Lights", lstate)
			if lstate == 0 then
				doTween(GUI.HighBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
				if values.Fogs.Value then
					doTween(GUI.FogLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
					event:FireServer("Fogs", values.Fogs.Value, true)
				end
			elseif lstate == 1 then
				doTween(GUI.LowBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
				if values.Fogs.Value then
					doTween(GUI.FogLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
					event:FireServer("Fogs", values.Fogs.Value, false)
				end
			elseif lstate == 2 then
				doTween(GUI.LowBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
				doTween(GUI.HighBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			end
		elseif i.KeyCode == config.FogLights then
			local val
			if values.Fogs.Value then
				val = false
				doTween(GUI.FogLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
				event:FireServer("Fogs", val, false)
			else
				val = true
				if lstate > 0 then
					doTween(GUI.FogLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
				end	
				event:FireServer("Fogs", val, false)
			end
		elseif i.KeyCode == config.SignalLeft then
			local val
			if values.Indicators.Left.Value then
				val = false
				sounds.IndOff:Play()
			else
				val = true
				sounds.IndOn:Play()
			end
			event:FireServer("Signal", "Left", val)
		elseif i.KeyCode == config.SignalRight then
			local val
			if values.Indicators.Right.Value then
				val = false
				sounds.IndOff:Play()
			else
				val = true
				sounds.IndOn:Play()
			end
			event:FireServer("Signal", "Right", val)
		elseif i.KeyCode == config.Hazards then
			local val
			if values.Indicators.Hazard.Value then
				val = false
			else
				val = true
			end
			event:FireServer("Signal", "Hazard", val)
		elseif i.KeyCode == config.RunningLights then
			local val
			if values.Running.Value then
				doTween(GUI.ParkLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
				val = false
			else
				doTween(GUI.ParkLights, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
				val = true
			end
			event:FireServer("Lights", values.Lights.Value, val)
		elseif i.KeyCode == config.Popups then
			if config.PopupsEnabled then
				local val
				if values.Popups.Value then
					val = false
				else
					val = true
				end
				event:FireServer("Popups", val)
			end	
		elseif i.KeyCode == config.HighBeamFlash and lstate ~= 2 then
			flashing = true
			doTween(GUI.HighBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 0})
			if lstate == 1 then
				doTween(GUI.LowBeams, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {ImageTransparency = 1})
			end
			event:FireServer("Flash", true)
		end
	end
end)
--[[

   ____ ___   ____ _____ __    ____ _____ __ __ ______ ____  _   __ ____
  / __// _ \ /  _// ___// /   /  _// ___// // //_  __// __/ | | / // / /
 / _/ / ___/_/ / / /__ / /__ _/ / / (_ // _  /  / /  _\ \   | |/ //_  _/
/___//_/   /___/ \___//____//___/ \___//_//_/  /_/  /___/   |___/  /_/  
                            by VG3O_J
                 discord: https://discord.gg/Vk7uGNnX9M  
                            
]]--

local F = {}

-- variable declarations
local TweenService = game:GetService("TweenService")
local config = require(script.Parent:WaitForChild("Configuration"))
local values = script.Parent.Values
local car = script.Parent.Parent
local lights = car.Body.Lights
local popups = car.Misc:FindFirstChild("Popups")
local trunk = car.Misc:FindFirstChild("TK")
local doors = {}
local door_FL, door_FR = car.Misc:FindFirstChild("FL"), car.Misc:FindFirstChild("FR")

local incandescent_TI = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
local LED_TI = TweenInfo.new(0.07, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
local selected_TI

for i, v in pairs(car.Misc:GetChildren()) do
	if v.Name == "FL" or v.Name == "FR" or v.Name == "RL" or v.Name == "RR" then
		table.insert(doors, v)
	end
end

if config.LightType == "Incandescent" then
	selected_TI = incandescent_TI
elseif config.LightType == "LED" then
	selected_TI = LED_TI	
else
	error("EPICLIGHTS V4 ERROR // Light type was not set to a recognized value!")	
end

-- light color preset table
local presets = {
	-- neon colors
	{ -- lights
	["Incandescent"] = Color3.fromRGB(255, 180, 161),
	["Xenon"] = Color3.fromRGB(226, 231, 255),
	["Pure White"] = Color3.fromRGB(255, 255, 255),
	["Brilliant Blue"] = Color3.fromRGB(138, 150, 255),
	["Light Green"] = Color3.fromRGB(156, 255, 209),
	["Golden Yellow"] = Color3.fromRGB(255, 214, 155),
	["Yellow"] = Color3.fromRGB(255, 175, 110),
	-- indicators
	["Light Orange"] = Color3.fromRGB(255, 130, 80),
	["Dark Orange"] = Color3.fromRGB(198, 107, 54),
	["Red"] = Color3.fromRGB(241, 57, 60)
	},
	-- light object colors
	{ -- lights
	["Incandescent"] = Color3.fromRGB(255, 237, 199),
	["Xenon"] = Color3.fromRGB(205, 227, 255),
	["Pure White"] = Color3.fromRGB(255, 255, 255),
	["Brilliant Blue"] = Color3.fromRGB(116, 188, 255),
	["Light Green"] = Color3.fromRGB(175, 196, 196), 
	["Golden Yellow"] = Color3.fromRGB(255, 239, 193),
	["Yellow"] = Color3.fromRGB(181, 178, 87),
	-- indicators
	["Light Orange"] = Color3.fromRGB(255, 130, 80),
	["Dark Orange"] = Color3.fromRGB(198, 107, 54),
	["Red"] = Color3.fromRGB(241, 57, 60)	
	}	
}

-- setup
for i, v in pairs(lights.Headlights:GetDescendants()) do
	if v.Name == "L" then
		local spot = Instance.new("SpotLight", v)
		spot.Angle = 180
		spot.Name = "L"
		spot.Brightness = 0
		spot.Face = Enum.NormalId.Front
		spot.Shadows = true
		if typeof(config.HeadlightColor) == "string" then
			spot.Color = presets[2][config.HeadlightColor]
		elseif typeof(config.HeadlightColor) == "Color3" then
			spot.Color = config.HeadlightColor
		end 
		if v.Parent.Name == "Low" then
			spot.Range = 48
		elseif v.Parent.Name == "High" then
			spot.Range = 60
		elseif v.Parent.Name == "Running" then
			spot.Range = 30
		end
	elseif v.Name == "LN" then
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
		v.Transparency = 1
		v.Material = Enum.Material.Neon
		if typeof(config.HeadlightColor) == "string" then
			v.Color = presets[1][config.HeadlightColor]
		elseif typeof(config.HeadlightColor) == "Color3" then
			v.Color = config.HeadlightColor
		end 	
	end
end
if config.PopupsEnabled then
	for i, v in pairs(popups:GetDescendants()) do
		if v.Name == "L" then
			local spot = Instance.new("SpotLight", v)
			spot.Angle = 180
			spot.Name = "L"
			spot.Brightness = 0
			spot.Face = Enum.NormalId.Front
			spot.Shadows = true
			spot.Range = 48
			if typeof(config.HeadlightColor) == "string" then
				spot.Color = presets[2][config.HeadlightColor]
			elseif typeof(config.HeadlightColor) == "Color3" then
				spot.Color = config.HeadlightColor
			end 
		elseif v.Name == "LN" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			if typeof(config.HeadlightColor) == "string" then
				v.Color = presets[1][config.HeadlightColor]
			elseif typeof(config.HeadlightColor) == "Color3" then
				v.Color = config.HeadlightColor
			end 
		end
	end
end
if #doors > 0 and config.DoorIndicators then
	for i, v in pairs(doors) do
		for i, v in pairs(v.Indicators:GetChildren()) do
			if v.Name == "LN" then
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
				v.Transparency = 1
				v.Material = Enum.Material.Neon
				if typeof(config.FrontIndicatorColor) == "string" then
					v.Color = presets[2][config.FrontIndicatorColor]
				elseif typeof(config.FrontIndicatorColor) == "Color3" then
					v.Color = config.FrontIndicatorColor
				end 
			end
		end
	end
end 
for i, v in pairs(lights.Rear:GetDescendants()) do
	if v.Name == "L" then
		local spot = Instance.new("SpotLight", v)
		spot.Angle = 180
		spot.Range = 25
		spot.Name = "L"
		spot.Brightness = 0
		spot.Face = Enum.NormalId.Front
		spot.Shadows = true
		spot.Color = Color3.fromRGB(255, 0, 0)
	elseif v.Name == "LN" then
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
		v.Transparency = 1
		v.Material = Enum.Material.Neon
		v.Color = config.RearLightColor	
	end
end
for i, v in pairs(lights.Brake:GetDescendants()) do
	if v.Name == "L" then
		local spot = Instance.new("SpotLight", v)
		spot.Angle = 180
		spot.Range = 38
		spot.Name = "L"
		spot.Brightness = 0
		spot.Face = Enum.NormalId.Front
		spot.Shadows = true
		spot.Color = Color3.fromRGB(255, 0, 0)
	elseif v.Name == "LN" then
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
		v.Transparency = 1
		v.Material = Enum.Material.Neon
		v.Color = config.BrakeLightColor 	
	end
end
for i, v in pairs(lights.Fog:GetDescendants()) do
	if v.Name == "L" then
		local spot = Instance.new("SpotLight", v)
		spot.Angle = 180
		spot.Range = 48
		spot.Name = "L"
		spot.Brightness = 0
		spot.Face = Enum.NormalId.Front
		spot.Shadows = true
		if typeof(config.FogLightColor) == "string" then
			spot.Color = presets[2][config.FogLightColor]
		elseif typeof(config.FogLightColor) == "Color3" then
			spot.Color = config.FogLightColor
		end 
	elseif v.Name == "LN" then
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
		v.Transparency = 1
		v.Material = Enum.Material.Neon
		if typeof(config.FogLightColor) == "string" then
			v.Color = presets[1][config.FogLightColor]
		elseif typeof(config.FogLightColor) == "Color3" then
			v.Color = config.FogLightColor
		end 	
	end
end
for i, v in pairs(lights.Reverse:GetDescendants()) do
	if v.Name == "L" then
		local spot = Instance.new("SpotLight", v)
		spot.Angle = 180
		spot.Range = 38
		spot.Name = "L"
		spot.Brightness = 0
		spot.Face = Enum.NormalId.Front
		spot.Shadows = true
		if typeof(config.ReverseLightColor) == "string" then
			spot.Color = presets[2][config.ReverseLightColor]
		elseif typeof(config.ReverseLightColor) == "Color3" then
			spot.Color = config.ReverseLightColor
		end 
	elseif v.Name == "LN" then
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
		v.Transparency = 1
		v.Material = Enum.Material.Neon
		if typeof(config.ReverseLightColor) == "string" then
			v.Color = presets[1][config.ReverseLightColor]
		elseif typeof(config.ReverseLightColor) == "Color3" then
			v.Color = config.ReverseLightColor
		end 	
	end
end
if config.PlateLights then
	for i, v in pairs(lights.Plate:GetDescendants()) do
		if v.Name == "L" then
			local sfc = Instance.new("SurfaceLight", v)
			sfc.Name = "L"
			sfc.Angle = 135
			sfc.Brightness = 0
			sfc.Range = 1
			sfc.Face = Enum.NormalId.Front
			sfc.Shadows = true
			if typeof(config.PlateLightColor) == "string" then
				sfc.Color = presets[2][config.PlateLightColor]
			elseif typeof(config.PlateLightColor) == "Color3" then
				sfc.Color = config.PlateLightColor
			end 
		elseif v.Name == "LN" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			if typeof(config.PlateLightColor) == "string" then
				v.Color = presets[1][config.PlateLightColor]
			elseif typeof(config.PlateLightColor) == "Color3" then
				v.Color = config.PlateLightColor
			end 	
		end
	end
end	
if config.TrunkLights then
	for i, v in pairs(trunk.Rear:GetDescendants()) do
		if v.Name == "L" then
			local spot = Instance.new("SpotLight", v)
			spot.Angle = 180
			spot.Range = 25
			spot.Name = "L"
			spot.Brightness = 0
			spot.Face = Enum.NormalId.Front
			spot.Shadows = true
			spot.Color = Color3.fromRGB(255, 0, 0)
		elseif v.Name == "LN" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			v.Color = config.RearLightColor	
		end
	end
	for i, v in pairs(trunk.Brake:GetDescendants()) do
		if v.Name == "L" then
			local spot = Instance.new("SpotLight", v)
			spot.Angle = 180
			spot.Range = 38
			spot.Name = "L"
			spot.Brightness = 0
			spot.Face = Enum.NormalId.Front
			spot.Shadows = true
			spot.Color = Color3.fromRGB(255, 0, 0)
		elseif v.Name == "LN" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			v.Color = config.BrakeLightColor 	
		end
	end
	for i, v in pairs(trunk.Reverse:GetDescendants()) do
		if v.Name == "L" then
			local spot = Instance.new("SpotLight", v)
			spot.Angle = 180
			spot.Range = 38
			spot.Name = "L"
			spot.Brightness = 0
			spot.Face = Enum.NormalId.Front
			spot.Shadows = true
			if typeof(config.ReverseLightColor) == "string" then
				spot.Color = presets[2][config.ReverseLightColor]
			elseif typeof(config.ReverseLightColor) == "Color3" then
				spot.Color = config.ReverseLightColor
			end 
		elseif v.Name == "LN" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			if typeof(config.ReverseLightColor) == "string" then
				v.Color = presets[1][config.ReverseLightColor]
			elseif typeof(config.ReverseLightColor) == "Color3" then
				v.Color = config.ReverseLightColor
			end 	
		end
	end
	for i, v in pairs(trunk.Indicators:GetDescendants()) do
		if v.Name == "L" then
			local sfc = Instance.new("SpotLight", v)
			sfc.Name = "L"
			sfc.Brightness = 0
			sfc.Range = 16
			sfc.Face = Enum.NormalId.Front
			sfc.Angle = 180
			sfc.Shadows = true	
			if typeof(config.RearIndicatorColor) == "string" then
				sfc.Color = presets[2][config.RearIndicatorColor]
			elseif typeof(config.RearIndicatorColor) == "Color3" then
				sfc.Color = config.RearIndicatorColor
			end 
		elseif v.Name == "LN" or string.sub(v.Name, 1, 2) == "SI" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			if typeof(config.RearIndicatorColor) == "string" then
				v.Color = presets[2][config.RearIndicatorColor]
			elseif typeof(config.RearIndicatorColor) == "Color3" then
				v.Color = config.RearIndicatorColor
			end 
		end
	end
end
if config.InteriorLights then
	for i, v in pairs(lights.Interior:GetDescendants()) do
		if v.Name == "L" then
			local light 
			if v.Parent.Name == "Center" then
				light = Instance.new("PointLight", v)
			elseif v.Parent.Name == "Front" then
				light = Instance.new("SpotLight", v)
				light.Angle = 135
				light.Face = Enum.NormalId.Front
			end
			light.Range = 9
			light.Name = "L"
			light.Brightness = 0
			light.Shadows = true
			if typeof(config.InteriorLightColor) == "string" then
				light.Color = presets[2][config.InteriorLightColor]
			elseif typeof(config.InteriorLightColor) == "Color3" then
				light.Color = config.InteriorLightColor
			end 
		elseif v.Name == "LN" then
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			if typeof(config.InteriorLightColor) == "string" then
				v.Color = presets[1][config.InteriorLightColor]
			elseif typeof(config.InteriorLightColor) == "Color3" then
				v.Color = config.InteriorLightColor
			end
		end	
	end
end
for i, v in pairs(lights.Indicators:GetDescendants()) do
	if v.Name == "L" then
		local sfc = Instance.new("SpotLight", v)
		sfc.Name = "L"
		sfc.Brightness = 0
		sfc.Range = 16
		sfc.Face = Enum.NormalId.Front
		sfc.Angle = 180
		sfc.Shadows = true
		if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
			if typeof(config.FrontIndicatorColor) == "string" then
				sfc.Color = presets[2][config.FrontIndicatorColor]
			elseif typeof(config.FrontIndicatorColor) == "Color3" then
				sfc.Color = config.FrontIndicatorColor
			end 	
		elseif v.Parent.Name == "Rear" then
			if typeof(config.RearIndicatorColor) == "string" then
				sfc.Color = presets[2][config.RearIndicatorColor]
			elseif typeof(config.RearIndicatorColor) == "Color3" then
				sfc.Color = config.RearIndicatorColor
			end 
		end
	elseif v.Name == "LN" or string.sub(v.Name, 1, 2) == "SI" then
		if v:IsA("MeshPart") then
			v.TextureID = ""
		end
		v.Transparency = 1
		v.Material = Enum.Material.Neon
		if v.Parent.Name == "Front" or v.Parent.Name == "Side" then
			if typeof(config.FrontIndicatorColor) == "string" then
				v.Color = presets[2][config.FrontIndicatorColor]
			elseif typeof(config.FrontIndicatorColor) == "Color3" then
				v.Color = config.FrontIndicatorColor
			end 	
		elseif v.Parent.Name == "Rear" then
			if typeof(config.RearIndicatorColor) == "string" then
				v.Color = presets[2][config.RearIndicatorColor]
			elseif typeof(config.RearIndicatorColor) == "Color3" then
				v.Color = config.RearIndicatorColor
			end 
		end
	end
end
if config.IlluminatedReflectors then
	for i, v in pairs(lights.Reflectors:GetDescendants()) do
		if v.Name == "LN" then 
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
			v.Transparency = 1
			v.Material = Enum.Material.Neon
			if v.Parent.Name == "Orange" then
				if typeof(config.OrangeReflectorColor) == "string" then
					v.Color = presets[1][config.OrangeReflectorColor]
				elseif typeof(config.OrangeReflectorColor) == "Color3" then
					v.Color = config.OrangeReflectorColor
				end
			elseif v.Parent.Name == "Red" then
				v.Color = config.RedReflectorColor
			end	
		end
	end
end
print("EpicLights V4 // Handler setup completed")
-- functions
function doTween(i, ti, pt)
	TweenService:Create(i, ti, pt):Play()
end

function updatelights(model: Model, tp: number, br: number?, rng: number?)
	br = br or 0
	for i, v in pairs(model:GetDescendants()) do
		if v.Name == "L" and v:IsA("Light") then
			doTween(v, selected_TI, {Brightness = br})
			if rng ~= nil then
				v.Range = rng
			end
		elseif v.Name == "LN" then
			doTween(v, selected_TI, {Transparency = tp})
		end
	end
end

function sequentialsequence(model: Model, val: boolean)
	if val then
		for i = 1, config.SequentialAmount do
			for id, v in pairs(model:GetDescendants()) do
				if v.Name == "SI"..i then
					doTween(v, selected_TI, {Transparency = 0.02})
				end	
			end	
			task.wait(config.IndicatorFlashRate / config.SequentialAmount)
		end
	else
		for i, v in pairs(model:GetDescendants()) do
			if string.sub(v.Name, 1, 2) == "SI" then
				doTween(v, selected_TI, {Transparency = 1})
			end
		end
	end	
end

function indicatorIllum(transparency)
	updatelights(lights.Indicators.LeftInd.Front, transparency)
	updatelights(lights.Indicators.LeftInd.Side, transparency)
	updatelights(lights.Indicators.RightInd.Front, transparency)
	updatelights(lights.Indicators.RightInd.Side, transparency)
end

local otp = 1
local iotp = 1

local checks = {
	["TrunkLights"] = {
		val = config.TrunkLights,
		callback = function(t, tp, b, s)
			if s ~= nil then
				updatelights(trunk[t][s], tp, b)
			else
				updatelights(trunk[t], tp, b)
			end
		end
	},
	["Reflectors"] = {
		val = config.IlluminatedReflectors,
		callback = function(tp)
			iotp = tp
			indicatorIllum(tp)
			updatelights(lights.Reflectors, tp)
		end
	},
	["PlateLights"] = {
		val = config.PlateLights,
		callback = function(t, tp, b)
			updatelights(lights.Plate, tp, b)
		end
	},
	["Popups"] = {
		val = config.PopupsEnabled,
		callback = function(t, tp, b, rng)
			updatelights(popups.Parts.Headlights, tp, b, rng)
		end
	},
	["DoorIndicators"] = {
		val = config.DoorIndicators,
		callback = function(t, tp, b)
			updatelights(t.Indicators, tp, b)
		end
	},
	["SequentialIndicators"] = {
		val = config.SequentialIndicators,
		callback = function(t, bool)
			task.spawn(sequentialsequence, t, bool)
		end
	}
}

function doCheck(ct, t, tp, b, tp2)
	pcall(function()
		if not checks[ct].val then return end
		checks[ct].callback(t, tp, b, tp2)	
	end)
end

-- light functions
F.Lights = function(val, runningval)
	values.Lights.Value = val or values.Lights.Value
	if runningval ~= nil then
		values.Running.Value = runningval
		if config.RunningHeadlight then
			if values.Running.Value then
				otp = 0.27
				if config.IlluminatedReflectors then
					iotp = 0.27
				end
			else 
				otp = 1
				iotp = 1
			end
		else
			if values.Running.Value then
				updatelights(lights.Headlights.Running, 0.27, config.RunningLightBrightness)
				if config.IlluminatedReflectors then
					iotp = 0.27
				end
			else
				updatelights(lights.Headlights.Running, 1, config.RunningLightBrightness)
				if config.IlluminatedReflectors then
					iotp = 1
				end
			end
		end	
	end	
	if values.Lights.Value == 0 then
		if values.Running.Value and config.IlluminatedReflectors then
			iotp = 0.27
		else
			iotp = 1
		end
		doCheck("Reflectors", iotp)
		doCheck("PlateLights", nil, 1, 0)
		doCheck("Popups", nil, otp, 0, 48)
		doCheck("TrunkLights", "Rear", 1, 0)
		updatelights(lights.Headlights.Low, otp, 0, 48)
		updatelights(lights.Headlights.High, 1, 0)
		updatelights(lights.Rear, 1, 0)
	elseif values.Lights.Value == 1 then
		doCheck("Reflectors", 0.27)
		doCheck("PlateLights", nil, 0.02, 1)
		doCheck("Popups", nil, 0.2, config.LowBeamBrightness, 48)
		doCheck("TrunkLights", "Rear", 0.2, config.RearLightBrightness)
		updatelights(lights.Headlights.Low, 0.2, config.LowBeamBrightness)
		updatelights(lights.Headlights.High, 1, 0)
		updatelights(lights.Rear, 0.2, config.RearLightBrightness)
	elseif values.Lights.Value == 2 then
		doCheck("Popups", nil, 0.02, config.HighBeamBrightness, 60)
		updatelights(lights.Headlights.Low, 0.02, config.HighBeamBrightness, 60)
		updatelights(lights.Headlights.High, 0.02, config.HighBeamBrightness)
	end
end

F.Flash = function(val)
	if values.Lights.Value ~= 2 then
		if val then
			doCheck("Popups", nil, 0.02, config.HighBeamBrightness, 48)
			updatelights(lights.Headlights.Low, 0.02, config.HighBeamBrightness, 60)
			updatelights(lights.Headlights.High, 0.02, config.HighBeamBrightness)
		else
			F.Lights()
		end
	end
end

F.Fogs = function(val, override)
	values.Fogs.Value = val
	if values.Fogs.Value and values.Lights.Value > 0 and not override then
		updatelights(lights.Fog, 0.02, config.FogLightBrightness) 
	elseif not values.Fogs.Value or override then
		updatelights(lights.Fog, 1, 0)
	end
end

F.Brake = function(val)
	if val then
		doCheck("TrunkLights", "Brake", 0.02, config.BrakeLightBrightness)
		updatelights(lights.Brake, 0.02, config.BrakeLightBrightness)
	else
		doCheck("TrunkLights", "Brake", 1, 0)
		updatelights(lights.Brake, 1, 0)
	end
end

F.Reverse = function(val)
	if val then
		doCheck("TrunkLights", "Reverse", 0.02, config.ReverseLightBrightness)
		updatelights(lights.Reverse, 0.02, config.ReverseLightBrightness)
	else
		doCheck("TrunkLights", "Reverse", 1, 0)
		updatelights(lights.Reverse, 1, 0)
	end
end

F.Signal = function(type, val)
	for i, v in pairs(values.Indicators:GetChildren()) do
		if v.Name == type then
			v.Value = val
		else
			v.Value = false
		end
	end
end

F.Popups = function(val)
	values.Popups.Value = val
	if config.PopupHingeType == "Single" and config.PopupsEnabled then
		local motor = popups.Hinge.Motor
		if values.Popups.Value then
			motor.DesiredAngle = config.PopupHingeAngle
		else
			motor.DesiredAngle = 0
		end
	elseif config.PopupHingeType == "Dual" and config.PopupsEnabled then
		local motor1 = popups.Hinge1.Motor
		local motor2 = popups.Hinge2.Motor
		if values.Popups.Value then
			motor1.DesiredAngle = config.PopupHingeAngle
			motor2.DesiredAngle = config.PopupHingeAngle
		else
			motor1.DesiredAngle = 0
			motor2.DesiredAngle = 0
		end
	end
end
-- signal loop
task.spawn(function()
	while wait() do
		if values.Indicators.Left.Value then
			doCheck("TrunkLights", "Indicators", 0.02, 1, "LeftInd")
			doCheck("DoorIndicators", door_FL, 0.02, 0)
			doCheck("SequentialIndicators", lights.Indicators.LeftInd, true)
			updatelights(lights.Indicators.LeftInd, 0.02, 1)
			task.wait(config.IndicatorFlashRate)
			doCheck("TrunkLights", "Indicators", 1, 0, "LeftInd")
			doCheck("DoorIndicators", door_FL, 1, 0)
			doCheck("SequentialIndicators", lights.Indicators.LeftInd, false)
			updatelights(lights.Indicators.LeftInd.Front, iotp, 0)
			updatelights(lights.Indicators.LeftInd.Side, iotp, 0)
			updatelights(lights.Indicators.LeftInd.Rear, 1, 0)
			task.wait(config.IndicatorFlashRate)
		end
		if values.Indicators.Right.Value then
			doCheck("TrunkLights", "Indicators", 0.02, 1, "RightInd")
			doCheck("DoorIndicators", door_FR, 0.02, 0)
			doCheck("SequentialIndicators", lights.Indicators.RightInd, true)
			updatelights(lights.Indicators.RightInd, 0.02, 1)
			task.wait(config.IndicatorFlashRate)
			doCheck("TrunkLights", "Indicators", 1, 0, "RightInd")
			doCheck("DoorIndicators", door_FL, 1, 0)
			doCheck("SequentialIndicators", lights.Indicators.RightInd, false)	
			updatelights(lights.Indicators.RightInd.Front, iotp, 0)
			updatelights(lights.Indicators.RightInd.Side, iotp, 0)
			updatelights(lights.Indicators.RightInd.Rear, 1, 0)
			task.wait(config.IndicatorFlashRate)
		end
		if values.Indicators.Hazard.Value then
			doCheck("TrunkLights", "Indicators", 0.02, 1)
			doCheck("DoorIndicators", door_FL, 0.02, 0)
			doCheck("DoorIndicators", door_FR, 0.02, 0)
			doCheck("SequentialIndicators", lights.Indicators, true)	
			updatelights(lights.Indicators, 0.02, 1)
			task.wait(config.IndicatorFlashRate)
			doCheck("TrunkLights", "Indicators", 1, 0)
			doCheck("DoorIndicators", door_FL, 1, 0)
			doCheck("DoorIndicators", door_FR, 1, 0)
			doCheck("SequentialIndicators", lights.Indicators, false)	
			indicatorIllum(iotp)
			updatelights(lights.Indicators.LeftInd.Rear, 1, 0)
			updatelights(lights.Indicators.RightInd.Rear, 1, 0)
			task.wait(config.IndicatorFlashRate)
		end
	end
end)

if config.InteriorLights then
	local center_override = false
	local front_override = false
	local door_open = false
	local int_triggers = car.Body:FindFirstChild("InteriorTriggers")
	local event1 = int_triggers:FindFirstChild("OverrideTriggers")
	if #doors > 0 and config.DoorFunctionality then
		for i, v in pairs(doors) do
			local event2 = v:FindFirstChild("LightsDoor")
			event2.Event:Connect(function(s)
				door_open = s
				if s then
					if not center_override then
						updatelights(lights.Interior.Center, 0.02, 0.38)
					end
					if not front_override then
						updatelights(lights.Interior.Front, 0.02, 0.38)
					end
				else
					if not center_override then
						updatelights(lights.Interior.Center, 1, 0)
					end
					if not front_override then
						updatelights(lights.Interior.Front, 1, 0)
					end
				end
			end)
		end
	end	
	event1.Event:Connect(function(s, t)
		if t == "Center" then
			center_override = s
			if not door_open then
				if s then
					updatelights(lights.Interior.Center, 0.02, 0.38)
				else
					updatelights(lights.Interior.Center, 1, 0)
				end
			end	
		elseif t == "Front" then
			front_override = s
			if not door_open then
				if s then
					updatelights(lights.Interior.Front, 0.02, 0.38)
				else
					updatelights(lights.Interior.Front, 1, 0)
				end	
			end
		end	
	end)	
end	



script.Parent.OnServerEvent:Connect(function(plr, Fnc, ...)
	F[Fnc](...)
end)
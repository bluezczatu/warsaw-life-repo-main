--[[

   ____ ___   ____ _____ __    ____ _____ __ __ ______ ____  _   __ ____
  / __// _ \ /  _// ___// /   /  _// ___// // //_  __// __/ | | / // / /
 / _/ / ___/_/ / / /__ / /__ _/ / / (_ // _  /  / /  _\ \   | |/ //_  _/
/___//_/   /___/ \___//____//___/ \___//_//_/  /_/  /___/   |___/  /_/  
                            by VG3O_J
                 discord: https://discord.gg/Vk7uGNnX9M  
                            
]]--

local config = {}

-- toggle settings
config.InteriorLights = false -- enables interior dome lighting

config.DoorFunctionality = false -- for opening doors, interior dome lighting will be active when the doors open, and if you have RunningOnOpen enabled, it will also trigger the running lights if a door is opened.

config.PlateLights = false -- enables license plate lights

config.IlluminatedReflectors = true -- lights up your reflectors and indicators when the running lights or headlights are on  i.e. the orange truck trailer lights

config.TrunkLights = false  

config.DoorIndicators = false 

-- light settings
--[[
	LIGHT TYPES:
		- Incandescent
		- LED
]]
config.LowBeamBrightness = 2

config.HighBeamBrightness = 4

config.FogLightBrightness = 3

config.RearLightBrightness = 1.5

config.BrakeLightBrightness = 2

config.ReverseLightBrightness = 1

config.LightType = "Incandescent" -- includes headlights, rear, and brake lights

config.IndicatorFlashRate = 0.3 -- the time it takes between each indicator tick


-- running light settings
config.RunningHeadlight = false -- if true, the running lights will ignore the "Running" model and go to the low beams

config.RunningOnOpen = false -- if true, the running light keybind will no longer function and the running lights will turn on when you get into the driveseat.

config.RunningLightType = "Incandescent"

config.RunningLightColor = "Incandescent"

-- sequential indicator settings
config.SequentialIndicators = true -- enables sequential indicators

config.SequentialAmount = 3 -- the amount of sequential parts

-- popup light settings
config.PopupsEnabled = false -- enables popups

config.PopupHingeAngle = -0.75 -- the amount your popups travel

config.PopupHingeType = "Single" -- use "Dual" if your popups require strange or weird angles to properly flip up


-- color settings
--[[
	COLOR PRESETS:
		
	Headlights
		- Incandescent
		- Xenon
		- Pure White
		- Brilliant Blue
		- Light Green
		- Golden Yellow
		- Yellow
	Indicators
		- Light Orange
		- Dark Orange
		- Red
		
	For custom color use "Color3.fromRGB(R, G, B)". You can get your RGB code from the "Color" property.
]]--
config.HeadlightColor = "Incandescent"

config.RearLightColor = Color3.fromRGB(248, 87, 73)

config.BrakeLightColor = Color3.fromRGB(248, 87, 73)

config.ReverseLightColor = "Incandescent"

config.InteriorLightColor = "Incandescent"

config.FrontIndicatorColor = "Dark Orange"

config.RearIndicatorColor = "Dark Orange"

config.DoorIndicatorColor = "Dark Orange"

config.OrangeReflectorColor = "Dark Orange"

config.RedReflectorColor = Color3.fromRGB(248, 87, 73)

config.FogLightColor = "Incandescent"

config.PlateLightColor = "Incandescent"

-- keybinds
config.Headlights = Enum.KeyCode.H

config.RunningLights = Enum.KeyCode.N

config.FogLights = Enum.KeyCode.J

config.SignalLeft = Enum.KeyCode.Z

config.SignalRight = Enum.KeyCode.C

config.Hazards = Enum.KeyCode.X

config.Popups = Enum.KeyCode.B

config.HighBeamFlash = Enum.KeyCode.L


return config
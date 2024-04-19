script.Parent.Enabled = true
local clock = os.clock()
local ContentProvider = game:GetService("ContentProvider")

local logoid = "rbxassetid://14892661748"
local backgroundid = "rbxassetid://16151085039"
local musicid = "rbxassetid://9490895924"

local logoinstance = Instance.new("Decal")
logoinstance.Texture  = logoid

local backgroundinstance = Instance.new("Decal")
backgroundinstance.Texture = backgroundid

local soundinstance = Instance.new("Sound")
soundinstance.SoundId = musicid


local assetstoload = { logoinstance, backgroundinstance, soundinstance }
ContentProvider:PreloadAsync(assetstoload)
warn("LOADED LOADING SCREEN")

local tween = game:GetService("TweenService")
local gradient = script.Parent.GradientFrame
local background = script.Parent.BackgroundFrame.ImageLabel
local logo = script.Parent.FrameLogo.Frame.ImageLabel
local music = script.Parent.Sound

music:Play()



wait(3)
game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()


local function OffLoadingScreen()
	gradient.BlurScript.Enabled = false
	local transparencyTween1 = tween:Create(gradient, TweenInfo.new(3), {BackgroundTransparency = 0})
	local transparencyTween2 = tween:Create(gradient, TweenInfo.new(3), {BackgroundTransparency = 1})
	local transparencyTween3 = tween:Create(background, TweenInfo.new(3), {ImageTransparency = 1})
	local transparencyTween31 = tween:Create(script.Parent.FrameLogo.TextLabel, TweenInfo.new(3), {TextTransparency = 1})
	local transparencyTween4 = tween:Create(logo, TweenInfo.new(3), {ImageTransparency = 1})
	local musicTween = tween:Create(music, TweenInfo.new(5), {Volume = 0})

	transparencyTween31:Play()
	wait(3)
	transparencyTween2:Play()
	wait(3)
	transparencyTween3:Play()
	wait(1)
	transparencyTween4:Play()
	wait(3)
	script.Parent.Enabled = false
	musicTween:Play()
	wait(5)
	music:Stop()
end


if not game:IsLoaded() then
	game.Loaded:Wait()
end
--wait(10)

print(("Preloading complete, took %.2f seconds"):format(os.clock() - clock))

OffLoadingScreen()
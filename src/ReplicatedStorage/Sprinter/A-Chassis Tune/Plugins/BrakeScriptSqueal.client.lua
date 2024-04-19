wait(0.1)

local car = script.Parent.Car.Value
local Brake = script.Brake
local TweenService = game:GetService("TweenService")

Brake.Parent = car.Wheels.RR

script.Parent.Values.Brake.Changed:connect(function()
		TweenService:Create(Brake,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut),{
			["Volume"] = 0,
		}):Play()
		TweenService:Create(Brake,TweenInfo.new(0.3,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut),{
			["PlaybackSpeed"] = 0,
		}):Play()
		if script.Parent.Values.Brake.Value == 1 and car.DriveSeat.Velocity.Magnitude > 4 then
			TweenService:Create(Brake,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut),{
				["Volume"] = 2,
			}):Play()
			TweenService:Create(Brake,TweenInfo.new(0.3,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut),{
				["PlaybackSpeed"] = 0.9,
			}):Play()
		end
end)

if car.DriveSeat.Velocity.Magnitude > 4 then
	TweenService:Create(Brake,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut),{
		["Volume"] = 2,
	}):Play()
else
	TweenService:Create(Brake,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut),{
		["Volume"] = 0,
	}):Play()
end
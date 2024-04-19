wait(1)
local tween = game:GetService("TweenService")
local gradient = script.Parent
gradient.BackgroundTransparency = 0.75

gradient.Rotation = 0
rotateTween1 = tween:Create(gradient, TweenInfo.new(3), {Rotation = 360})
rotateTween2 = tween:Create(gradient, TweenInfo.new(3), {Rotation = 0})

transparencyTween1 = tween:Create(gradient, TweenInfo.new(3), {BackgroundTransparency = 0.4})
transparencyTween2 = tween:Create(gradient, TweenInfo.new(3), {BackgroundTransparency = 0.6})

while wait() do
	rotateTween1:Play()
	transparencyTween1:Play()
	wait(3)
	rotateTween2:Play()
	transparencyTween2:Play()
	wait(3)
end

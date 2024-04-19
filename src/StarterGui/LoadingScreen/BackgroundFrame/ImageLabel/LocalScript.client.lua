-- Pamiętaj, aby umieścić ten skrypt w ImageLabel, którego chcesz animować.

local TweenService = game:GetService("TweenService")
local imageLabel = script.Parent -- Pobierz ImageLabel
local frame = imageLabel.Parent -- Pobierz Frame, który zawiera ImageLabel

-- Ustaw ImageLabel na środku frame
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)

local function createTween(property, endValue, duration)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenGoal = {}
	tweenGoal[property] = endValue

	local tween = TweenService:Create(imageLabel, tweenInfo, tweenGoal)
	return tween
end

local function animateZoom()
	while true do
		local zoomInTween = createTween("Size", UDim2.new(1.2, 0, 1.2, 0), 5)
		local zoomOutTween = createTween("Size", UDim2.new(1, 0, 1, 0), 5)

		zoomInTween:Play()
		zoomInTween.Completed:Wait()

		wait(1) -- Poczekaj 1 sekundę po zwiększeniu

		zoomOutTween:Play()
		zoomOutTween.Completed:Wait()

		wait(1) -- Poczekaj 1 sekundę po zmniejszeniu
	end
end

animateZoom()

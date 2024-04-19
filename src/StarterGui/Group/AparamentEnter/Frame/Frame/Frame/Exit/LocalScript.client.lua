local button = script.Parent



button.MouseEnter:Connect(function()
	
	
	button.UIStroke.Color = Color3.fromRGB(255, 85, 85)
	button.UIStroke.Transparency = 0
	
	--button.Image = "rbxassetid://15700844591"
end)

button.MouseLeave:Connect(function()
	
	button.UIStroke.Color = Color3.fromRGB(255, 255, 255)
	button.UIStroke.Transparency = 0.7
	--button.Image = "rbxassetid://15700844754"
end)


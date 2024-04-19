local Values = script.Parent.Parent.Parent.Values

local mouse = game.Players.LocalPlayer:GetMouse()

script.Parent.MouseButton1Click:Connect(function()
	if not Values.AutoClutch.Value then
		local GPos = (mouse.ViewSizeX*0.5)-205
		Values.Clutch.Value = 1-(.01*(mouse.X-GPos))
	end
end)

script.Parent.Auto.MouseButton1Click:Connect(function()
	Values.AutoClutch.Value = not Values.AutoClutch.Value
end)

while wait() do
	if Values.AutoClutch.Value then
		script.Parent.Level.BackgroundColor3 = Color3.new(0.4,0.4,0.4)
	else
		script.Parent.Level.BackgroundColor3 = Color3.new(1,1,1)
	end
	local size = (1-Values.Clutch.Value)
	script.Parent.Level.Size = UDim2.new(size,0,0,3)
end
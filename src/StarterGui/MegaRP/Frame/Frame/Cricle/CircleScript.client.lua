local CircleModule = require(game.ReplicatedStorage.Modules:FindFirstChild("ModuleCircleUi"))

local buttons_data = CircleModule.getData()

local player = game.Players.LocalPlayer

local buttons = 0
for _ in pairs(buttons_data) do
	buttons = buttons + 1
end



--local buttons = tonumber(script.Parent.Parent.Parent.Parent.Parent:WaitForChild("ScreenSize").Frame.TextBox.Text)

local size_steps = 360 / buttons

local rotation = 0



script.Parent.Circle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
for _,v in pairs(script.Parent.CanvasGroup:GetDescendants()) do
	if v:IsA("Frame") then
		if v.Name ~= "Circle" and v.Name ~= "Frame" and v.Name ~= "Frame2" then
			v:Destroy()
		end
	end
end


local imagesteps = {
	[1] = 0,
	[2] = 0,
	[3] = 30,
	[4] = 45,
	[5] = 53,
	[6] = 59,
	[7] = 63,
	[8] = 66,
	[9] = 68,
	[10] = 70.5
}



local clone_frame = script.Frame


for i, _ in pairs(buttons_data) do
	--print(i)

	--print(buttons_data[i])

	--print(i)
	local cloned_frame = clone_frame:Clone()
	cloned_frame.Parent = script.Parent.CanvasGroup
	cloned_frame.Name = i
	--print(size_steps)
	cloned_frame.CanvasGroup.Frame.Rotation = (360 / buttons - 180)


	cloned_frame.Parent = script.Parent.CanvasGroup
	clone_frame.Rotation = (i * (360 / buttons))
	--clone_frame.CanvasGroup.Frame.ZIndex = i - 10 

	local imageframe = cloned_frame.CanvasGroup.Frame.CanvasGroup.Frame2
	local center_step = size_steps * (buttons / 2)

	local slope = (62 - 30) / (7 - 3)  -- różnica kątów podzielona przez różnicę buttonów
	local base_angle = 30 - slope * (3 - 2)  -- punkt startowy (dla buttons=2)
	local anglex = base_angle + slope * (buttons - 2)



	local image = imageframe.ImageLabel

	image.Image =  buttons_data[i].Image

	--warn(image.Rotation)

	imageframe.Rotation = imagesteps[buttons]

	image.Rotation = (- image.AbsoluteRotation - 360) - 180

end




local button_circle = script.Parent.CanvasGroup.TextButton

button_circle.MouseButton1Click:Connect(function()

	local mouse = game.Players.LocalPlayer:GetMouse()
	local mousePosition = Vector2.new(mouse.X, mouse.Y)

	-- Get the center of the screen
	local screenSize = workspace.CurrentCamera.ViewportSize
	local screenCenter = Vector2.new(screenSize.X / 2, screenSize.Y / 2)

	-- Calculate the angle between the center of the screen and the mouse position
	local angle = math.atan2(mousePosition.Y - screenCenter.Y, mousePosition.X - screenCenter.X)
	if angle < 0 then
		angle = angle + 2 * math.pi
	end

	-- Calculate the angle per section
	local anglePerSection = 2 * math.pi / buttons

	-- Determine which section the mouse is in
	local section = math.floor(angle / anglePerSection) + 1

	-- Print the section number
	print("Clicked in section: " .. section)
	
	if buttons_data[section].Frame ~= nil then
		buttons_data[section].Frame.Visible = true
	end
	if buttons_data[section].RemoteEvent ~= nil then
		buttons_data[section].RemoteEvent:FireServer()
		script.Parent.Visible = false
		script.Enabled = false
	end
	
	--if buttons_data[section].Name == "Tablet" then
	--	player.PlayerGui.MegaRP.Frame.Frame.Tablet.Visible = true
	--end
end)






local section_save = ""

while wait(0.1) do





	local mouse = game.Players.LocalPlayer:GetMouse()
	local mousePosition = Vector2.new(mouse.X, mouse.Y)

	-- Get the center of the screen
	local screenSize = script.Parent.Parent.Parent.Parent.Parent.ScreenSize.Frame.AbsoluteSize
	local screenCenter = Vector2.new(screenSize.X / 2, screenSize.Y / 2)

	--screenCenter = Vector2.new({0.5},{0.5})

	-- Calculate the angle between the center of the screen and the mouse position
	local angle = math.atan2(mousePosition.Y - screenCenter.Y, mousePosition.X - screenCenter.X)
	if angle < 0 then
		angle = angle + 2 * math.pi
	end

	-- Calculate the angle per section
	local anglePerSection = 2 * math.pi / buttons

	-- Determine which section the mouse is in




	local smallCircleRadius = 80 -- Radius of the small circle
	local distance = (mousePosition - screenCenter).Magnitude
	local isInSmallCircle = distance <= smallCircleRadius




	-- Print whether the mouse is inside the small circle or not
	if isInSmallCircle then

		local section = "button"


		--warn("Mouse is inside the small circle")

		if section ~= section_save then

			--print("Mouse is in section: " .. section)

			for _,v in pairs(script.Parent.CanvasGroup:GetDescendants()) do
				if v:IsA("Frame") then
					if v.Name ~= "Circle" and v.Name ~= "Frame" and v.Name ~= "Frame2" then
						v.CanvasGroup.Frame.CanvasGroup.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(50, 50, 50)
					end
				end
			end




			script.Parent.Circle.BackgroundColor3 = Color3.fromRGB(141, 84, 233)


		end

		section_save = section



	else
		if section_save == "button" then
			script.Parent.Circle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end

		local section = math.floor(angle / anglePerSection) + 1


		--print("Mouse is not inside the small circle")


		if section ~= section_save then

			--print("Mouse is in section: " .. section)

			for _,v in pairs(script.Parent.CanvasGroup:GetDescendants()) do
				if v:IsA("Frame") then
					if v.Name ~= "Circle" and v.Name ~= "Frame" and v.Name ~= "Frame2" then
						v.CanvasGroup.Frame.CanvasGroup.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(50, 50, 50)
					end
				end
			end



			script.Parent.CanvasGroup:FindFirstChild(section).CanvasGroup.Frame.CanvasGroup.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(141, 84, 233)


		end

		section_save = section







	end




end

local UserInputService = game:GetService("UserInputService")
local gui = script.Parent.Parent.Cricle
local CircleScript = script.Parent.Parent.Cricle.CircleScript

-- Początkowe ustawienie GUI jako niewidoczne


-- Funkcja obsługująca przełączanie widoczności GUI
local function toggleGUI()
	if gui.Visible == true then
		CircleScript.Enabled = false
		gui.Visible = false
	else
		CircleScript.Enabled = true
		gui.Visible = true
	end
end







-- make loop to add interaction clicked to buttons in CanvasGroup.Frame

wait(1)

local function HideScreens()
	for i, screen in ipairs(script.Parent.Screens:GetChildren()) do
		if screen:IsA("Frame") then
			screen.Visible = false
		end
	end
end

local function HideButtons()
	for i, button in ipairs(script.Parent.Buttons.Frame:GetChildren()) do
		if button:IsA("TextButton") then
			print(button.Name)
			button.TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
			button.ImageLabel.ImageColor3 = Color3.fromRGB(180, 180, 180)
			button.TextLabel.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		end
	end
end

for i, button in ipairs(script.Parent.Buttons.Frame:GetChildren()) do
	if button:IsA("TextButton") then
		button.MouseButton1Click:Connect(function()
			print(button.Name)
			HideScreens()
			
			HideButtons()
			button.TextLabel.FontFace.Weight = Enum.FontWeight.Bold
			button.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.ImageLabel.ImageColor3 = Color3.fromRGB(0, 170, 255)
			print(button.TextLabel.FontFace)

			button.TextLabel.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			
			
			if script.Parent.Screens:FindFirstChild(button.Name) then
				script.Parent.Screens:FindFirstChild(button.Name).Visible = true
			end
		end)
	end
end


script.Parent.Buttons.Exit.MouseButton1Click:Connect(function()
	script.Parent.Visible = false
	toggleGUI(false)
end)
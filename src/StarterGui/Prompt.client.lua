

local prompt_service = game:GetService("ProximityPromptService")
local user_input_service = game:GetService("UserInputService")
local tween_service = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local plr = player

--remote function
local PromptFunction = game.ReplicatedStorage.RemoteFunctions.PromptFunction

local current_prompt = nil
local basePart = nil
local currentTween = nil
local promptUI = script.PromptUI

local connnectionscroll = nil

local scroll = 1

-- kley handcuffs
--local handcuffRemoteEvent = game.ReplicatedStorage:WaitForChild("handcuff")






local function clearcolorlabels(promptUI)
	for i,v in pairs(promptUI.Frame.Frame2:GetChildren()) do
		
		if v:IsA("Frame") then
			
			v.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			
		end
	end
end

local function scrollmode(mode, promptUI)
	
	if mode == "true" then
		scroll = 1
		
		clearcolorlabels(promptUI)
		if promptUI.Frame.Frame2:FindFirstChild(scroll) then
			promptUI.Frame.Frame2:FindFirstChild(scroll).BackgroundColor3 = Color3.fromRGB(141, 84, 233)
		end
		
		player.CameraMinZoomDistance = (workspace.CurrentCamera.Focus.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
		player.CameraMaxZoomDistance = (workspace.CurrentCamera.Focus.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
		
		connnectionscroll = user_input_service.InputChanged:connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseWheel then
				if scroll - input.Position.Z < 0 then return end
				local label = promptUI.Frame.Frame2:FindFirstChild(scroll - input.Position.Z)
				if not label then return end
			
				clearcolorlabels(promptUI)
				label.BackgroundColor3 = Color3.fromRGB(141, 84, 233)

				scroll = scroll - input.Position.Z
		
			end
		end)

	else
		
		player.CameraMinZoomDistance = 0
		player.CameraMaxZoomDistance = 128
		
		connnectionscroll:Disconnect()
	end
	
end

prompt_service.PromptShown:Connect(function(prompt, inputType)
	
	if prompt:FindFirstChild("ModuleScript") then
		
		local moddule = require(prompt.ModuleScript)


		for i,v in pairs(promptUI.Frame.Frame2:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end

		for i,v in pairs(moddule.Table) do

			local label = promptUI.Frame.Frame2.UIListLayout.Label:Clone()

			label.Visible = true

			label.Parent = promptUI.Frame.Frame2

			label.TextLabel.Text = tostring(v)

			label.LayoutOrder = i


			label.Name = i

		end
		
		scrollmode("true", promptUI)
		
		if #moddule.Table == 1 then
			promptUI.Frame.Frame2:FindFirstChild(scroll).BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end
		
	else
		for i,v in pairs(promptUI.Frame.Frame2:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end
		
		local label = promptUI.Frame.Frame2.UIListLayout.Label:Clone()

		label.Visible = true

		label.Parent = promptUI.Frame.Frame2

		label.TextLabel.Text = prompt.ActionText

		
		
		
		scrollmode("true", promptUI)
		
		
	end
	
	

	
	
	scroll = 1
	tween_service:Create(promptUI, TweenInfo.new(.1), {Size = UDim2.new(5, 0, 5, 0)}):Play()

	if user_input_service.KeyboardEnabled == true and user_input_service.MouseEnabled == true and user_input_service.TouchEnabled == false then
		
		current_prompt = prompt
		basePart = prompt.Parent

		prompt.Style = Enum.ProximityPromptStyle.Custom

		promptUI.Adornee = basePart

		promptUI.Frame.Frame.ObjectText.Text = prompt.ObjectText
		promptUI.Frame.Frame.ActionText.Text = prompt.ActionText
		promptUI.Frame.Frame.Keybind.Text = prompt.KeyboardKeyCode.Name
		promptUI.Enabled = true

		if user_input_service.GamepadEnabled == true then
			promptUI.Frame.Frame.Keybind.Text = prompt.GamepadKeyCode.Name
		else
			promptUI.Frame.Frame.Keybind.Text = prompt.KeyboardKeyCode.Name
		end

		--if prompt.ActionText == "" and prompt.ObjectText == "" then
		--	promptUI.Frame.Frame.Size = UDim2.new(5.3, 0, 5.5, 0)
		--	promptUI.Frame.Frame.Keybind.Size = UDim2.new(1, 0, 1, 0)
		--end
	elseif user_input_service.KeyboardEnabled == false and user_input_service.MouseEnabled == false and user_input_service.TouchEnabled == true then

	end
end)

prompt_service.PromptButtonHoldBegan:Connect(function(prompt, playerWhoTriggered)
	if current_prompt == prompt then
		local tween = tween_service:Create(promptUI.Frame.Frame.Frame, TweenInfo.new(prompt.HoldDuration), {Size = UDim2.new(1.25,0,1.25,0)})
		tween:Play()
		currentTween = tween
	end
end)

-- Function to find a string in a table
function findStringInTable(tbl, searchString)
	for key, value in pairs(tbl) do
		if type(value) == "string" and value == searchString then
			return true, key -- Return true and the key if the string is found
		end
	end
	return false -- Return false if the string is not found
end

prompt_service.PromptButtonHoldEnded:Connect(function(prompt, playerWhoTriggered)
	if current_prompt == prompt then
		currentTween:Pause()
		currentTween:Cancel()
		currentTween = nil
		tween_service:Create(promptUI.Frame.Frame.Frame, TweenInfo.new(.1), {Size = UDim2.new(0,0,1,0)}):Play()
		
		local table_prompt = nil
		if prompt:FindFirstChild("ModuleScript") then
			local moddule = require(prompt.ModuleScript)
			
			table_prompt = moddule.Table
			
		else
			
			table_prompt = {
				prompt.ActionText
			}
			
		end
		
		if not prompt:FindFirstChild("ModuleScript") then return end
		
		local moddule = require(prompt.ModuleScript)
		
		-- add own code
		local handcuffActions = { -- podziwiaj ten kod
			"Zakuj",
			"Odkuj",
			"Prowadź",
			"Zatrzymaj",
			"Trzymaj"
		}
		
		--local found, key = findStringInTable(handcuffActions, moddule.Table[scroll])
		--if found then
		--	local tool = plr.Character:FindFirstChildWhichIsA("Tool")
		--	handcuffRemoteEvent:FireServer(prompt.Parent.Parent, moddule.Table[scroll], tool) -- to player jak cos
		--end

		local data = PromptFunction:InvokeServer(prompt, scroll, table_prompt) -- nie mow rekin od tylu
		

		if prompt:FindFirstChild("ModuleScript") then

			local moddule = require(prompt.ModuleScript)


			for i,v in pairs(promptUI.Frame.Frame2:GetChildren()) do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end

			for i,v in pairs(moddule.Table) do

				local label = promptUI.Frame.Frame2.UIListLayout.Label:Clone()

				label.Visible = true

				label.Parent = promptUI.Frame.Frame2

				label.TextLabel.Text = tostring(v)

				label.LayoutOrder = i


				label.Name = i

			end

			scrollmode("true", promptUI)

			if #moddule.Table == 1 then
				promptUI.Frame.Frame2:FindFirstChild(scroll).BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			end

		else
			for i,v in pairs(promptUI.Frame.Frame2:GetChildren()) do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end

			local label = promptUI.Frame.Frame2.UIListLayout.Label:Clone()

			label.Visible = true

			label.Parent = promptUI.Frame.Frame2

			label.TextLabel.Text = prompt.ActionText




			scrollmode("true", promptUI)


		end





		scroll = 1
		tween_service:Create(promptUI, TweenInfo.new(.1), {Size = UDim2.new(5, 0, 5, 0)}):Play()

		if user_input_service.KeyboardEnabled == true and user_input_service.MouseEnabled == true and user_input_service.TouchEnabled == false then

			current_prompt = prompt
			basePart = prompt.Parent

			prompt.Style = Enum.ProximityPromptStyle.Custom

			promptUI.Adornee = basePart

			promptUI.Frame.Frame.ObjectText.Text = prompt.ObjectText
			promptUI.Frame.Frame.ActionText.Text = prompt.ActionText
			promptUI.Frame.Frame.Keybind.Text = prompt.KeyboardKeyCode.Name
			promptUI.Enabled = true

			if user_input_service.GamepadEnabled == true then
				promptUI.Frame.Frame.Keybind.Text = prompt.GamepadKeyCode.Name
			else
				promptUI.Frame.Frame.Keybind.Text = prompt.KeyboardKeyCode.Name
			end

			--if prompt.ActionText == "" and prompt.ObjectText == "" then
			--	promptUI.Frame.Frame.Size = UDim2.new(5.3, 0, 5.5, 0)
			--	promptUI.Frame.Frame.Keybind.Size = UDim2.new(1, 0, 1, 0)
			--end
		elseif user_input_service.KeyboardEnabled == false and user_input_service.MouseEnabled == false and user_input_service.TouchEnabled == true then

		end
		
		
		
	end
end)

prompt_service.PromptHidden:Connect(function(prompt)
	
	scroll = 1
	scrollmode("false", promptUI)
	tween_service:Create(promptUI, TweenInfo.new(.1), {Size = UDim2.new(0, 0, 2, 0)}):Play()
	if user_input_service.KeyboardEnabled == true and user_input_service.MouseEnabled == true and user_input_service.TouchEnabled == false then
		if prompt == current_prompt then
			promptUI.Adornee = nil
			basePart = nil
			current_prompt = nil

			promptUI.Frame.Frame.ActionText.Text = ""
			promptUI.Frame.Frame.ObjectText.Text = ""
			promptUI.Frame.Frame.Keybind.Text = ""
			promptUI.Enabled = false

			--promptUI.Frame.Frame.Size = UDim2.new(.9, 0, .5, 0)
			--promptUI.Frame.Frame.Keybind.Size = UDim2.new(.3, 0, 1, 0)
		end
	end
end)

promptUI.Adornee = nil
basePart = nil
current_prompt = nil
promptUI.Frame.Frame.ActionText.Text = ""
promptUI.Frame.Frame.ObjectText.Text = ""
promptUI.Frame.Frame.Keybind.Text = ""
promptUI.Enabled = false
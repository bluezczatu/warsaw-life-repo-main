--//Variables
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StaminaEvent = ReplicatedStorage:WaitForChild("StaminaEvent")

--//Private functions

--/on input began
local function InputBegan(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		StaminaEvent:FireServer("RunStart")
	elseif input.KeyCode == Enum.KeyCode.Space then
		StaminaEvent:FireServer("Jump")		
	end
end

--//on input ended
local function InputEnded(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		StaminaEvent:FireServer("RunEnd")
	end
end


--//runners

UserInputService.InputBegan:Connect(InputBegan)
UserInputService.InputEnded:Connect(InputEnded)
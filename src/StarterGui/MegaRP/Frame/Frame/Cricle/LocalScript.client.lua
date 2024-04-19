local CircleModule = require(game.ReplicatedStorage.Modules:FindFirstChild("ModuleCircleUi"))
--warn(CircleModule.getData())
CircleModule.start()


local UserInputService = game:GetService("UserInputService")
local gui = script.Parent -- Załóżmy, że GUI jest bezpośrednim rodzicem skryptu
local CircleScript = script.Parent.CircleScript

-- Początkowe ustawienie GUI jako niewidoczne
gui.Visible = false
CircleScript.Enabled = false

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

-- Funkcja obsługująca zdarzenie naciśnięcia klawisza
local function onInputBegan(input, isGameProcessed)
	if not isGameProcessed then -- Jeśli zdarzenie nie zostało jeszcze przetworzone przez grę
		if input.KeyCode == Enum.KeyCode.B then -- Jeśli naciśnięty klawisz to "B"
			toggleGUI() -- Wywołujemy funkcję przełączającą GUI
		end
	end
end

-- Przypisanie funkcji obsługującej zdarzenia do UserInputService
UserInputService.InputBegan:Connect(onInputBegan)


local button_x = script.Parent.Circle.TextButton

button_x.MouseButton1Click:Connect(function()
	toggleGUI()
	print("Clicked X")
end)

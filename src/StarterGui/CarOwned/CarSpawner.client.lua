--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local carSpawnerEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CarSpawnerEvent")

local carSpawnerButton = ReplicatedStorage.GuiAssets:WaitForChild("CarSpawner")
local gui = script.Parent
local main = gui.Frame.Frame.Main 
local scrollingFrame = main.ScrollingFrame

local Functions = {}
--//Private functions

local function createNewButton(index: number, car: table)
    local newButton = carSpawnerButton:Clone()
    
    if car then
        --TO CHANGE
        local textButton = Instance.new("TextButton")
        textButton.Size = UDim2.new(1, 0, 1, 0)
        textButton.BackgroundTransparency = 1
        textButton.Text = car.Name
        textButton.Parent = newButton

        textButton.MouseButton1Click:Connect(function()
            carSpawnerEvent:FireServer("RespawnCar", index)
        end)
    end

    newButton.Parent = scrollingFrame
end

local function getPlayerCars(cars: table)
    --clear
    scrollingFrame.Frame:ClearAllChildren()

    --get player cars from server and set canvas size
    local canvasSize = math.ceil(#cars/3)
    local slots = canvasSize * 3
    local gridSize = UDim2.new(.329, 0, (.81+((.81/3)*canvasSize)+0.009*3*canvasSize), 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, canvasSize, 0)

    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellPadding = UDim2.new(.006, 0, 0, 5) --mam to gdzies
    gridLayout.CellSize = UDim2.new(.329, 0, 0.288/canvasSize, 0)

    for i=1,1,slots do
        --create new button and if there is cars[i] then add car to it
        createNewButton(i, cars[i])
    end
end

--//Runner

carSpawnerEvent.OnServerEvent:Connect(getPlayerCars)


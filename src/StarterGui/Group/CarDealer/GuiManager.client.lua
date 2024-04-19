--!nocheck
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Notificator = require(ReplicatedStorage.Modules:WaitForChild("Notificator"))
local Events = ReplicatedStorage:WaitForChild("Functions")
local VehicleFunction = Events:WaitForChild("VehicleFunction")
local Cars = ReplicatedStorage:WaitForChild("Cars")

local Player = game.Players.LocalPlayer

local TabFrame = ReplicatedStorage.GuiAssets.Tab:Clone()
local CarButton = ReplicatedStorage.GuiAssets.CarButton
local Main = script.Parent.MainFrame
local Nav = Main.NavBar
local ShowableFrame = Nav.ShowableFrame
local Holder = ShowableFrame.Holder

local maxTabs = 1
local tab = 1
local currentVehicle = nil

--//Private functions
local function change_page(page)
	local position = (page - 1) * - 1

	local tweenInfo = TweenInfo.new(
		0.5, -- Duration (adjust as needed)
		Enum.EasingStyle.Quad, -- Easing style (adjust as needed)
		Enum.EasingDirection.Out -- Easing direction (adjust as needed)
	)

	local targetProperties = {
		Position = UDim2.new(position, 0)
	}

	local tween = TweenService:Create(Holder, tweenInfo, targetProperties)
	tween:Play()
end

local function slider(tabs)
	if 0 < tab + tabs and tab + tabs <= maxTabs then
		if Holder:FindFirstChild("Tab" .. tab + tabs) then
			tab = tab + tabs
			print(tab)
			change_page(tab)
		end
	end
end

local function showVehicle(vehicle: Model)
	if currentVehicle then currentVehicle:Destroy() end
	
	local cf = CFrame.new(500, 500, 500) --where teleport car clone to
	
	currentVehicle = vehicle:Clone()
	currentVehicle:PivotTo(cf)
	currentVehicle.Parent = game.Workspace
	
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	game.Workspace.CurrentCamera.CFrame = cf * CFrame.new(0, 0, 20)
	
	Main.CarInfo.Price.Text = vehicle:FindFirstChild("price").Value
	
	local owned = VehicleFunction:InvokeServer("CheckOwned", currentVehicle)

	if owned then
		Main.CarInfo.TextButton.Active = false
		Main.CarInfo.TextButton.BackgroundColor3 = Color3.new(0.329412, 0.329412, 0.329412)
	else
		Main.CarInfo.TextButton.BackgroundColor3 = Color3.fromRGB(141, 84, 233)
		Main.CarInfo.TextButton.Active = true
	end
end

local function close()
	if currentVehicle then currentVehicle:Destroy() end
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	script.Parent.Enabled = false
end

local function init()
	local Vehicles = 0
	local newTab = TabFrame:Clone() --> TODO: TUTAJ CAMEL CASE A WSZEDZIE PASCAL CASE XD
	newTab.Name = "Tab" .. maxTabs
	newTab.Parent = Holder
	
	for _, Vehicle in ipairs(Cars:GetChildren()) do
		if Vehicle:FindFirstChild("price") then
			showVehicle(Vehicle) --show the first vehicle on init that has price
			break
		end
	end
	
	--create buttons
	for _, Vehicle in ipairs(game.ReplicatedStorage.Cars:GetChildren()) do
		if Vehicle:FindFirstChild("price") then
			local Button = CarButton:Clone()
			Button.Name = Vehicle.Name
			Button.Position = UDim2.new(Vehicles * .1925 + (Vehicles * .01), 0, 0, 0)
			Button.Price.Text = Vehicle.price.Value
			Button.CarName.Text = Vehicle.Name
			
			local Image = Vehicle:FindFirstChild("Image")
			if Image then
				Button.ImageLabel.Image = Image.Value
			end
			
			Button.TextButton.MouseButton1Click:Connect(function()
				showVehicle(Vehicle)
			end)
			
			Button.Parent = Holder:FindFirstChild("Tab" .. maxTabs)
			
			Vehicles += 1
			if Vehicles >= 5 then
				maxTabs = maxTabs + 1
				Vehicles = 0
				
				local Tab = TabFrame:Clone()
				Tab.Name = "Tab" .. maxTabs
				Tab.Position = UDim2.new(maxTabs-1, 0, 0, 0)
				Tab.Parent = Holder
			end
		end
	end	
end

--//Runner

Nav.Left.MouseButton1Click:Connect(function()
	slider(-1)
end)

Nav.Right.MouseButton1Click:Connect(function()
	slider(1)
end)

Nav.Close.MouseButton1Click:Connect(function()
	close()
end)

Main.CarInfo.TextButton.MouseButton1Click:Connect(function()
	local purchased = VehicleFunction:InvokeServer("Buy", Cars:FindFirstChild(currentVehicle.Name))

	if purchased then
		close()
		Notificator(Player.PlayerGui):notify("success", `Zakup {currentVehicle.Name} udal sie pomyslnie`, 3)
	end
end)

--//Runner

ReplicatedStorage.Events.UIStatus.OnClientEvent:Connect(function(ScreenGui, Frame, status)
	if ScreenGui == script.Parent and status == true then
		init()
	end
end)
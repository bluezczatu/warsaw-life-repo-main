local VehicleManagment = require(script.Parent)
local EconomyHandler = require(game.ServerScriptService.EconomyHandler)

local Functions = {}

local VehicleFunction = Instance.new("RemoteFunction")
VehicleFunction.Name = "VehicleFunction"
VehicleFunction.Parent = game.ReplicatedStorage.Functions

--//Private functions

local function playerAdded(Player: Player)
	VehicleManagment:PlayerAdded(Player)
end

local function playerRemoving(Player: Player)
	VehicleManagment:PlayerRemoved(Player)
end

local function onServerInvoke(Player: Player, signalType: string, info: any)
	local func = Functions[signalType]
	
	if func then
		return func(Player, info)
	end
	
	return nil
end

--//Public functions

Functions["Buy"] = function(Player: Player, Car: Model)
	local toReturn = false

	local success, err = pcall(function()
		local Price = Car:FindFirstChild("price").Value
		local Money = EconomyHandler[Player.Name].Cash
		
		if tonumber(Money) >= Price then

			VehicleManagment:BuyCar(Player, Car.Name)
			Money = tonumber(Money) - Price
			toReturn = true
		end
	end)

	warn(success, err)
	return toReturn
end

Functions["CheckOwned"] = function(Player: Player, Car: Model)
	local Cars = VehicleManagment:GetPlayerCars(Player)
	local Car = table.find(Cars, Car)
	
	if Car then
		return true
	end
	
	return false
end

--//Runner

VehicleFunction.OnServerInvoke = onServerInvoke
game.Players.PlayerAdded:Connect(playerAdded)
game.Players.PlayerRemoving:Connect(playerRemoving)
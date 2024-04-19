--!strict
local VehicleManagment = {}
local api = require(script:WaitForChild("api"))
local Cars = {}

--//Public functions

function VehicleManagment:PlayerAdded(Player: Player)
	local PlayerVehicles = api:GetPlayerVehicles(Player)
	
	if PlayerVehicles then
		Cars[Player] = PlayerVehicles
		return PlayerVehicles
	else
		Cars[Player] = {}
		return Cars[Player]
	end
end

function VehicleManagment:BuyCar(Player: Player, car)
	if Player then
		local data = {}
		data.vehicledata = {}

		data.vehicledata["model"] = car
		data.vehicledata["type"] = "car"
		data.vehicledata["owner"] = tostring(Player.UserId)
		
		if data then
			
			local status = api:create_vehicle(data)
			if status then
				table.insert(Cars[Player], data)
			end

			return status
		end
		
		return error("data is missing")
	end
	
	return error("Player is missing")
end

function VehicleManagment:GetPlayerCars(Player: Player)
	return Cars[Player]
end

function VehicleManagment:PlayerRemoved(Player: Player)
	Cars[Player] = nil
end

VehicleManagment.wanted = function()
	return api:GetWantedVehicles()
end

--//Runner

return VehicleManagment
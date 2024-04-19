local api = {}
local HttpService = game:GetService("HttpService")
local Authorization = "MTA3NjgzODUxMjMxNTMzNDY1Ng==.7u0mE23Fu0.Nzk2MDc5MjUzODQ5NzY3OTg3"

--//Public functions

function api:GetPlayerVehicles(Player: Player)
	local Headers = {["Authorization"] = Authorization, ["RobloxId"] = tostring(Player.UserId)}
	local res = HttpService:GetAsync("https://api.megarp.pl/v1/vehicles/get_owned_vehicles", true, Headers)
	local Decoded = HttpService:JSONDecode(res)
	
	if Decoded.success then
		return Decoded
	end
	
	return error("GetPlayerVehicles returned with success false")
end

function api:create_vehicle(data: table)
	local Headers = {["Authorization"] = Authorization}
	local res = HttpService:PostAsync("https://api.megarp.pl/v1/vehicles/create_vehicle", HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson, false, Headers)
	local Decoded = HttpService:JSONDecode(res)
	
	if Decoded.success then
		return Decoded
	end
	
	return error("create_vehicle returned with success false")
end

function api:GetAvailableVehicles(Player: Player)
	local Headers = {["Authorization"] = Authorization, ["RobloxId"] = tostring(Player.UserId)}
	local res = HttpService:GetAsync("https://api.megarp.pl/v1/vehicles/get_available_vehicles", true, Headers)
	local Decoded = HttpService:JSONDecode(res)

	if Decoded.success then
		return Decoded
	end

	return error("GetAvailableVehicles returned with success false")
end

function api:GetWantedVehicles()
	local Headers = {["Authorization"] = Authorization}
	local res = HttpService:GetAsync("https://api.megarp.pl/v1/vehicles/get_wanted_vehicles", true, Headers)
	local Decoded = HttpService:JSONDecode(res)

	if Decoded.success then
		return Decoded
	end

	return error("GetWantedVehicles returned with success false")
end

function api:update(data)
	local Headers = {["Authorization"] = Authorization, ["VehicleData"] = HttpService:JSONEncode(data)}
	local res = HttpService:GetAsync("https://api.megarp.pl/v1/vehicles/update_vehicle", true, Headers)
	local Decoded = HttpService:JSONDecode(res)

	if Decoded.success then
		return Decoded
	end

	return error("update returned with success false")
end

--//Runner
return api
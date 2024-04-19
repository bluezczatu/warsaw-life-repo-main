--PegasusLive
--script na live bany
local Pegasus = require(script.Parent)
local authkey = Pegasus.authkey

local Players = game:GetService("Players")

function check(player)
	local HttpService = game:GetService("HttpService")
	local url = "http://api-pegasus.hckrteam.com/v2/live"
	
	local requestHeaders = {
		['Authorization'] = authkey
	}

	local success, response = pcall(HttpService.RequestAsync, HttpService, {
		Url = url,
		Method = "GET",
		Headers = requestHeaders
	})

	if success then
		pcall(function()
		local api = HttpService:JSONDecode(response.Body)

		if api.success == true then
			if api.data.temporaryban ~= nil then
				for playerId, banReason in pairs(api.data.temporaryban) do
					pcall(function()
						game.Players:GetPlayerByUserId(playerId):kick(banReason)
					end)
				end
			end
			if api.data.permanentban ~= nil then
				for playerId, banReason in pairs(api.data.permanentban) do
					pcall(function()
						game.Players:GetPlayerByUserId(playerId):kick(banReason)
					end)
				end
			end
			if api.data.restart ~= nil then
				script.Enabled = false
				wait(5)
				script.Enabled = true
			end
		end
		
		end)
	else
		warn("Error fetching API data for player:", response)
	end
end
check()

while wait(5) do
	check()
end
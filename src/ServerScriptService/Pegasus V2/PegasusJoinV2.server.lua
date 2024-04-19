--PegasusJoin
--script na weryfikacje i bany
local whitelist = true --true = gracze nie zweryfikowani nie mogą dołączyć do gry, false = gracze nie zweryfikowani mogą dołączyć do gry
local Pegasus = require(script.Parent)
local authkey = Pegasus.authkey

local CollectionService = game.CollectionService

local Players = game:GetService("Players")
function onPlayerEntered(player)
	local HttpService = game:GetService("HttpService")
	local url = "https://api-pegasus.hckrteam.com/v2/join?user="..player.UserId
	
	local requestHeaders = {
		['Authorization'] = authkey
	}
	
	local success, response = pcall(HttpService.RequestAsync, HttpService, {
		Url = url,
		Method = "GET",
		Headers = requestHeaders
	})
	
	if success then
		local api = HttpService:JSONDecode(response.Body)
		if api.success == true then
			if api.data.roblox_ban ~= "0" then
				player:kick(api.data.roblox_ban)
			else
				--print(player.Name .." (" .. player.UserId .. ":" .. api.data.discord_id ..") has joined!")
				--print(player.UserId .. " has joined!")
				--print(api.data.discord_id .. " has joined!")
				--warn(api.data.roles)
				
			
				if api.data.roles then
					
					local Factions = ""
					
					if api.data.roles["PSP"] then
						Factions = Factions.."PSP "
						player:SetAttribute("PSP",api.data.roles["PSP"])
						--player:SetAttribute("Faction","PSP")
						CollectionService:AddTag(player, "Faction")		
						
					end
					if api.data.roles["OSP"] then
						Factions = Factions.."OSP "
						player:SetAttribute("OSP",api.data.roles["OSP"])
						--player:SetAttribute("Faction","OSP")
						CollectionService:AddTag(player, "Faction")

					end
					if api.data.roles["PR"] then
						Factions = Factions.."PR "
						player:SetAttribute("PR",api.data.roles["PR"])
						--player:SetAttribute("Faction","PR")
						CollectionService:AddTag(player, "Faction")

					end
					if api.data.roles["KPP"] then
						Factions = Factions.."KPP "
						player:SetAttribute("KPP",api.data.roles["KPP"])
						--player:SetAttribute("Faction","KPP")
						CollectionService:AddTag(player, "Faction")

					end
					
					--print(Factions)
					player:SetAttribute("Factions", Factions)
					print(player.Name .." (" .. player.UserId .. ":" .. api.data.discord_id ..") (".. Factions ..") has joined!")
				end

			end
		else
			if api.error == "unauthorized" then
				player:kick("Unauthorized Request. Check authkey!")
			else
				if whitelist == true and player.Name ~= "olgierdowo" then
					player:kick("Musisz się zweryfikować przed dołączeniem na grę!")
				end
			end
		end
	else
		warn("Error fetching API data for player:", response)
		player:kick("Wystąpił błąd podczas pobierania danych z API. Spróbuj ponownie później.")
	end
end

Players.PlayerAdded:Connect(function(player)
	onPlayerEntered(player)
end)
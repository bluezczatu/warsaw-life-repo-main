-- ModuleScript zapisany pod nazwą "PlayerVisibility"

local localplayer = game.Players.LocalPlayer

local PlayerVisibility = {}

local playersHidden = false
local whitelistedPlayers = {}

-- Pomocnicza funkcja do ukrywania postaci gracza
local function setCharacterVisibility(player, visible)
	if player == localplayer then return end
	warn("setCharacterVisibility: ", player.Name, visible)
	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if visible then
				
				local originalTransparency = child:GetAttribute("OriginalTransparency")
				if originalTransparency then
					child.Transparency = originalTransparency
					child:SetAttribute("OriginalTransparency", nil)
				end
				
				local originalAccessoryTransparency = child:GetAttribute("OriginalAccessoryTransparency")
				if originalAccessoryTransparency then
					child:FindFirstChild("Handle").Transparency = originalAccessoryTransparency
					child:SetAttribute("OriginalAccessoryTransparency", nil)
				end
				
			else
				-- Ustawiamy przezroczystość
				
				if child:GetAttribute("OriginalAccessoryTransparency") or child:GetAttribute("OriginalTransparency") then return end
				
				pcall(function()
					
					if child:IsA("Accessory") then
						--warn(child.Name)
						child:SetAttribute("OriginalAccessoryTransparency", child:FindFirstChild("Handle").Transparency)
						child:FindFirstChild("Handle").Transparency = 1
					end

					if child:IsA("BasePart") then
						child:SetAttribute("OriginalTransparency", child.Transparency)
						child.Transparency = 1
					end
					
				end)

			end
		end
	end
end

-- Funkcja ukrywająca wszystkich graczy
function PlayerVisibility.HideAllPlayers()
	playersHidden = true
	whitelistedPlayers = {}
	for _, player in pairs(game.Players:GetPlayers()) do
		setCharacterVisibility(player, false)
	end
end

-- Funkcja pokazująca wszystkich graczy
function PlayerVisibility.ShowAllPlayers()
	warn("ShowAllPlayers")
	playersHidden = false
	for _, player in pairs(game.Players:GetPlayers()) do
		setCharacterVisibility(player, true)
	end
end

-- Funkcja pokazująca tylko wybranych graczy z listy dozwolonych
function PlayerVisibility.ShowOnlyWhitelistedPlayers(playerList)
	warn("ShowOnlyWhitelistedPlayers: ", playerList)
	playersHidden = true
	-- Zbuduj zbiór dozwolonych graczy
	whitelistedPlayers = {}
	for _, player in pairs(playerList) do
		whitelistedPlayers[player.Name] = true
	end

	for _, player in pairs(game.Players:GetPlayers()) do
		if whitelistedPlayers[player.Name] then
			setCharacterVisibility(player, true)
		else
			setCharacterVisibility(player, false)
		end
	end
end

function PlayerVisibility.HideOnlyWhitelistedPlayers(playerList)
	warn("HideOnlyWhitelistedPlayers: ", playerList)
	playersHidden = true
	-- Zbuduj zbiór dozwolonych graczy
	whitelistedPlayers = {}
	for _, player in pairs(playerList) do
		whitelistedPlayers[player.Name] = true
	end

	for _, player in pairs(game.Players:GetPlayers()) do
		if whitelistedPlayers[player.Name] then
			setCharacterVisibility(player, false)
		else
			setCharacterVisibility(player, true)
		end
	end
end

function PlayerVisibility.CheckPlayersHidden()
	warn(playersHidden)
end

-- Nasłuchiwanie na nowych graczy
game.Players.PlayerAdded:Connect(function(player)
	warn("playersHidden:", playersHidden)
	player.CharacterAdded:Connect(function(character)
		if playersHidden == true then
			if whitelistedPlayers[player.Name] then
				setCharacterVisibility(player, true)
			else
				wait(1)
				warn("ukrywam typa lel")
				setCharacterVisibility(player, false)
			end
		else
			setCharacterVisibility(player, true)
		end
	end)
end)




return PlayerVisibility
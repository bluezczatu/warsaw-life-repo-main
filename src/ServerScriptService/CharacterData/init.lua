--//Variables
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ProfileService = require(ServerStorage.ProfileService)
local ReplicaService = require(ServerScriptService.ReplicaService)
local Template = require(script.Template)

local CharacterProfileStore = ProfileService.GetProfileStore("CharacterProfileStore2", Template)

local Profiles = {}
local DataReplicas = {}

local DataManager = {}

local Managers = {}
for _,v in script.Managers:GetChildren() do
	table.insert(Managers, require(v))
end

--//Functions
function DataManager:OnPlayerAdded(player)
	local PlayerProfile = CharacterProfileStore:LoadProfileAsync("Data2"..player.UserId,"ForceLoad")
	if PlayerProfile ~= nil then
		PlayerProfile:ListenToRelease(function()
			Profiles[player] = nil
			DataReplicas[player]:Destroy()
			DataReplicas[player] = nil
		end)
		if player:IsDescendantOf(Players) then
			Profiles[player] = PlayerProfile
			local DataReplica = ReplicaService.NewReplica({
				ClassToken = ReplicaService.NewClassToken("DataToken_"..player.UserId),
				Replication = player,
				Data = PlayerProfile.Data
			})
			DataReplicas[player] = DataReplica
			--Load character position
			local Character = player.Character or player.CharacterAdded:wait()
			if PlayerProfile.Data.Position then
				Character:WaitForChild("HumanoidRootPart").Position = Vector3.new(table.unpack(PlayerProfile.Data.Position))
			end
			--//Set HP
			local Humanoid = Character:WaitForChild("Humanoid")
			Humanoid.Health = PlayerProfile.Data.HP

			--//Saturation and Thirst management
			for _,Manager in Managers do
				task.spawn(Manager, {
					player = player,
					GetData = function()
						return DataManager:GetData(player)
					end,
					SetData = function(key, value)
						return DataManager:SetData(player, key, value)
					end,
				})
			end
		else
			PlayerProfile:Release()
		end
	else
		player:Kick("Unable to load your data. Please rejoin.")
	end
end

function DataManager:OnPlayerRemoved(player)
	local PlayerProfile = Profiles[player]
	local Character = player.Character
	--Save character data
	if Character and Character.Humanoid.Health > 0 then
		PlayerProfile.Data.HP = Character.Humanoid.Health
		local X, Y, Z = Character.HumanoidRootPart.Position.X, Character.HumanoidRootPart.Position.Y, Character.HumanoidRootPart.Position.Z
		PlayerProfile.Data.Position = {X,Y,Z}
	else
		PlayerProfile.Data.HP = 100
		PlayerProfile.Data.Position = nil
	end
	--Save data
	if PlayerProfile then
		PlayerProfile:Release()
	end
end

function DataManager:GetData(player)
	local PlayerProfile = Profiles[player]

	if PlayerProfile then
		return PlayerProfile
	end
end

function DataManager:GetCharacterInfoData(Player: Player)
	local info = nil
	local success, err = pcall(function()
		info = Profiles[Player]["CharacterInfo"]
	end)

	if success then 
		return info
	elseif err then
		return error(err)
	end
end

function DataManager:SetData(player, key: string, value: any)
	local PlayerProfile = self:GetData(player)
	local DataReplica = DataReplicas[player]
	if PlayerProfile and DataReplica then
		PlayerProfile.Data[key] = value
		DataReplica:SetValue(key, value)
	end
end

--//Runners

return DataManager
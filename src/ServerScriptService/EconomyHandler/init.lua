--!nocheck
local Economy = {}
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileService = require(ServerStorage.ProfileService)
local ReplicaService = require(ServerScriptService.ReplicaService)

local Template = require(script:WaitForChild("Template"))
local ProfileStore = ProfileService.GetProfileStore("EconomyData1", Template)

local DataReplicas = {}
local Profiles = {}

--//Private functions

--//Public functions

function Economy:MakePlayerProfile(Player: Player)
	local PlayerProfile = ProfileStore:LoadProfileAsync("Data1"..Player.UserId,"ForceLoad")
	if PlayerProfile ~= nil then
		PlayerProfile:ListenToRelease(function()
			Economy[Player] = nil
			DataReplicas[Player]:Destroy()
			DataReplicas[Player] = nil
		end)
		if Player:IsDescendantOf(game.Players) then
			Economy[Player.Name] = PlayerProfile.Data
			Profiles[Player] = PlayerProfile
			
			local DataReplica = ReplicaService.NewReplica({
				ClassToken = ReplicaService.NewClassToken("EconomyToken_"..Player.UserId),
				Replication = Player,
				Data = PlayerProfile.Data
			})
			DataReplicas[Player] = DataReplica
			
			setmetatable(Economy[Player.Name], {__newindex=function(t, i, v )
				Profiles[Player].Data[i] = v
				DataReplica:SetValue({i}, v)
			end,
			__index = function(t, i)
				return Profiles[Player].Data[i]
			end,
			__tostring=function()
				return tostring(Profiles[Player].Data)
			end})
			
			return PlayerProfile
		end
	end
	return nil
end


function Economy:GetMoney(Player: Player, moneyType: string)
	local toReturn

	local success, err = pcall(function()
		toReturn = Profiles[Player].Data[moneyType]
	end)

	if success then return toReturn end
	if err then error(err) end
end

function Economy:SetMoney(Player: Player, moneyType: string, amount: number)
	local success, err = pcall(function()
		Profiles[Player].Data[moneyType] = amount
	end)	

	if err then error(err) end
end

function Economy:AddMoney(Player: Player, moneyType: string, amount: number)
	local success, err = pcall(function()
		local Data = Profiles[Player].Data

		Data[moneyType] = Data[moneyType] + amount
	end)

	if err then return error(err) end
end

function Economy:TransferMoney(Player: Player, Player2Id: number, moneyType: string, amount: number)
	local response = nil
	warn(Player2Id)
	--local success, err = pcall(function()
	warn(Player2Id)
	if not tonumber(Player2Id) then response = nil return nil end
	local Player2 = game.Players:GetPlayerByUserId(tonumber(Player2Id))
	local P1Data = Profiles[Player].Data

	if not Profiles[Player2] then response = nil return nil end

	local P2Data = Profiles[Player2].Data
	amount = math.abs(tonumber(amount))
	warn(amount)
	if P1Data[moneyType] - amount <= 0 then warn("zle") response = false return end
	P1Data[moneyType] = P1Data[moneyType] - amount
	P2Data[moneyType] = P2Data[moneyType] + amount
	response = true
	--end)

	--if err then return error(err) end
	return response
end

function Economy:DepositMoney(Player: Player, amount: number)
	local response = nil
	local success, err = pcall(function()

		amount = math.abs(amount)
		local moneyType1 = "Cash"-- portfle
		local moneyType2 = "Bank"-- bank

		local Data = Profiles[Player].Data
		if Data[moneyType1] - amount <= 0 then warn("zle") response = false return false end

		Data[moneyType1] = Data[moneyType1] - amount
		Data[moneyType2] = Data[moneyType2] + amount
		response = true
	end)
	warn(success, err)
	return response
end

function Economy:WithdrawMoney(Player: Player, amount: number)
	local response = nil
	local success, err = pcall(function()
		amount = math.abs(amount)
		local moneyType1 = "Bank"
		local moneyType2 = "Cash"

		local Data = Profiles[Player].Data
		warn(Data[moneyType1] - amount)
		if Data[moneyType1] - amount <= 0 then warn("zle") response = false return false end

		Data[moneyType1] = Data[moneyType1] - amount
		Data[moneyType2] = Data[moneyType2] + amount
		response = true
	end)
	warn(success, err)
	return response
end

function Economy:exit(Player: Player)
	local PlayerProfile = Profiles[Player]
	if PlayerProfile then
		PlayerProfile:Release()
	end
end

Economy.Data = Profiles

--//Runner
return Economy

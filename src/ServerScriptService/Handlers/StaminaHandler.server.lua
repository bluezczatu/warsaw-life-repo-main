--ROBIONE NA ODJEB SIE BO MI SIE NIE CHCE (lagi)

--//Variables <- PO CO TO? XD
local ReplicaService = require(game.ServerScriptService.ReplicaService)

local StaminaEvent = Instance.new("RemoteEvent")
StaminaEvent.Name = "StaminaEvent"
StaminaEvent.Parent = game.ReplicatedStorage

local Walk = 16 --Walk speed <- CZEMU TUTAJ UZYWASZ PASCAL CASE A POZNIEJ CAMELCASE??
local Run = 30 --Run speed
local RunLoopWait = 0.0025 --How much wait to use stamina while running  -- A TO NIE POWINNO NAZYWAC SIE TRESHOLD?

local StaminaList = {}
local Loops = {}

--//Private functions <- PRIVATE FUNKCJE MAJA '_' W PREFIX! ROBI SIE TAK PO TO BY CI AUTOCOMPLETE NIE SUGEROWAL TEGO KODU...
local function Loop(player)
	while player.Character and StaminaList[player] and StaminaList[player].Data.Stamina >= 1 and Loops[player] do
		player.Character.Humanoid.WalkSpeed = Run
		StaminaList[player]:SetValue("Stamina", StaminaList[player].Data.Stamina-1)
		task.wait(RunLoopWait)
	end	
	
	if player.Character then
		player.Character.Humanoid.WalkSpeed = Walk
	end
	
	Loops[player] = nil
end

local function onServerEvent(player, action)
	local stamina = StaminaList[player].Data.Stamina
	
	if action == "Jump" then
		if stamina >= 20 then
			StaminaList[player]:SetValue("Stamina", StaminaList[player].Data.Stamina-20)
		end
	elseif action == "RunStart" then
		Loops[player] = Loop
		Loops[player](player)
	elseif action == "RunEnd" then
		Loops[player] = nil
	end
end

local function playerAdded(player)
	local DataReplica = ReplicaService.NewReplica({
		ClassToken = ReplicaService.NewClassToken("Stamina_"..player.UserId),
		Replication = player,
		Data = {Stamina = 100}
	})
	StaminaList[player] = DataReplica
	player.CharacterAdded:Connect(function(character)
		StaminaList[player]:SetValue("Stamina", 100)
		while character and StaminaList[player] do
			if StaminaList[player] and StaminaList[player].Data.Stamina < 100 then
				StaminaList[player]:SetValue("Stamina", StaminaList[player].Data.Stamina+1)
			end
			
			if StaminaList[player].Data.Stamina < 20 then
				character.Humanoid.JumpHeight = 0
			else 
				character.Humanoid.JumpHeight = 7.2
			end
			task.wait(.33)
		end
	end)
end

local function playerRemoving(player)
	StaminaList[player]:Destroy()
	StaminaList[player] = nil
end

--//Runners
game.Players.PlayerAdded:Connect(playerAdded)
game.Players.PlayerRemoving:Connect(playerRemoving)

StaminaEvent.OnServerEvent:Connect(onServerEvent)
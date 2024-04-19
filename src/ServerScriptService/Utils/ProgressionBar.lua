type ProgressionBar = {
	length: number,
	callback: (success: boolean) -> (),
	player: Player,
	active: boolean,
	text: string,

	new: (player: Player, text: string, length: number, callback: (success: boolean) -> ()) -> ProgressionBar,
	Stop: (self: ProgressionBar, success: boolean) -> ()
} --> TAKI FUN FUCT DAWID MOZESZ POPROSTU ZROBIC: type ProgressionBar = typeof(setmetatable({}, ProgressionBar)) lub typeof(ProgressionBar.new).
--> bo to ci da type errory xd. ale shit typing skills generalnie regards najwiekszy gigaszef olgierd


local ProgressionBar = {} :: ProgressionBar
ProgressionBar.__index = ProgressionBar

local activeProgressionBars = {} :: {ProgressionBar}

function ProgressionBar.new(player: Player, text: string, length: number, callback: (success: boolean) -> ())
	local self = setmetatable({}, ProgressionBar)
	
	self.text = text
	self.player = player
	self.length = length	
	self.callback = callback
	self.active = true

	if activeProgressionBars[player] then
		self:Stop()
		return self
	end

	task.spawn(function()
		wait(length)
		if self.active then
			print(1)
			self.active = false
			activeProgressionBars[self.player] = nil
			self.callback(true)
		end
	end)
	
	activeProgressionBars[player] = self
	
	game.ReplicatedStorage.Events.ProgressBar:FireClient(self.player, "start", text, length)

	return self
end

function ProgressionBar:Stop()
	if self.active then 
		print(2)
		self.active = false
		activeProgressionBars[self.player] = nil
		game.ReplicatedStorage.Events.ProgressBar:FireClient(self.player, "stop")
		self.callback(false)
	end
end


game.ReplicatedStorage.Events.ProgressBar.OnServerEvent:Connect(function(player)
	if activeProgressionBars[player] then
		activeProgressionBars[player]:Stop()
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterRemoving:Connect(function()
		if activeProgressionBars[player] then
			activeProgressionBars[player]:Stop()
		end
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	if activeProgressionBars[player] then
		activeProgressionBars[player]:Stop()
	end
end)

return ProgressionBar
local Events = game.ReplicatedStorage:WaitForChild("Events")

local UIScreen = script.ProgressBar

local UI = UIScreen.Frame.Frame.ProgressBar

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local _startTick = tick()
local _length = 0

type ProgressBar = {
	callback: (success: boolean) -> (),
	_id: number?,

	Start: (self: ProgressBar, text: string, length: number, callback: (success: boolean) -> ()?) -> (),
	Stop: (self: ProgressBar) -> (),
}


local module = {} :: ProgressBar

function module:Start(text, length, callback)
	self.callback = callback
	local id = math.random(0,1000000000)
	self._id = id

	_length = length
	_startTick = tick()
	UI.TextLabel.Text = text
	UIScreen.Parent = PlayerGui

	task.spawn(function()
		wait(length)
		if self._id == id then
			if self.callback then
				self.callback(true)
			end
			self:Stop()
		end
	end)
end

function module:Stop()
	UIScreen.Parent = nil
	self._id = nil

	if self.callback then
		self.callback(false)
	end
	Events.ProgressBar:FireServer()

	self.callback = nil
end

Events:WaitForChild("ProgressBar").OnClientEvent:Connect(function(typ: string, text: string, length: number)
	if typ == "start" then
		module:Start(text, length)
	elseif typ == "stop" then
		module:Stop()
	end
end)

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
	UI.Bar.Bar.Size = UDim2.fromScale((tick() - _startTick) / _length,1)
end)

UI:WaitForChild("Cancel").MouseButton1Click:Connect(function()
	module:Stop()
end)

return module
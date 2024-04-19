local ReplicatedStorage = game.ReplicatedStorage
local UIStatusEvent = ReplicatedStorage.Events.UIStatus

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui

UIStatusEvent.OnClientEvent:Connect(function(ScreenGui, Frame, status)
	
	if ScreenGui == nil then return end
	ScreenGui.Enabled = status
	if Frame == nil then return end
	Frame.Visible = status
	
	
end)
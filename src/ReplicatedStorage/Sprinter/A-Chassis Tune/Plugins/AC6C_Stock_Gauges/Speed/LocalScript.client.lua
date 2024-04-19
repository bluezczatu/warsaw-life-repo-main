local playergui = game.Players.LocalPlayer.PlayerGui


local SpeedValue = playergui.ScreenCar.Speed


script.Parent:GetPropertyChangedSignal("Text"):Connect(function(text)
	text = script.Parent.Text
	warn(string.split(text," KM")[1])
	SpeedValue.Value = tonumber(string.split(text," KM")[1])
end)
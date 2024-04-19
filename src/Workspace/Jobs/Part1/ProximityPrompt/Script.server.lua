local ProgressionBar = require(game.ServerScriptService.Utils.ProgressionBar)

script.Parent.Triggered:Connect(function(player)
	
	ProgressionBar.new(player, "Nie wiem XD", 5, function(success)

print(success)
	end)

end)
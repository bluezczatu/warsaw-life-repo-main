local DevourableObject = require(game.ServerScriptService.CharacterData.DevourableObject)

object = DevourableObject.new(script.Parent, "Thirst", 20)

script.Parent.Activated:Connect(function()
	object:devour()
end)
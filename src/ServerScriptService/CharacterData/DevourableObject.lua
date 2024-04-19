local object = {}

--//Variables
local CharacterData = require(script.Parent)

--//Private functions

local function GetNewPlayer(parent)
	local player = game.Players:GetPlayerFromCharacter(parent)
	if player then
		return player
	end
	
	return nil
end

--//Public functions

--devour object and add stats
function object:devour(overwriteAddition)
	if self.tool and typeof(self.tool) == "Instance" then self.tool:Destroy() end
	if not self.player then self = nil end
	
	--overwrite devour addition to stats
	if overwriteAddition then
		self.statsAddition = overwriteAddition
	end
	
	--check if statsAddition is number	
	if typeof(self.statsAddition) ~= "number"  then self = nil error("statsAddition is not a number value") end
	
	--get data
	local playerData = CharacterData:GetData(self.player)
	local data = playerData.Data[self.toolType]

	--error if player data is non existant
	if not data then self = nil error("Cannot find player data, did you set the correct toolType?") end
	
	--overwite data with final data
	if data+self.statsAddition > 100 then
		data = 100
	elseif data+self.statsAddition < 0 then
		data = 0
	else
		data = data+self.statsAddition
	end
	
	--overwrite playerData data with data
	CharacterData:SetData(self.player, self.toolType, data)
	self = nil
end

function object.new(tool, toolType, statsAddition)
	local self = setmetatable(object, {__index={}})

	if tool == nil then 
		self = nil
		error("Tool variable is nil") 
	end
	
	self.tool = tool
	self.toolType = toolType --set tool type thirst, saturation, etc.
	self.statsAddition = statsAddition --how much add to data on devour
	
	tool.AncestryChanged:Connect(function(child, parent) --on parent change
		self.player = GetNewPlayer(parent)
	end)
	
	return self
end

return object

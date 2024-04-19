local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local serverTagsDirectory = ServerScriptService.Tags

type LocalProperties = {}

local ServerTags = {}

type Janitors = { [Instance]: { [string]: () -> () } }

local function loadTagDefinitions()
	local definitions = {}

	for _, tagDefinition: ModuleScript in serverTagsDirectory:GetChildren() do
		local requiredDefinition: TagTypes.TagDefinition = require(tagDefinition)
		table.insert(definitions, requiredDefinition)
	end

	return definitions
end

local function getTagsList(tagDefinitions): { string }
	local tagsList = {}

	for _, tagDefinition in tagDefinitions do
		if not tagsList[tagDefinition.tagName] then
			table.insert(tagsList, tagDefinition.tagName)
		end
	end

	return tagsList
end

local function cleanupInstanceJanitorForTag(oldJanitors: Janitors, instance: Instance, tagName: string): Janitors
	if not oldJanitors[instance] then
		return oldJanitors
	end

	local janitors = table.clone(oldJanitors)
	janitors[instance] = table.clone(janitors[instance])

	if janitors[instance][tagName] then
		janitors[instance][tagName]()
		janitors[instance][tagName] = nil
	end

	return janitors
end

local function createInstanceJanitorForTag(
	oldJanitors: Janitors,
	cleanupFunction: () -> (),
	instance: Instance,
	tagName: string
): Janitors
	local janitors = table.clone(oldJanitors)

	if not janitors[instance] then
		janitors[instance] = {}
	else
		janitors[instance] = table.clone(janitors[instance])
	end

	if not janitors[instance][tagName] then
		janitors[instance][tagName] = cleanupFunction
	end

	return janitors
end

local function getDefinitionFromTagName(
	tagDefinitions,
	tagName: string
)
	for _, tagDefinition in tagDefinitions do
		if tagDefinition.tagName == tagName then
			return tagDefinition
		end
	end

	return
end

function ServerTags:OnStart()
	local janitors: Janitors = {}
	local tagDefinitions = loadTagDefinitions()
	local tagsList = getTagsList(tagDefinitions)

	for _, tagName in tagsList do
		local definition = getDefinitionFromTagName(tagDefinitions, tagName)

		for _, taggedInstance: Instance in CollectionService:GetTagged(tagName) do
       local cleanupFunction = definition.onInstanceAdded(taggedInstance)

			local newJanitors = createInstanceJanitorForTag(janitors, cleanupFunction, taggedInstance, tagName)
			janitors = newJanitors
		end

		CollectionService:GetInstanceAddedSignal(tagName):Connect(function(taggedInstance: Instance)
			local cleanupFunction = definition.onInstanceAdded(taggedInstance)

			local newJanitors = createInstanceJanitorForTag(janitors, cleanupFunction, taggedInstance, tagName)
			janitors = newJanitors
		end)

		CollectionService:GetInstanceRemovedSignal(tagName):Connect(function(taggedInstance: Instance)
			janitors = cleanupInstanceJanitorForTag(janitors, taggedInstance, tagName)
		end)
	end
end

return ServerTags
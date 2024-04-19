local player = game.Players.LocalPlayer
local ReplicatedStorage = game.ReplicatedStorage

local CircleRemoveButton = ReplicatedStorage.Events.CircleRemoveButton
local CircleAddButton = ReplicatedStorage.Events.CircleAddButton

local module = {}

module.exampleData = {
	[1] = {
		["Image"] = "rbxassetid://15402184134",
		["Name"] = "Dokumenty",
		["Frame"] = nil,
		["RemoteEvent"] = ReplicatedStorage.Events.ShowDocumentServer,
	},
	[2] = {
		["Image"] = "rbxassetid://15403997401",
		["Name"] = "Radio",
		["Frame"] = nil,
	},
	[3] = {
		["Image"] = "rbxassetid://15404364070",
		["Name"] = "Animacje",
		["Frame"] = nil,
	},
	[4] = {
		["Image"] = "rbxassetid://15404273040",
		["Name"] = "Phone",
		["Frame"] = nil,
	},
	[5] = {
		["Image"] = "rbxassetid://15404273259",
		["Name"] = "Tablet",
		["Frame"] = player.PlayerGui.MegaRP.Frame.Frame.Tablet,
	}
}

module.Data = {
	[1] = {
		["Image"] = "rbxassetid://15402184134",
		["Name"] = "Dokumenty",
		["Frame"] = nil,
		["RemoteEvent"] = ReplicatedStorage.Events.ShowDocumentServer,
	},
	[2] = {
		["Image"] = "rbxassetid://15404364070",
		["Name"] = "Animacje",
		["Frame"] = nil,
	},
	[3] = {
		["Image"] = "rbxassetid://15404273040",
		["Name"] = "Phone",
		["Frame"] = nil,
	}
}

module.getData = function()
	--warn(module.Data)
	return module.Data
end

module.addButton = function(buttonName)
	for ibuttonData, vbuttonData in module.exampleData do
		--warn(vbuttonData.Name)
		if vbuttonData.Name == buttonName then
			table.insert(module.Data, vbuttonData)
			--warn(module.Data)
			return vbuttonData
		end
	end
end

module.removeButton = function(buttonName)
	for ibuttonData, vbuttonData in module.Data do
		--warn(vbuttonData.Name)
		if vbuttonData.Name == buttonName then
			table.remove(module.Data, ibuttonData)
			--warn(module.Data)
			return vbuttonData
		end
	end
end



module.start = function()
	--local buttonData = {
	--	["Image"] = "rbxassetid://15404273259",
	--	["Name"] = "Tablet",
	--	["Frame"] = player.PlayerGui.MegaRP.Frame.Frame.Tablet,
	--}
	
	--for ibuttonData, vbuttonData in module.Data do
		
	--	warn(vbuttonData.Name)
		
	--	if vbuttonData.Name == buttonData.Name then
	--		table.remove(module.Data, ibuttonData)
	--		warn(module.Data)
	--		return vbuttonData
	--	end
		
	--end
	
	CircleAddButton.OnClientEvent:Connect(function(buttonName)
		warn(buttonName)
		module.addButton(buttonName)
	end)
	CircleRemoveButton.OnClientEvent:Connect(function(buttonName)
		warn(buttonName)
		module.removeButton(buttonName)
	end)
	
end


return module




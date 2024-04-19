local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleRemoveButton = ReplicatedStorage.Events.CircleRemoveButton
local CircleAddButton = ReplicatedStorage.Events.CircleAddButton

return {
	tagName = "FactionDuty",
	--- Zwraca instancje do janitora
	onInstanceAdded = function(instance: Instance): () -> ()
		local FactionDuty = instance:GetAttribute("FactionDuty")

		if FactionDuty:match("OSP") then
			CircleAddButton:FireClient(instance, "Radio")
			CircleAddButton:FireClient(instance, "Tablet")
		end

		return function()
			CircleRemoveButton:FireClient(instance, "Radio")
			CircleRemoveButton:FireClient(instance, "Tablet")
		end
	end,
}
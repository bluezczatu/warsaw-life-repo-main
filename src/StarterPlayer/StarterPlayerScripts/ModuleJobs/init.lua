local module = {}


local joblist = {
	["Glovo"] = {
		["ProximityPart"] = game.Workspace.Jobs:WaitForChild("Part2"),
		["test2"] = game.Workspace.Jobs.Part2,
	},
	["Glovo2"] = {
		["ProximityPart"] = game.Workspace.Jobs:WaitForChild("Part1"),
		["test2"] = game.Workspace.TextLabel,
	},
	
}


function module.Start()
	
	--make loop for jobs and connect proximity propmts
	for jobname,jobdata in pairs(joblist) do
		local proximitypart = jobdata["ProximityPart"]
		
		if proximitypart then
			
			local prompt = proximitypart
			
			prompt.ProximityPrompt.Triggered:Connect(function(player)
				print("Player "..player.Name.." wants to join "..jobname)
				
				--module.JoinJob(player,jobname)
				
			end)
			
		end
		
	end


	return
end





return module

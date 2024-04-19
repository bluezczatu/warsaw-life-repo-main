local function check()
	local origin = script.Parent.Position 
	local dir = script.Parent.CFrame.LookVector 
	local distance = 10 
	
	local results = workspace:Raycast(origin, dir * distance)
	
	if results then 
		local hit = results.Instance 
		print(hit.Name)
	else 
		print('none')
	end
end

while task.wait(2) do 
	check()
end
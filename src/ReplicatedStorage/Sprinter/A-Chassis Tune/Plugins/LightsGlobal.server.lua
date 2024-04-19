--a light modification that enables light by pressing f
--do not delete LightsGlobal, LightsRemoteEvent, LightsClient
--those are essential for this to actually work

wait()
local remote = script.Parent:WaitForChild("LightsRemoteEvent")
remote.OnServerEvent:connect(function(p,b,l,lR)
	local s = false
	if l[1]:FindFirstChild("SpotLight") then
		s = false
	else
		s = true
	end
	if s then
		for i,x in pairs(l) do
			local spotLight = Instance.new("SpotLight")
			spotLight.Parent = x
			spotLight.Face = "Front"
			spotLight.Range = 48
			spotLight.Name = "SpotLight"
		local a0 = Instance.new("Attachment")
		a0.Parent = x
		a0.Name = "Attachment1"
		a0.Position = Vector3.new(0,0,-0.5)
		local a1 = Instance.new("Attachment")
		a1.Parent = x
		a1.Name = "Attachment2"
		a1.Position = Vector3.new(0,0,-19)
		local beam = Instance.new("Beam")
		beam.Parent = x
		beam.Name = "BeamLight"
		beam.Attachment0 = a0
		beam.Attachment1 = a1
		beam.Color = ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
		beam.Enabled = true
		beam.LightEmission = 0
		beam.LightInfluence = 0
		beam.Texture = "rbxassetid://901813002"
		beam.TextureLength = 19
		beam.TextureMode = "Wrap"
		beam.TextureSpeed = 0
		beam.Transparency = NumberSequence.new(0.5,0.5)
		beam.ZOffset = 0
		beam.FaceCamera = true
		beam.Segments = 100
		beam.Width0  = 0.5
		beam.Width1 = 10
		end
		for i,x in pairs(lR) do
			x.L.Enabled = true
			x.Material = "Neon"
		end
	else
		for i,x in pairs(l) do
			if x:FindFirstChild("Attachment1") then
				x.Attachment1:remove()
			end
			if x:FindFirstChild("Attachment2") then
				x.Attachment2:remove()
			end
			if x:FindFirstChild("BeamLight") then
				x.BeamLight:remove()
			end
			if x:FindFirstChild("SpotLight") then
				x.SpotLight:remove()
			end
		end
		for i,x in pairs(lR) do
			x.L.Enabled = false
			x.Material = "Glass"
		end
	end
end)
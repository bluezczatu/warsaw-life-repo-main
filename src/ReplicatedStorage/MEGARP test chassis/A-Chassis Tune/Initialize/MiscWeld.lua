local MiscWeld = {}

function MakeWeld(x,y,type,s) 
	if type==nil then type="Weld" end
	local W=Instance.new(type)
	W.Part0=x W.Part1=y 
	W.C0=x.CFrame:inverse()*x.CFrame 
	W.C1=y.CFrame:inverse()*x.CFrame 
	W.Parent=x 
	if type=="Motor" and s~=nil then 
		W.MaxVelocity=s 
	end 
	return W	
end
function ModelWeld(a,b) 
	if a:IsA("BasePart") then 
		MakeWeld(b,a,"Weld") 
	elseif a:IsA("Model") then 
		for i,v in pairs(a:GetChildren()) do 
			ModelWeld(v,b) 
		end 
	end 
end

car = script.Parent.Parent.Parent
misc = car:WaitForChild("Misc")

---------------------------
--[[
	--Main anchor point is the DriveSeat <car.DriveSeat>	
	
	Usage:
		MakeWeld(Part1,Part2,WeldType*,MotorVelocity**) *default is "Weld"  **Applies to Motor welds only
		ModelWeld(Model,MainPart)
	Example:
		MakeWeld(car.DriveSeat,misc.PassengerSeat)
		MakeWeld(car.DriveSeat,misc.SteeringWheel,"Motor",.2)
		ModelWeld(car.DriveSeat,misc.Door)
]]

--Weld stuff here

car.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		child.C0=CFrame.new(0,-.5,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)*CFrame.Angles(math.rad(13),0,0)
	end
end)

function animPose(seat,pose)
	local C
	local S=seat
	local WS={}
	local HW={}

	local seatOffset = 	CFrame.new(-0.000107765198, 0.599642813, 0.399557114, 1, -3.47597293e-008, 1.00284217e-006, 3.47599958e-008, 1, -2.4586916e-007, -1.00284217e-006, 2.45869217e-007, 1)


	S.ChildRemoved:connect(function(child)		
		if child.Name=="SeatWeld" and child:IsA("Weld") then 
			for i,v in pairs(WS) do
				if v~=0 then 
					if v[4]~=nil then 
						v[4]:Destroy()
						v[1].Part1=v[5]
					else 
						if v[2]~=nil then 
							v[1].C0=v[2] v[1].C1=v[3]
						else 
							v[1]:Destroy()
						end
					end
				end
			end 
			for i,v in pairs(HW) do
				v[1]:Destroy()
				v[2]:Destroy()
				v[3].Transparency=0
			end
			C=nil
			WS = {}
			HW = {}
		end 
	end)

	S.ChildAdded:connect(function(child)
		if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			C = child.Part1.Parent
			S.SeatWeld.C0 = seatOffset
			S.SeatWeld.C1 = CFrame.new()

			local pkTor = false
			for i,v in pairs(C:GetChildren()) do
				if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.Torso then
					pkTor=true
					break
				end
			end

			local function MW(x,y)
				local WW=Instance.new("Weld",x) WW.Part0=x WW.Part1=y return WW
			end

			if C:FindFirstChild("HumanoidRootPart")~=nil and C:FindFirstChild("Torso")~=nil then
				S.SeatWeld.C0=seatOffset
				S.SeatWeld.C1=CFrame.new()
				C.HumanoidRootPart.RootJoint.Part1=nil
				table.insert(WS,{C.HumanoidRootPart.RootJoint,C.HumanoidRootPart.RootJoint.C0,C.HumanoidRootPart.RootJoint.C1,MW(C.HumanoidRootPart,C.Torso),C.Torso})
				if C.Torso:FindFirstChild("Neck")~=nil then
					local H=C.Head:Clone()
					H.Name="Part"
					H.Parent=C
					local WH=MW(C.Torso,H)
					WH.C0=C.Torso.Neck.C0
					WH.C1=C.Torso.Neck.C0
					C.Head.Transparency=1
					table.insert(HW,{H,WH,C.Head})
					table.insert(WS,{WH,nil,nil,nil,nil})
					for i,v in pairs(C.Head:GetChildren()) do
						if v:IsA("Weld") then
							local pp=v.Part1:Clone()
							pp.Parent=C
							v.Part1.Transparency=1
							local ww=MW(H,pp)
							ww.C0=v.C0
							ww.C1=v.C1
							table.insert(HW,{pp,ww,v.Part1})
						end
					end	
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Left Shoulder")~=nil then
					C.Torso:FindFirstChild("Left Shoulder").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Left Shoulder"),C.Torso:FindFirstChild("Left Shoulder").C0,C.Torso:FindFirstChild("Left Shoulder").C1,MW(C.Torso,C:FindFirstChild("Left Arm")),C:FindFirstChild("Left Arm")})
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Right Shoulder")~=nil then
					C.Torso:FindFirstChild("Right Shoulder").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Right Shoulder"),C.Torso:FindFirstChild("Right Shoulder").C0,C.Torso:FindFirstChild("Right Shoulder").C1,MW(C.Torso,C:FindFirstChild("Right Arm")),C:FindFirstChild("Right Arm")})
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Left Hip")~=nil then
					C.Torso:FindFirstChild("Left Hip").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Left Hip"),C.Torso:FindFirstChild("Left Hip").C0,C.Torso:FindFirstChild("Left Hip").C1,MW(C.Torso,C:FindFirstChild("Left Leg")),C:FindFirstChild("Left Leg")})
				else
					table.insert(WS,0)
				end
				if C.Torso:FindFirstChild("Right Hip")~=nil then
					C.Torso:FindFirstChild("Right Hip").Part1=nil
					table.insert(WS,{C.Torso:FindFirstChild("Right Hip"),C.Torso:FindFirstChild("Right Hip").C0,C.Torso:FindFirstChild("Right Hip").C1,MW(C.Torso,C:FindFirstChild("Right Leg")),C:FindFirstChild("Right Leg")})
				else
					table.insert(WS,0)
				end
			end

			for i,v in pairs(WS) do
				local cfp = pose[i]
				if i==3 then
					for i,v in pairs(C:GetChildren()) do
						if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.LeftArm then
							cfp = pose[7]
							break
						end
					end
				elseif i==4 then
					for i,v in pairs(C:GetChildren()) do
						if v:IsA("CharacterMesh") and v.BodyPart == Enum.BodyPart.RightArm then
							cfp = pose[8]
							break
						end
					end
				end
				if v[4]~=nil then
					v[4].C0=cfp
					v[4].C1=CFrame.new()
				else
					v[1].C0=cfp
					v[1].C1=CFrame.new()
				end
			end
		end
	end)
end


car.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		child.C0=CFrame.new(0,-.5,0)*CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0)*CFrame.Angles(math.rad(13),0,0)
	end
end)



---------------------------
return MiscWeld
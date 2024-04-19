script:WaitForChild("V")

local car = script.V.Value
local _Tune = require(car["A-Chassis Tune"])

--STATREADER:WaitForChild("Close")
car:WaitForChild("STATREADER")
local STATREADER = car.STATREADER:WaitForChild("Frame")
STATREADER:WaitForChild("C")
STATREADER:WaitForChild("FD")
STATREADER:WaitForChild("FI")
STATREADER:WaitForChild("HP")
STATREADER:WaitForChild("HPB")
STATREADER:WaitForChild("IC")
STATREADER:WaitForChild("N")
STATREADER:WaitForChild("P2W")
STATREADER:WaitForChild("PSI")
STATREADER:WaitForChild("TS")
STATREADER:WaitForChild("Tires")
STATREADER:WaitForChild("W")
STATREADER:WaitForChild("Logo1")
STATREADER:WaitForChild("Logo2")

local function RoundNumber(Number, Divider)
	Divider = Divider or 1
	return (math.floor((Number/Divider)+0.5)*Divider)
end

if STATREADER:FindFirstChild("Logo1") and STATREADER:FindFirstChild("Logo2") then
	if STATREADER.Logo1.Image == "rbxassetid://1112860376" and STATREADER.Logo2.Image == "rbxassetid://1112860376" and STATREADER.Logo2.ImageTransparency == 0 then
		
		--[[STATREADER.Close.MouseButton1Click:connect(function()
			STATREADER.Parent:Destroy()
		end)]]
		
		if _Tune.CompressRatio ~= nil then
			STATREADER.C.Text = "Compression: ".._Tune.CompressRatio
		else
			STATREADER.C.Text = "Compression: Data Not Available"	
		end
		
		if _Tune.Horsepower ~= nil then
			STATREADER.HP.Text = "N/A Power: "..RoundNumber(_Tune.Horsepower,1).."hp"
		else
			STATREADER.HP.Text = "N/A Power: Data Not Available"
		end
		
		if _Tune.Horsepower ~= nil and _Tune.Boost ~= nil and _Tune.CompressRatio ~= nil and _Tune.Aspiration ~= nil then
			if _Tune.Aspiration == "Single" then
				STATREADER.HPB.Text = "Boosted Power: "..RoundNumber(_Tune.Horsepower+(_Tune.Horsepower*((((1*_Tune.Boost*1)*(_Tune.CompressRatio/10))/7.5))/2),1).."hp"
				STATREADER.PSI.Text = "Turbo Psi: ".._Tune.Boost.."psi"
				STATREADER.TS.Text = "Turbo Size: ".._Tune.TurboSize.."mm"
			elseif _Tune.Aspiration == "Double" then
				STATREADER.HPB.Text = "Boosted Power: "..RoundNumber(_Tune.Horsepower+(_Tune.Horsepower*((((1*_Tune.Boost*2)*(_Tune.CompressRatio/10))/7.5))/2),1).."hp"
				STATREADER.PSI.Text = "Turbo Psi: ".._Tune.Boost.."psi x2"
				STATREADER.TS.Text = "Turbo Size: ".._Tune.TurboSize.."mm x2"
			elseif _Tune.Aspiration == "Natural" then
				STATREADER.HPB.Text = "Boosted Power: Data Not Available"
				STATREADER.PSI.Text = "Turbo Psi: Data Not Available"
				STATREADER.TS.Text = "Turbo Size: Data Not Available"
			end
		else
			STATREADER.HPB.Text = "Boosted Power: Data Not Available"
			STATREADER.PSI.Text = "Turbo Psi: Data Not Available"
			STATREADER.TS.Text = "Turbo Size: Data Not Available"
		end
		
		if _Tune.InclineComp ~= nil then
			STATREADER.IC.Text = "InclineComp: ".._Tune.InclineComp
		else
			STATREADER.IC.Text = "InclineComp: Data Not Available"
		end
		
		STATREADER.N.Text = "Name: "..car.Name
		
		if _Tune.Weight ~= nil then
			STATREADER.W.Text = "Weight: ".._Tune.Weight.."lbs"
		else
			STATREADER.W.Text = "Weight: Data Not Available"
		end
		
		if _Tune.Aspiration ~= nil then
			STATREADER.FI.Text = "Forced Induction: ".._Tune.Aspiration
		else
			STATREADER.FI.Text = "Forced Induction: Data Not Available"
		end
		
		if _Tune.FDMult ~= nil then
			STATREADER.FD.Text = "FDMultiplier: ".._Tune.FDMult
		else
			STATREADER.FD.Text = "FDMultiplier: Data Not Available"
		end
		
		if _Tune.Horsepower ~= nil and _Tune.Weight ~= nil then
			if _Tune.Boost ~= nil and _Tune.CompressRatio ~= nil and _Tune.Aspiration ~= nil then
				if _Tune.Aspiration == "Single" then
					STATREADER.P2W.Text = "P/W Ratio: "..RoundNumber((_Tune.Horsepower+(_Tune.Horsepower*((((1*_Tune.Boost*1)*(_Tune.CompressRatio/10))/7.5))/2))/_Tune.Weight,.0001)
				elseif _Tune.Aspiration == "Double" then
					STATREADER.P2W.Text = "P/W Ratio: "..RoundNumber((_Tune.Horsepower+(_Tune.Horsepower*((((1*_Tune.Boost*2)*(_Tune.CompressRatio/10))/7.5))/2))/_Tune.Weight,.0001)
				elseif _Tune.Aspiration == "Natural" then
					STATREADER.P2W.Text = "P/W Ratio: "..RoundNumber(_Tune.Horsepower/_Tune.Weight,.0001)
				end
			else
				STATREADER.P2W.Text = "P/W Ratio: "..RoundNumber(_Tune.Horsepower/_Tune.Weight,.0001)
			end
		else
			STATREADER.P2W.Text = "P/W Ratio: Data Not Available"
		end
		
		if car.DriveSeat.TireStats.Fwear.Value == .2 and car.DriveSeat.TireStats.Ffriction.Value > .579 and car.DriveSeat.TireStats.Ffriction.Value < .631 and car.DriveSeat.TireStats.Fminfriction.Value == .35 and car.DriveSeat.TireStats.Ffweight.Value == 2 and car.DriveSeat.TireStats.TCS.Value == 1 and car.DriveSeat.TireStats.Lock.Value == 1/6 and car.DriveSeat.TireStats.Spin.Value == 1/1.2 and car.DriveSeat.TireStats.Rwear.Value == .2 and car.DriveSeat.TireStats.Rfriction.Value > .579 and car.DriveSeat.TireStats.Rfriction.Value < .631 and car.DriveSeat.TireStats.Rminfriction.Value == .35 and car.DriveSeat.TireStats.Rfweight.Value == 2 and car.DriveSeat.TireStats.Reg.Value == 3.6 then
			STATREADER.Tires.Text = "Tires: All Season"
		elseif car.DriveSeat.TireStats.Fwear.Value == 30 and car.DriveSeat.TireStats.Ffriction.Value > 1.179 and car.DriveSeat.TireStats.Ffriction.Value < 1.231 and car.DriveSeat.TireStats.Fminfriction.Value == .35 and car.DriveSeat.TireStats.Ffweight.Value == 1 and car.DriveSeat.TireStats.TCS.Value == 1 and car.DriveSeat.TireStats.Lock.Value == 1/6 and car.DriveSeat.TireStats.Spin.Value == 1/1.2 and car.DriveSeat.TireStats.Rwear.Value == 30 and car.DriveSeat.TireStats.Rfriction.Value > 1.179 and car.DriveSeat.TireStats.Rfriction.Value < 1.231 and car.DriveSeat.TireStats.Rminfriction.Value == .35 and car.DriveSeat.TireStats.Rfweight.Value == 1 and car.DriveSeat.TireStats.Reg.Value == 20 then
			STATREADER.Tires.Text = "Tires: Drag Radials"
		elseif car.DriveSeat.TireStats.Fwear.Value == .3 and car.DriveSeat.TireStats.Ffriction.Value > .479 and car.DriveSeat.TireStats.Ffriction.Value < .531 and car.DriveSeat.TireStats.Fminfriction.Value == .35 and car.DriveSeat.TireStats.Ffweight.Value == 10 and car.DriveSeat.TireStats.TCS.Value == 1 and car.DriveSeat.TireStats.Lock.Value == 1/6 and car.DriveSeat.TireStats.Spin.Value == 1/1.2 and car.DriveSeat.TireStats.Rwear.Value == .3 and car.DriveSeat.TireStats.Rfriction.Value > .479 and car.DriveSeat.TireStats.Rfriction.Value < .531 and car.DriveSeat.TireStats.Rminfriction.Value == .35 and car.DriveSeat.TireStats.Rfweight.Value == 10 and car.DriveSeat.TireStats.Reg.Value == 3.6 then
			STATREADER.Tires.Text = "Tires: All Terrain"
		elseif car.DriveSeat.TireStats.Fwear.Value == .5 and car.DriveSeat.TireStats.Ffriction.Value > .729 and car.DriveSeat.TireStats.Ffriction.Value < .781 and car.DriveSeat.TireStats.Fminfriction.Value == .35 and car.DriveSeat.TireStats.Ffweight.Value == .6 and car.DriveSeat.TireStats.TCS.Value == 1 and car.DriveSeat.TireStats.Lock.Value == 1/6 and car.DriveSeat.TireStats.Spin.Value == 1/1.2 and car.DriveSeat.TireStats.Rwear.Value == .5 and car.DriveSeat.TireStats.Rfriction.Value > .729 and car.DriveSeat.TireStats.Rfriction.Value < .781 and car.DriveSeat.TireStats.Rminfriction.Value == .35 and car.DriveSeat.TireStats.Rfweight.Value == .6 and car.DriveSeat.TireStats.Reg.Value == 3.6 then
			STATREADER.Tires.Text = "Tires: Semi Slicks"
		elseif car.DriveSeat.TireStats.Fwear.Value == .6 and car.DriveSeat.TireStats.Ffriction.Value > .879 and car.DriveSeat.TireStats.Ffriction.Value < .931 and car.DriveSeat.TireStats.Fminfriction.Value == .35 and car.DriveSeat.TireStats.Ffweight.Value == .6 and car.DriveSeat.TireStats.TCS.Value == 1 and car.DriveSeat.TireStats.Lock.Value == 1/6 and car.DriveSeat.TireStats.Spin.Value == 1/1.2 and car.DriveSeat.TireStats.Rwear.Value == .6 and car.DriveSeat.TireStats.Rfriction.Value > .879 and car.DriveSeat.TireStats.Rfriction.Value < .931 and car.DriveSeat.TireStats.Rminfriction.Value == .35 and car.DriveSeat.TireStats.Rfweight.Value == .6 and car.DriveSeat.TireStats.Reg.Value == 3.6 then
			STATREADER.Tires.Text = "Tires: Slicks"
		elseif car.DriveSeat.TireStats.Fwear.Value == 0 and car.DriveSeat.TireStats.Ffriction.Value == 0 and car.DriveSeat.TireStats.Fminfriction.Value == 0 and car.DriveSeat.TireStats.Ffweight.Value == 0 and car.DriveSeat.TireStats.TCS.Value == 0 and car.DriveSeat.TireStats.Lock.Value == 0 and car.DriveSeat.TireStats.Spin.Value == 0 and car.DriveSeat.TireStats.Rwear.Value == 0 and car.DriveSeat.TireStats.Rfriction.Value == 0 and car.DriveSeat.TireStats.Rminfriction.Value == 0 and car.DriveSeat.TireStats.Rfweight.Value == 0 and car.DriveSeat.TireStats.Reg.Value == 0 then
			STATREADER.Tires.Text = "Tires: Car Not Initialized"
		else
			STATREADER.Tires.Text = "Tires: Not Standard"
		end
		
		script:Destroy()
	else
		STATREADER.N.Text = "This is a product of Autoclub"
		STATREADER.C.Text = "So now restore the script to its original conditions,"
		STATREADER.HP.Text = "Why are you trying to remove the logos?"
		STATREADER.HPB.Text = "it will be very appreciated,"
		STATREADER.PSI.Text = "Idk man theres nothing wrong with showing the fact that you use our stuff,"
		STATREADER.IC.Text = "don't do this, its very very petty"
		STATREADER.W.Text = "and especially if you're from another community"
		STATREADER.FI.Text = "Dont you think its kinda petty to remove the credits?"
		STATREADER.FD.Text = "and you're a HR"
		STATREADER.TS.Text = "you know you can be better than that,"
		STATREADER.P2W.Text = "and it is a sign of maturity."
		STATREADER.Tires.Text = "-Autoclub Tire System"
	end	
else
	STATREADER.N.Text = "This is a product of Autoclub"
	STATREADER.C.Text = "So now restore the script to its original conditions,"
	STATREADER.HP.Text = "Why are you trying to remove the logos?"
	STATREADER.HPB.Text = "it will be very appreciated,"
	STATREADER.PSI.Text = "Idk man theres nothing wrong with showing the fact that you use our stuff,"
	STATREADER.IC.Text = "don't do this, its very very petty"
	STATREADER.W.Text = "and especially if you're from another community"
	STATREADER.FI.Text = "Dont you think its kinda petty to remove the credits?"
	STATREADER.FD.Text = "and you're a HR"
	STATREADER.TS.Text = "you know you can be better than that,"
	STATREADER.P2W.Text = "and it is a sign of maturity."
	STATREADER.Tires.Text = "-Autoclub Tire System"
end
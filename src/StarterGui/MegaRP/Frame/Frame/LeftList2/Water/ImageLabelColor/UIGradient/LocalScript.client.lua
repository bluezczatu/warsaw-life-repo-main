wait(3)

local UIGradient = script.Parent

--UIGradient.Color = ColorSequence.new({
--	ColorSequenceKeypoint.new(0, Color3.new(1,0,0)),
--	ColorSequenceKeypoint.new(0.5, Color3.new(0,1,0)),
--	ColorSequenceKeypoint.new(1, Color3.new(0,0,1))
--})


--UIGradient.Transparency = NumberSequence.new({
--	NumberSequenceKeypoint.new(1, 1, 1),
--	NumberSequenceKeypoint.new(0, 1, 2),
--	NumberSequenceKeypoint.new(1, 0, 3),
--})


--local TransOfPercentPart = 1
--local TransOfMissingPart = 0.1
----local TransOfMissingPart = 0.76

--local progress = 1 -- jesli 1 to widac
--local progress2 = progress - 0.01

--UIGradient.Transparency = NumberSequence.new({
--	NumberSequenceKeypoint.new(0,TransOfPercentPart),
--	NumberSequenceKeypoint.new( progress,TransOfPercentPart),
--	NumberSequenceKeypoint.new( progress2,TransOfMissingPart),
--	NumberSequenceKeypoint.new(1,TransOfMissingPart)
--})
--progress = 4.999
--progress = 5
--wait(3)


--UIGradient.Transparency = NumberSequence.new({
--	NumberSequenceKeypoint.new(0,TransOfPercentPart),
--	NumberSequenceKeypoint.new( progress,TransOfPercentPart),
--	NumberSequenceKeypoint.new( progress2,TransOfMissingPart),
--	NumberSequenceKeypoint.new(1,TransOfMissingPart)
--})
--progress = 5

--wait(3)

--UIGradient.Transparency = NumberSequence.new({
--	NumberSequenceKeypoint.new(0,TransOfPercentPart),
--	NumberSequenceKeypoint.new( progress,TransOfPercentPart),
--	NumberSequenceKeypoint.new( progress2,TransOfMissingPart),
--	NumberSequenceKeypoint.new(1,TransOfMissingPart)
--})


local function updatevalue(value)
	if value <= 0.01 then
		value = 0.01
	end
	
	local TransOfPercentPart = 0.75 -- main color
	local TransOfMissingPart = 0
	
	local progress = value - 0.01
	local progress2 = value
	
	UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,TransOfPercentPart),
		NumberSequenceKeypoint.new(progress,TransOfPercentPart),
		NumberSequenceKeypoint.new(progress2,TransOfMissingPart),
		NumberSequenceKeypoint.new(1,TransOfMissingPart)
	})

	
end


updatevalue(1)


wait(2)

updatevalue(0.5)



wait(2)


updatevalue(0)



wait(1)

updatevalue(0.5)



wait(2)

updatevalue(0.1)
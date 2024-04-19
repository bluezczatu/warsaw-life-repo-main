local textLabel = script.Parent.Frame.TextLabel
local backgroundFrame = script.Parent.Frame

textLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
	local textBoundsSize = textLabel.TextBounds
	local parentSize = backgroundFrame.AbsoluteSize
	local monitorSize = game.Workspace.CurrentCamera.ViewportSize



	local BoundsSizeX = ( (textLabel.TextBounds.X + 0) / monitorSize.X) + ( (textLabel.TextBounds.X + 0) / backgroundFrame.Parent.AbsoluteSize.X)


	local BoundsSizeY = ( (textLabel.TextBounds.Y + 10) / monitorSize.Y) + ( (textLabel.TextBounds.Y + 10) / backgroundFrame.Parent.AbsoluteSize.Y)

	--local BoundsSizeY = 0.07



	--local BoundsSizeY = ((textLabel.TextSize + 30) / monitorSize.Y) + (parentSize.Y / monitorSize.Y)
	backgroundFrame.Size = UDim2.fromScale(BoundsSizeX, BoundsSizeY)


	--backgroundFrame.Size = UDim2.new(BoundsSizeX, 0, BoundsSizeY, 0)

end)


local TweenService = game.TweenService


textLabel.Position = UDim2.new(4,0,0.5,0)

TweenService:Create(
		textLabel,
		TweenInfo.new(0.5),
		{
		Position = UDim2.new(0.5,0,0.5,0)
		}
):Play()

wait(3)

textLabel.Position = UDim2.new(4,0,0.5,0)

TweenService:Create(
	textLabel,
	TweenInfo.new(0.5),
	{
		Position = UDim2.new(0.5,0,0.5,0)
	}
):Play()

wait(3)

textLabel.Position = UDim2.new(4,0,0.5,0)

TweenService:Create(
	textLabel,
	TweenInfo.new(0.5),
	{
		Position = UDim2.new(0.5,0,0.5,0)
	}
):Play()

wait(3)
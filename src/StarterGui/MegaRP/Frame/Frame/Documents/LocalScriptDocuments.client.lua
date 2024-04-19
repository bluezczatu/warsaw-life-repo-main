local ReplicatedStorage = game.ReplicatedStorage
local ShowDocumentClient = ReplicatedStorage.Events.ShowDocumentClient
local player = game.Players.LocalPlayer

local PlayerGui = player.PlayerGui



local TweenService = game:GetService("TweenService")

local startPosition = UDim2.new(-2, 0, 0.5, 0) -- Początkowa pozycja frame
local endPosition = UDim2.new(0.05, 0, 0.5, 0) -- Końcowa pozycja frame; 1 oznacza prawą krawędź, na osi X

local tweenInfo = TweenInfo.new(
	1, -- Czas trwania tween w sekundach
	Enum.EasingStyle.Linear, -- Styl wygładzania ruchu (easing style)
	Enum.EasingDirection.Out, -- Kierunek wygładzania (easing direction)
	0, -- Ile razy powtórzyć animację
	false, -- Czy animacja ma być odtwarzana wstecz (reverse)
	0 -- Opóźnienie przed rozpoczęciem animacji
)

local documentVisible = false

ShowDocumentClient.OnClientEvent:Connect(function(documentData)
	if documentVisible == false then
		if documentData.Type == "ID" then
			documentVisible = true

			local documentFrame = PlayerGui.MegaRP.Frame.Frame.Documents.ID

			--(documentData)
			--warn(documentData.Info)
			--warn(documentData.Info.Names)

			--warn(documentFrame.Names.Text)

			documentFrame.Names.Text = documentData.Info.Name
			documentFrame.LastName.Text =  documentData.Info.LastName
			documentFrame.BirthDate.Text =  documentData.Info.BirthDate
			documentFrame.ID.Text = documentData.Info.ID

			local tweenstart = TweenService:Create(documentFrame, tweenInfo, {Position = endPosition})
			local tweenend = TweenService:Create(documentFrame, tweenInfo, {Position = startPosition})

			documentFrame.Visible = true
			tweenstart:Play()
			wait(5)
			tweenend:Play()
			wait(1)
			documentFrame.Visible = false
			documentVisible = false
		end
		
		
		
		
		
	end
end)
local exitButton = script.Parent.Exit
local player = game.Players.LocalPlayer


local WithdrawMoney = game.ReplicatedStorage.Functions.WithdrawMoney
local DepositMoney = game.ReplicatedStorage.Functions.DepositMoney
local TransferMoney = game.ReplicatedStorage.Functions.TransferMoney

--Client	RemoteEvent:FireServer(args)
--Server	RemoteEvent.OnServerEvent:Connect(function(player, args))


local function hideFrames()
	local anotherFrames = script.Parent:GetChildren()
	for i = 1, #anotherFrames do
		local frame = anotherFrames[i]
		if frame:IsA("Frame") then
			frame.Visible = false
		end
	end
end



exitButton.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Enabled = false
	hideFrames()
	script.Parent.Main.Visible = true
	
end)









local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local Object = script.Parent.Main

local tweenInfo = TweenInfo.new(
	1, -- Czas trwania animacji
	Enum.EasingStyle.Quart, -- Styl animacji
	Enum.EasingDirection.Out, -- Kierunek wygładzania animacji
	0, -- Animacja nie będzie się powtarzać
	false, -- Animacja nie odwróci się do pozycji początkowej
	0 -- Opóźnienie przed startem animacji
)

--local Title = script.Parent.TitleLabel
--local Text = script.Parent.TextLabel
--local ImageMain = script.Parent.Main
--local ImageBack = script.Parent.Back

local Title = script.Parent.Alerts.Main.Alert.TitleLabel
local Text = script.Parent.Alerts.Main.Alert.TextLabel
local ImageMain = script.Parent.Alerts.Main.Alert.Main
local ImageBack = script.Parent.Alerts.Main.Alert.Back
local Frame = script.Parent.Alerts.Main

local SuccessImage = "rbxassetid://16017452552"
local ErrorImage = "rbxassetid://16018093719"
local WarnImage = "rbxassetid://16018093850"

local SuccessColor = Color3.fromHex("7DBC36")
local ErrorColor = Color3.fromHex("ff6961")
local WarnColor = Color3.fromHex("FF875A")


local UIAnimations = {
	TweenMainImageRotation = TweenService:Create(ImageMain, tweenInfo, {Rotation = 0}),
	TweenMainTransparency = TweenService:Create(ImageMain, tweenInfo, {ImageTransparency = 0}),
	TweenBackTransparency = TweenService:Create(ImageBack, tweenInfo, {ImageTransparency = 0}),
	TweenTitleTransparency = TweenService:Create(Title, tweenInfo, {TextTransparency = 0}),
	TweenTextTransparency = TweenService:Create(Text, tweenInfo, {TextTransparency = 0}),
}


local function Clear()
	Title.TextTransparency = 1
	Text.TextTransparency = 1
	ImageMain.ImageTransparency = 1
	ImageBack.ImageTransparency = 1
	ImageMain.Rotation = 90
end

local function Alert(TitleData, TextData, AlertType)
	
	Clear()
	
	Title.Text = TitleData
	Text.Text = TextData

	if AlertType == "Success" then
		ImageMain.Image = SuccessImage
		ContentProvider:PreloadAsync({SuccessImage})
		ImageMain.ImageColor3 = SuccessColor
		ImageBack.ImageColor3 = SuccessColor
	end
	if AlertType == "Error" then
		ImageMain.Image = ErrorImage
		ContentProvider:PreloadAsync({ErrorImage})
		ImageMain.ImageColor3 = ErrorColor
		ImageBack.ImageColor3 = ErrorColor
	end
	if AlertType == "Warn" then
		ImageMain.Image = WarnImage
		ContentProvider:PreloadAsync({WarnImage})
		ImageMain.ImageColor3 = WarnColor
		ImageBack.ImageColor3 = WarnColor
	end
	Frame.Visible = true
	wait(0.2)
	for _, Animation in pairs(UIAnimations) do
		Animation:Play()
	end
	wait(2)
	Frame.Visible = false

end












local bankButtons = script.Parent.Main.Buttons:GetChildren()

for i = 1, #bankButtons do
	local button = bankButtons[i]

	if button:IsA("TextButton") then
		
		local frame = script.Parent:FindFirstChild(button.Name)
		
		button.MouseButton1Click:Connect(function()
			warn("XD")
			warn(button.Name)
			hideFrames()
			
			frame.Visible = true
			
		end)
		
		frame:FindFirstChild("Back").MouseButton1Click:Connect(function()
			hideFrames()
			script.Parent.Main.Visible = true
		end)
		
		frame:FindFirstChild("Pay").MouseButton1Click:Connect(function()
			if button.Name == "Withdraw" then
				if frame.Amount.Text == "" then
					Alert("WYPŁATA", "Podane dane nie są prawidłowe!", "Warn")
					return
				end
				local resposne = WithdrawMoney:InvokeServer(frame.Amount.Text)
				warn(resposne)
				if resposne == true then
					Alert("WYPŁATA", "Wypłacono środki!", "Success")
					hideFrames()
					script.Parent.Main.Visible = true
					script.Parent.Main.MoneyValue.Text = tonumber(script.Parent.Main.MoneyValue.Text:split(" ")[1]) - tonumber(frame.Amount.Text) .." PLN"
				end
				if resposne == false then
					Alert("WYPŁATA", "Brak wystarczających środków na koncie!", "Error")
				end
				if resposne == nil then
					Alert("WYPŁATA", "Podane dane nie są prawidłowe!", "Warn")
				end
			end
			if button.Name == "Deposit" then
				if frame.Amount.Text == "" then
					Alert("WPŁATA", "Podane dane nie są prawidłowe!", "Warn")
					return
				end
				local resposne = DepositMoney:InvokeServer(frame.Amount.Text)
				warn(resposne)
				if resposne == true then
					Alert("WPŁATA", "Wpłacono środki!", "Success")
					hideFrames()
					script.Parent.Main.Visible = true
					script.Parent.Main.MoneyValue.Text = tonumber(script.Parent.Main.MoneyValue.Text:split(" ")[1]) + tonumber(frame.Amount.Text) .." PLN"
				end
				if resposne == false then
					Alert("WPŁATA", "Brak wystarczających środków!", "Error")
				end
				if resposne == nil then
					Alert("WPŁATA", "Podane dane nie są prawidłowe!", "Warn")
				end
			end
			if button.Name == "Transfer" then
					if frame.AccountId.Text == "" or frame.Amount.Text == "" then
					Alert("PRZELEW", "Transakcja została odrzucona, podano nie prawidłowe dane!", "Warn")
					return
				end
				local resposne = TransferMoney:InvokeServer(frame.AccountId.Text, "Bank", frame.Amount.Text)
				warn(resposne)
				if resposne == true then
					Alert("PRZELEW", "Transakcja została przekazana do realizacji!", "Success")
					hideFrames()
					script.Parent.Main.Visible = true
					script.Parent.Main.MoneyValue.Text = tonumber(script.Parent.Main.MoneyValue.Text:split(" ")[1]) - tonumber(frame.Amount.Text) .." PLN"
				end
				if resposne == false then
					Alert("PRZELEW", "Transakcja została odrzucona, brak wystarczających środków na koncie!", "Error")
				end
				if resposne == nil then
					Alert("PRZELEW", "Transakcja została odrzucona, podano nie prawidłowe dane!", "Warn")
				end
			end
		end)
		
		
	end

	--if frame:IsA("Frame") then
	--	frame.Visible = false
	--end
end


local UserId = player.UserId

script.Parent.Main.IdValue.Text = UserId
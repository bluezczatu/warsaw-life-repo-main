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

local Title = script.Parent.TitleLabel
local Text = script.Parent.TextLabel
local ImageMain = script.Parent.Main
local ImageBack = script.Parent.Back

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
	for _, Animation in pairs(UIAnimations) do
		Animation:Play()
	end
	
end


Alert("Przelew", "Transakcja została przekazana do realizacji!", "Success")

wait(3)
Clear()

Alert("Przelew", "Transakcja została odrzucona, podano nie prawidłowe dane!", "Warn")

wait(3)
Clear()

Alert("Przelew", "Transakcja została odrzucona, twoje konto zostało zablokowane!", "Error")

wait(3)
Clear()


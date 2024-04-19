local MenButton = script.Parent.Men.Frame
local WomenButton = script.Parent.Woman.Frame

local ReplicatedStorage = game.ReplicatedStorage
local CreateCharacter = ReplicatedStorage.Functions:WaitForChild("CreateCharacter")

local FakeButton = script.Parent.AcceptFake
local AcceptButton = script.Parent.AcceptTOS

local CreateButton = script.Parent.CreateButton


local AcceptedName = false
local AcceptedLastName = false
local AcceptedDate = false
local AcceptedTos = false
local AcceptedFake = false

local Gender = 1
local Names = nil
local LastName = nil
local BirthDay = nil

function polishToUpper(str)
	local replacements = {
		["ą"] = "Ą", ["ć"] = "Ć", ["ę"] = "Ę",
		["ł"] = "Ł", ["ń"] = "Ń", ["ó"] = "Ó",
		["ś"] = "Ś", ["ź"] = "Ź", ["ż"] = "Ż"
	}

	local result = str:gsub(utf8.charpattern, function(char)
		if replacements[char:lower()] then
			return replacements[char:lower()]
		else
			return char:upper()
		end
	end)

	return result
end


MenButton.MouseButton1Click:Connect(function()
	MenButton.Frame.Visible = true
	WomenButton.Frame.Visible = false
	Gender = 1
end)

WomenButton.MouseButton1Click:Connect(function()
	MenButton.Frame.Visible = false
	WomenButton.Frame.Visible = true
	Gender = 2
end)


AcceptButton.MouseButton1Click:Connect(function()
	AcceptedTos = not AcceptedTos
	AcceptButton.Frame.Visible = AcceptedTos
	--warn(AcceptedTos)
end)

FakeButton.MouseButton1Click:Connect(function()
	AcceptedFake = not AcceptedFake
	FakeButton.Frame.Visible = AcceptedFake
	--warn(AcceptedFake)
end)



CreateButton.MouseButton1Click:Connect(function()
	if script.Parent.NameLabel.TextBox.Text ~= "" then
		Names = script.Parent.NameLabel.TextBox.Text
		AcceptedName = true
	else
		task.spawn(function()
			script.Parent.NameLabel.TextBox.Text = ""
			script.Parent.NameLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(255, 40,40)
			task.wait(3)
			script.Parent.NameLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
		end)
	end

	if script.Parent.LastNameLabel.TextBox.Text ~= "" then
		LastName = script.Parent.LastNameLabel.TextBox.Text
		AcceptedLastName = true
	else
		task.spawn(function()
			script.Parent.LastNameLabel.TextBox.Text = ""
			script.Parent.LastNameLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(255, 40,40)
			task.wait(3)
			script.Parent.LastNameLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
		end)
	end



	if script.Parent.DateLabel.TextBox.Text ~= "" then

		local date = script.Parent.DateLabel.TextBox.Text

		date = string.split(date, "-")		

		--warn(date)

		if date[3] then

			local year = tonumber(date[3])
			local month = tonumber(date[2])
			local day = tonumber(date[1])

			--warn(year)
			--warn(month)
			--warn(day)

			local datevalidation = 0

			if year >= 1900 and year <= 2020 then 
				--warn("rok ok")
				datevalidation = datevalidation + 1
			end
			if month >= 1 and month <= 12 then
				--warn("month ok")
				datevalidation = datevalidation + 1
			end
			if day >= 1 and month <= 31 then
				--warn("day ok")
				datevalidation = datevalidation + 1
			end

			if datevalidation == 3 then
				--warn("DATA CALA JEST OK")
				BirthDay =  date[3] .. "." .. date[2] .. "." .. date[1]
				AcceptedDate = true
			else
				task.spawn(function()
					script.Parent.DateLabel.TextBox.Text = ""
					script.Parent.DateLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(255, 40,40)
					task.wait(3)
					script.Parent.DateLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
				end)
			end

			--warn(date)
		else
			task.spawn(function()
				script.Parent.DateLabel.TextBox.Text = ""
				script.Parent.DateLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(255, 40,40)
				task.wait(3)
				script.Parent.DateLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
			end)
		end
	else
		task.spawn(function()
			script.Parent.DateLabel.TextBox.Text = ""
			script.Parent.DateLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(255, 40,40)
			task.wait(3)
			script.Parent.DateLabel.TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
		end)
	end
	
	if not AcceptedTos then
		task.spawn(function()
			AcceptButton.Frame.Visible = true
			AcceptButton.Frame.BackgroundColor3 = Color3.fromRGB(255, 40,40)
			task.wait(3)
			AcceptButton.Frame.Visible = false
			AcceptButton.Frame.BackgroundColor3 = Color3.fromRGB(141, 84, 233)
		end)
	end


	if not AcceptedFake  then
		task.spawn(function()
			FakeButton.Frame.Visible = true
			FakeButton.Frame.BackgroundColor3 = Color3.fromRGB(255, 40,40)
			task.wait(3)
			FakeButton.Frame.Visible = false
			FakeButton.Frame.BackgroundColor3 = Color3.fromRGB(141, 84, 233)
		end)
	end

	if AcceptedTos and AcceptedFake and AcceptedDate and AcceptedLastName and AcceptedName then
		--warn("ALLL GIT")
		
		local resposne = CreateCharacter:InvokeServer(polishToUpper(Names), polishToUpper(LastName), BirthDay, Gender)
		
		if resposne == true then
			script.Parent.Parent.Parent.Parent.Parent.CreateCharacterUI.Enabled = false
		end
	end

end)

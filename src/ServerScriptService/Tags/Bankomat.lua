local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EconomyHandler = require(game.ServerScriptService.EconomyHandler)

local UIStatusEvent = ReplicatedStorage.Events.UIStatus
local WithdrawMoney = ReplicatedStorage.Functions:WaitForChild("WithdrawMoney")
local DepositMoney = ReplicatedStorage.Functions:WaitForChild("DepositMoney")



	local TransferMoney = ReplicatedStorage.Functions:WaitForChild("TransferMoney")

--Client	RemoteEvent:FireServer(args)
--Server	RemoteEvent.OnServerEvent:Connect(function(player, args))

WithdrawMoney.OnServerInvoke = function(player, amount)
	return EconomyHandler:WithdrawMoney(player, amount)
end

DepositMoney.OnServerInvoke = function(player, amount)
	return EconomyHandler:DepositMoney(player, amount)
end

TransferMoney.OnServerInvoke = function(player, player2id, moneyType, amount)
	return EconomyHandler:TransferMoney(player, player2id, moneyType, amount)
end

return {
	tagName = "Bankomat",
	onInstanceAdded = function(instance: Instance): () -> ()
		local prompt = Instance.new("ProximityPrompt"):Clone()
		prompt.Parent = instance
		prompt.ActionText = "Użyj Bankomat"
		prompt.HoldDuration = 0.5
		prompt.Triggered:Connect(function(player)
			UIStatusEvent:FireClient(player, player.PlayerGui.Group.PaymentUI, nil, true)
			
			local playersData = EconomyHandler.Data
			if not playersData then return end
			
			--EconomyHandler:AddMoney(player, "Bank", 100)
			
			local bank = EconomyHandler[player.Name].Bank
			player.PlayerGui.Group.PaymentUI.Frame.Frame.Main.MoneyValue.Text = tostring(bank).." PLN"
			warn("Bank "..tostring(bank))
			local cash = EconomyHandler[player.Name].Cash
			warn("Cash: "..tostring(cash))
		end)

		return function()
			-- TODO: CLEANUP
		end
	end,
}
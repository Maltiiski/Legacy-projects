local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local DataStoreService   = game:GetService("DataStoreService")
local MarketplaceService = game:GetService("MarketplaceService")

local moneyStore   = DataStoreService:GetDataStore("PlayerMoney")
local STARTING_MONEY = 0

local changeMoneyRemote = ReplicatedStorage:WaitForChild("ChangeMoney")

--------------------------------------------------
--                 DATA HANDLING                --
--------------------------------------------------

local function loadMoney(player)
	local key = "user_" .. player.UserId
	local money

	local success, result = pcall(function()
		return moneyStore:GetAsync(key)
	end)

	money = (success and result) and result or STARTING_MONEY

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local moneyVal = Instance.new("IntValue")
	moneyVal.Name = "Money"
	moneyVal.Value = money
	moneyVal.Parent = leaderstats
end

local function saveMoney(player)
	local key = "user_" .. player.UserId
	local moneyVal = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money")
	if not moneyVal then return end

	local success, err = pcall(function()
		moneyStore:SetAsync(key, moneyVal.Value)
	end)
	if not success then
		warn(("Failed to save money for %s: %s"):format(player.Name, err))
	end
end

Players.PlayerAdded:Connect(loadMoney)
Players.PlayerRemoving:Connect(saveMoney)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		saveMoney(player)
	end
end)

--------------------------------------------------
--           CLIENT CHANGE                      --
--------------------------------------------------
changeMoneyRemote.OnServerEvent:Connect(function(player, delta)
	local stats  = player:FindFirstChild("leaderstats")
	local money  = stats and stats:FindFirstChild("Money")
	if not money then return end
	money.Value += delta
	changeMoneyRemote:FireClient(player, money.Value)
end)

--------------------------------------------------
--        BELI BARANG                           --
--------------------------------------------------

MarketplaceService.ProcessReceipt = function(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local productRewards = {
		[1297780488] = 5,
		[1297409351] = 10,
		[1297275685] = 20,
		[1297754672] = 50,
		[1297539074] = 100,
	}

	local reward = productRewards[receiptInfo.ProductId]
	if not reward then
		warn("Unknown product ID: " .. receiptInfo.ProductId)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local moneyVal = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money")
	if moneyVal then
		moneyVal.Value += reward
		changeMoneyRemote:FireClient(player, moneyVal.Value)
	end

	return Enum.ProductPurchaseDecision.PurchaseGranted
end

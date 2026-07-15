local DataStoreService = game:GetService("DataStoreService")
local ClassStore = DataStoreService:GetDataStore("PlayerClassData")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClassEvent = ReplicatedStorage:WaitForChild("SaveData")

local defaultData = {
	ClassNow = "a",
	a = 0,
	b = 0,
	c = 0,
	d = 0,
	e = 0,
	f = 0,
	g = 0,
	h = 0,
	i = 0,
	j = 0,
	k = 0,
	l = 0,
	m = 0,
	n = 0,
	o = 0,
	p = 0,
	q = 0,
	r = 0,
	s = 0,
	t = 0,
	u = 0,
	v = 0,
	w = 0,
	x = 0,
	y = 0,
	z = 0
}

local playerData = {}

game.Players.PlayerAdded:Connect(function(player)
	local data = table.clone(defaultData)

	local success, saved = pcall(function()
		return ClassStore:GetAsync(player.UserId)
	end)

	if success and saved then
		data = saved
	end

	playerData[player] = data

	-- Send data to client
	ClassEvent:FireClient(player, data)
end)

-- when client sends updated data
ClassEvent.OnServerEvent:Connect(function(player, newData)
	-- Validate data if I need to
	if typeof(newData) == "table" then
		playerData[player] = newData

		pcall(function()
			ClassStore:SetAsync(player.UserId, newData)
		end)
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	if playerData[player] then
		pcall(function()
			ClassStore:SetAsync(player.UserId, playerData[player])
		end)
	end
	playerData[player] = nil
end)
---------------------------------------------------------------------------

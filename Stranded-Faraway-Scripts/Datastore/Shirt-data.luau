local DataStoreService = game:GetService("DataStoreService")
local ItemStore        = DataStoreService:GetDataStore("PlayerAccessoryDataII")     

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ACEvent         = ReplicatedStorage:WaitForChild("SaveAva")      

local DefInv = { 
	a = 1,
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
local IData  = {}

game.Players.PlayerAdded:Connect(function(player)
	local dataII = table.clone(DefInv)

	local ok, saved = pcall(function()
		return ItemStore:GetAsync(player.UserId)                           
	end)
	if ok and saved then dataII = saved end

	IData[player] = dataII
	ACEvent:FireClient(player, dataII)
end)

ACEvent.OnServerEvent:Connect(function(player, newData)                    
	if typeof(newData) == "table" then
		IData[player] = newData
		pcall(function()
			ItemStore:SetAsync(player.UserId, newData)                      
		end)
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	if IData[player] then
		pcall(function()
			ItemStore:SetAsync(player.UserId, IData[player])              
		end)
	end
	IData[player] = nil
end)

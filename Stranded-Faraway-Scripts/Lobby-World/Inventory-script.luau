repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local itemdupe = repstor.Item

local itembars = script.Parent.InventBar
local itemcount = itembars.Parent.jumlahitem
local itemevnt = repstor:WaitForChild("ChangeInvent")

--> inventorybar <--
local bag = script.Parent
local openbagBB = script.Parent.Parent.OpenBag
local closebagBB = script.Parent.CloseBag

bag.Visible = false

openbagBB.Activated:Connect(function()
	bag.Visible = true
end)
closebagBB.Activated:Connect(function()
	bag.Visible = false
end)
--------------------------------------------------------
local function itemsystem(item)
	local found = false

	for _, itm in ipairs(itembars:GetChildren()) do
		if itm:IsA("ImageLabel") and itm:FindFirstChild("type") then
			if itm.type.Value == item then
				local countLabel = itm:FindFirstChild("ItemCount")
				if countLabel then
					countLabel.Text = tostring(tonumber(countLabel.Text or "0") + 1)
				end
				itemcount.Value += 1
				found = true
				break
			end
		end
	end

	if not found then
		local newitem = itemdupe:Clone()
		newitem.Parent = itembars
		newitem.type.Value = item
		newitem.ItemCount.Text = "1"
		itemcount.Value += 1
	end
end
local function itemload(tipe, amount)
	local newitem = itemdupe:Clone()
	newitem.Parent = itembars
	newitem.type.Value = tipe
	newitem.ItemCount.Text = tostring(amount)
	itemcount.Value += 1
end
---------------------------------------------------------
local iteminfo = {}

itemevnt.OnClientEvent:Connect(function(data)
	iteminfo = data
	for tipe, amount in pairs(data) do
		if amount > 0 then
			itemload(tipe, amount)
		end
	end
end)

local function changedata(item)
	iteminfo[item] += 1
	itemevnt:FireServer(iteminfo)
end
---------------------------------------------------------
repstor.InEventory.Event:Connect(function(item)
	task.spawn(itemsystem, item)
	changedata(item)
end)

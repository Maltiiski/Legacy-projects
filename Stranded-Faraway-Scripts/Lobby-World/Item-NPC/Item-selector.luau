repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local ITgui = script.Parent.ItemBox

ITgui.Visible = false

repstor.OpenShopGUI.Event:Connect(function(Tipe)
	if Tipe == 3 then
		ITgui.Visible = true

	end
end)

repstor.CloseShopGUI.Event:Connect(function(Tipe)
	if Tipe == 3 then
		ITgui.Visible = false
	end
end)
--> ZoomPack <--
local tweenserv = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweeninfo2 = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local Yap = script.Parent.Parent.NPCui.Yap

--> ITEM <--
local currentitem
local moneycount = script.Parent.Parent.MainGUI.duid.Money

local ItemBar = ITgui.ScrollItem
local ItemName = ITgui.DC.Itemnem
local ItemDesc = ITgui.DC.Desc
local ItemBuy = ITgui.DC.Buy
local ItemDisp = ITgui.DC.ImageLabel

local StoneSword = ItemBar.StoneSword

StoneSword.Activated:Connect(function()
	currentitem = StoneSword
	ItemName.Text = "Stone Sword"
	ItemDesc.Text = '<font color="#FFFFFF">A practical and effective weapon </font><font color="#AAAAAA">[1x Fried Cod]</font>'
	ItemBuy.Text = "10"
end)

----------------------------------------------------------------
local function buyitem(item, price)
	local moneynow = moneycount.Value - price
	if moneynow >= 0 then
		print(moneycount, moneynow)
		repstor.ChangeMoney:FireServer(-price)
		repstor.InEventory:Fire(item)
		Yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">Nice preparation!</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	else
		Yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">You do not have enough money</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end

ItemBuy.Activated:Connect(function()
	if currentitem == StoneSword then
		task.spawn(buyitem, "a", 10)
	end
end)

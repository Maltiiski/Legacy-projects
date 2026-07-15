repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClassEvent = ReplicatedStorage:WaitForChild("SaveData")

--> CLASSES <--
local repstor = game.ReplicatedStorage
local CSgui = script.Parent.ClassBox

CSgui.Visible = false

local ClassBar = CSgui.ScrollClass
local ClassDisp = CSgui.CDbg
local ClassDesc = CSgui.Dbg.Desc
local ClassBB = CSgui.CDbg.Buy
local Classrn

local NoneCS = ClassBar.NoneCS
local FisherCS = ClassBar.FisherCS
local ZenseiCS = ClassBar.ZenseiCS
-----------------------------------

local classInfo = {}

ClassEvent.OnClientEvent:Connect(function(receivedData)
	classInfo = receivedData
	NoneCS.Condition.Value = classInfo.a
	FisherCS.Condition.Value = classInfo.b
	ZenseiCS.Condition.Value = classInfo.c
	for _, CS in ipairs(ClassBar:GetChildren()) do
		if CS:IsA("ImageButton") then
			if CS.Condition.Value > 0 then
				CS.NotOwned.Visible = false
			else
				CS.NotOwned.Visible = true
			end
		end
	end
end)


local function updateClass(newClass)
	classInfo.ClassNow = newClass
	ClassEvent:FireServer(classInfo)
end
local function updateCScondition(class, newcond)
	classInfo[class] = newcond
	ClassEvent:FireServer(classInfo)
end

-----------------------------------------------------------------------------------------------------

repstor.OpenShopGUI.Event:Connect(function(Tipe)
	if Tipe == 2 then
		CSgui.Visible = true
		
	end
end)

repstor.CloseShopGUI.Event:Connect(function(Tipe)
	if Tipe == 2 then
		CSgui.Visible = false

	end
end)

local moneycount = script.Parent.Parent.MainGUI.duid.Money
local Yap = script.Parent.Parent.NPCui.Yap



NoneCS.Activated:Connect(function()
	Classrn = NoneCS
	ClassDisp.Classnem.Text = "None"
	ClassDesc.Text = "You start with the basic stats and no item"
	if NoneCS.Condition.Value == 0 then
		ClassBB.Text = "bug"
	elseif NoneCS.Condition.Value == 1 then
		ClassBB.Text = "Equip"
	elseif NoneCS.Condition.Value == 2 then
		ClassBB.Text = "Unequip"
	end
end)
FisherCS.Activated:Connect(function()
	Classrn = FisherCS
	ClassDisp.Classnem.Text = "Fisher"
	ClassDesc.Text = '<font color="#FFFFFF">You fish 40% quicker than normal, and you swim 30% faster! Your starting items are: </font><font color="#AAAAAA">[1x Wooden Rod], [10x Worm]</font>'
	if FisherCS.Condition.Value == 0 then
		ClassBB.Text = "30"
	elseif FisherCS.Condition.Value == 1 then
		ClassBB.Text = "Equip"
	elseif FisherCS.Condition.Value == 2 then
		ClassBB.Text = "Unequip"
	end
end)
ZenseiCS.Activated:Connect(function()
	Classrn = ZenseiCS
	ClassDisp.Classnem.Text = "Zensei"
	ClassDesc.Text = '<font color="#FFFFFF">You walk 20% faster than normal, and your attack speed is 30% faster! Your starting items are: </font><font color="#AAAAAA">[1x Zensei Rod]</font>'
	if ZenseiCS.Condition.Value == 0 then
		ClassBB.Text = "45"
	elseif ZenseiCS.Condition.Value == 1 then
		ClassBB.Text = "Equip"
	elseif ZenseiCS.Condition.Value == 2 then
		ClassBB.Text = "Unequip"
	end
end)
----------------------------------------------------------------------------------------------------------
local tweenserv = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweeninfo2 = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

local function sectionate()
	for _, ib in ipairs(ClassBar:GetChildren()) do
		if ib:IsA("ImageButton") then
			if ib.Condition.Value == 2 then
				ib.Condition.Value = 1
				updateCScondition(ib.CCD.Value, 1)
			end
		end
	end
end

local function buysystem(class, price, ccd)
	local moneynow = moneycount.Value - price
	print(moneycount.Value)
	if moneynow >= 0 then
		repstor.ChangeMoney:FireServer(-price)
		updateCScondition(class.CCD.Value, 1)
		class.Condition.Value = 1
		class.NotOwned.Visible = false
		ClassBB.Text = "Equip"
		Yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">This class fits you well!</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	else
		Yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">Not enough money, pal</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end

ClassBB.Activated:Connect(function()
	if Classrn == NoneCS then
		if NoneCS.Condition.Value == 0 then
			task.spawn(buysystem, NoneCS, 0)
		elseif NoneCS.Condition.Value == 1 then
			sectionate()
			updateCScondition(NoneCS.CCD.Value, 2)
			NoneCS.Condition.Value = 2
			ClassBB.Text = "Unequip"
		elseif NoneCS.Condition.Value == 2 then
			updateCScondition(NoneCS.CCD.Value, 1)
			NoneCS.Condition.Value = 1
			ClassBB.Text = "Equip"
		end
	elseif Classrn == FisherCS then
		if FisherCS.Condition.Value == 0 then
			task.spawn(buysystem, FisherCS, 30)
		elseif FisherCS.Condition.Value == 1 then
			sectionate()
			updateCScondition(FisherCS.CCD.Value, 2)
			FisherCS.Condition.Value = 2
			ClassBB.Text = "Unequip"
		elseif FisherCS.Condition.Value == 2 then
			updateCScondition(FisherCS.CCD.Value, 1)
			FisherCS.Condition.Value = 1
			ClassBB.Text = "Equip"
		end
	elseif Classrn == ZenseiCS then
		if ZenseiCS.Condition.Value == 0 then
			task.spawn(buysystem, ZenseiCS, 45)
		elseif ZenseiCS.Condition.Value == 1 then
			sectionate()
			updateCScondition(ZenseiCS.CCD.Value, 2)
			ZenseiCS.Condition.Value = 2
			ClassBB.Text = "Unequip"
		elseif ZenseiCS.Condition.Value == 2 then
			updateCScondition(ZenseiCS.CCD.Value, 1)
			ZenseiCS.Condition.Value = 1
			ClassBB.Text = "Equip"
		end
	end
end)
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local ACgui = script.Parent.AccecoryBox
local ACEvent = repstor.SaveAva
local ACHEvent = repstor.SaveAvaHat

--> SETUP <--
local plr = game.Players.LocalPlayer
local Chrc = plr.Character or plr.CharacterAdded:Wait()
local ChShirtTexture = Chrc:WaitForChild("Torso"):WaitForChild("roblox")
local ChShirtColor = Chrc["Body Colors"]

local Vwcam = Instance.new("Camera"); Vwcam.Parent = ACgui.ViewportFrame
Vwcam.CFrame = CFrame.new(0, -2, 0)
ACgui.ViewportFrame.CurrentCamera = Vwcam

Chrc.Archivable = true

local CloneChrc = Chrc:Clone()
CloneChrc.Parent = ACgui.ViewportFrame.WorldModel
CloneChrc.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
CloneChrc:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, 0, -6.5), Vector3.new(0, 0, 0)))

local ShirtTexture = CloneChrc:WaitForChild("Torso"):WaitForChild("roblox")
local ShirtColor = CloneChrc:WaitForChild("Body Colors")

--> OPENGUI <--
repstor.OpenShopGUI.Event:Connect(function(Tipe)
	if Tipe == 4 then
		ACgui.Visible = true

	end
end)

repstor.CloseShopGUI.Event:Connect(function(Tipe)
	if Tipe == 4 then
		ACgui.Visible = false
	end
end)

--> Shirts & Hats <--
local ShirtBar = ACgui.Shirt.OuterBar
local HatBar = ACgui.Hat.OuterBar
local ShirtBB = ACgui.Shirt.BuyFrame.TextButton
local HatBB = ACgui.Hat.BuyFrame.TextButton
local ShirtNem = ACgui.Shirt.BuyFrame.TextLabel
local HatNem = ACgui.Hat.BuyFrame.TextLabel

local currentS = 0
local currentH = 0

local TunicS = ShirtBar.TunicS
local BeachS = ShirtBar.BeachS
-----------------------------------------------
-----------------------------------------------
--> Buttons
local PaperH = HatBar.Paper
local TopHatH = HatBar["Top Hat"]

--> MyAVATAR
local MyACCSS = Chrc:WaitForChild("Head"):WaitForChild("Accessories")

local MyPaperHM = MyACCSS:WaitForChild("PaperBag")
local MyTopHatHM = MyACCSS:WaitForChild("TopHat")
--> DisplayAVATAR
local DispACCSS = CloneChrc:WaitForChild("Head"):WaitForChild("Accessories")

local DispPaperHM = DispACCSS:WaitForChild("PaperBag")
local DispTopHatHM = DispACCSS:WaitForChild("TopHat")


---------------------------------------
local avadatahat = {}

local function setavahat(drip, cond)
	if cond == 1 then
		for _, v in ipairs(HatBar:GetChildren()) do
			if v:IsA("ImageButton") then
				if v.Tipe.Value == drip then
					v.NotOwned.Visible = false
				end
			end
		end
	elseif cond == 2 then
		if drip == "a" then
			DispPaperHM.Transparency = 0
			repstor.ChangeHat:FireServer(MyACCSS, MyPaperHM, 0)
		elseif drip == "b" then
			DispTopHatHM.Transparency = 0
			repstor.ChangeHat:FireServer(MyACCSS, MyTopHatHM, 0)
		end
	end
end

ACHEvent.OnClientEvent:Connect(function(data)
	avadatahat = data
	PaperH.Condition.Value = avadatahat.a
	TopHatH.Condition.Value = avadatahat.b
	for drip, cond in pairs(data) do
		if cond > 0 then
			setavahat(drip, cond)
		end
	end
end)

local function hatsavechange(hat, cond)
	avadatahat[hat] = cond
	ACHEvent:FireServer(avadatahat)
end
---------------------------------------
local avadatashirt = {}

local function setavashirt(drip, cond)
	if cond == 1 then
		for _, v in ipairs(ShirtBar:GetChildren()) do
			if v:IsA("ImageButton") then
				if v.Tipe.Value == drip then
					v.NotOwned.Visible = false
				end
			end
		end
	elseif cond == 2 then
		if drip == "a" then
			ShirtTexture.Texture = "rbxassetid://10814793057"
			ShirtColor.TorsoColor3 = Color3.new(0.4, 0.2, 0.15)
			repstor.ChangeDrip:FireServer("rbxassetid://10814793057", Color3.new(0.4, 0.2, 0.15), 0, ChShirtTexture, ChShirtColor)
		elseif drip == "b" then
			ShirtTexture.Texture = "rbxassetid://18818237096"
			ShirtColor.TorsoColor3 = Color3.new(0.3, 0.8, 0.9)
			repstor.ChangeDrip:FireServer("rbxassetid://18818237096", Color3.new(0.3, 0.8, 0.9), 0, ChShirtTexture, ChShirtColor)
		end
	end
end

ACEvent.OnClientEvent:Connect(function(data)
	avadatashirt = data
	TunicS.Condition.Value = avadatashirt.a
	BeachS.Condition.Value = avadatashirt.b
	for drip, cond in pairs(data) do
		if cond > 0 then
			setavashirt(drip, cond)
		end
	end
end)

local function shirtsavechange(shirt, cond)
	avadatashirt[shirt] = cond
	ACEvent:FireServer(avadatashirt)
end
---------------------------------------
--> ABOUT MONEEH <---
local Yap = script.Parent.Parent.NPCui.Yap
local tweenserv = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweeninfo2 = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

local moneycount = script.Parent.Parent.MainGUI.duid.Money

local function buyshirt(shirt, price, button)
	local moneynow = moneycount.Value - price
	if moneynow >= 0 then
		repstor.ChangeMoney:FireServer(-price)
		shirtsavechange(shirt, 1)
		button.Condition.Value = 1
		button.NotOwned.Visible = false
		ShirtBB.Text = "Equip"
		Yap.Text = '<font color="#FFA500">Jib:</font> <font color="#FFFFFF">Oh you look fabulous with it!</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	else
		Yap.Text = '<font color="#FFA500">Jib:</font> <font color="#FFFFFF">I guess you can buy it later...</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end

local function buyhat(hat, price, button)
	local moneynow = moneycount.Value - price
	if moneynow >= 0 then
		repstor.ChangeMoney:FireServer(-price)
		hatsavechange(hat, 1)
		button.Condition.Value = 1
		button.NotOwned.Visible = false
		HatBB.Text = "Equip"
		Yap.Text = '<font color="#FFA500">Jib:</font> <font color="#FFFFFF">Oh you look fabulous with it!</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	else
		Yap.Text = '<font color="#FFA500">Jib:</font> <font color="#FFFFFF">I guess you can buy it later...</font>'
		tweenserv:Create(Yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(Yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(Yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(Yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end
---------------------------------------
local function diffrenciate()
	for _, p in ipairs(ACgui:GetDescendants()) do
		if p.Name == "Condition" then
			if p.Value == 2 then
				p.Value = 1
				shirtsavechange(p.Parent.Tipe.Value, 1)
			end
		end
	end
end

TunicS.Activated:Connect(function()
	currentS = TunicS
	ShirtNem.Text = "Tunic Shirt"
	ShirtTexture.Texture = "rbxassetid://10814793057"
	ShirtColor.TorsoColor3 = Color3.new(0.4, 0.2, 0.15)
	if TunicS.Condition.Value == 0 then
		ShirtBB.Text = "bug"
	elseif TunicS.Condition.Value == 1 then
		ShirtBB.Text = "Equip"
	elseif TunicS.Condition.Value == 2 then
		ShirtBB.Text = "Unequip"
	end
end)
BeachS.Activated:Connect(function()
	currentS = BeachS
	ShirtNem.Text = "Beach Shirt"
	ShirtTexture.Texture = "rbxassetid://18818237096"
	ShirtColor.TorsoColor3 = Color3.new(0.3, 0.8, 0.9)
	print("beach is " .. BeachS.Condition.Value)
	if BeachS.Condition.Value == 0 then
		ShirtBB.Text = "5"
	elseif BeachS.Condition.Value == 1 then
		ShirtBB.Text = "Equip"
	elseif BeachS.Condition.Value == 2 then
		ShirtBB.Text = "Unequip"
	end
end)
-------------------------------------------------------------------------------
ShirtBB.Activated:Connect(function()
	if currentS == TunicS then
		if TunicS.Condition.Value == 0 then
			buyshirt("a", 0, TunicS)
		elseif TunicS.Condition.Value == 1 then
			diffrenciate()
			shirtsavechange("a", 2)
			repstor.ChangeDrip:FireServer("rbxassetid://10814793057", Color3.new(0.4, 0.2, 0.15), 0, ChShirtTexture, ChShirtColor)
			TunicS.Condition.Value = 2
			ShirtBB.Text = "Unequip"
		elseif TunicS.Condition.Value == 2 then
			shirtsavechange("a", 1)
			repstor.ChangeDrip:FireServer("rbxassetid://10814793057", Color3.fromRGB(13, 105, 172), 1, ChShirtTexture, ChShirtColor)
			TunicS.Condition.Value = 1
			ShirtBB.Text = "Equip"
		end
	elseif currentS == BeachS then
		if BeachS.Condition.Value == 0 then
			buyshirt("b", 10, BeachS)
		elseif BeachS.Condition.Value == 1 then
			diffrenciate()
			shirtsavechange("b", 2)
			repstor.ChangeDrip:FireServer("rbxassetid://18818237096", Color3.new(0.3, 0.8, 0.9), 0, ChShirtTexture, ChShirtColor)
			BeachS.Condition.Value = 2
			ShirtBB.Text = "Unequip"
		elseif BeachS.Condition.Value == 2 then
			shirtsavechange("b", 1)
			repstor.ChangeDrip:FireServer("rbxassetid://18818237096", Color3.fromRGB(13, 105, 172), 1, ChShirtTexture, ChShirtColor)
			BeachS.Condition.Value = 1
			ShirtBB.Text = "Equip"
		end
	end
end)
--===========================================->>>><<<<<-====
--===========================================->>>><<<<<-====
--===========================================->>>><<<<<-====
local function Hr()
	for _, hv in ipairs(HatBar:GetDescendants()) do
		if hv:IsA("ImageButton") then
			if hv.Condition.Value == 2 then
				hv.Condition.Value = 1
				hatsavechange(hv.Parent.Tipe.Value, 1)
			end
		end
	end
end

local function Hmr()
	for _, hmv in ipairs(DispACCSS:GetChildren()) do
		hmv.Transparency = 1
	end
end

PaperH.Activated:Connect(function()
	currentH = PaperH
	HatNem.Text = "Paper Bag"
	if PaperH.Condition.Value == 0 then
		HatBB.Text = "bug"
		Hmr()
		DispPaperHM.Transparency = 0
	elseif PaperH.Condition.Value == 1 then
		HatBB.Text = "Equip"
		Hmr()
		DispPaperHM.Transparency = 0
	elseif PaperH.Condition.Value == 2 then
		HatBB.Text = "Unequip"
		Hmr()
		DispPaperHM.Transparency = 0
	end
end)
TopHatH.Activated:Connect(function()
	currentH = TopHatH
	HatNem.Text = "Top Hat"
	if TopHatH.Condition.Value == 0 then
		HatBB.Text = "10"
		Hmr()
		DispTopHatHM.Transparency = 0
	elseif TopHatH.Condition.Value == 1 then
		HatBB.Text = "Equip"
		Hmr()
		DispTopHatHM.Transparency = 0
	elseif TopHatH.Condition.Value == 2 then
		HatBB.Text = "Unequip"
		Hmr()
		DispTopHatHM.Transparency = 0
	end
end)
---------------------------------------------------------------------------------------------------------
HatBB.Activated:Connect(function()
	if currentH == PaperH then
		if PaperH.Condition.Value == 0 then
			buyhat("a", 0, PaperH)
		elseif PaperH.Condition.Value == 1 then
			Hr()
			hatsavechange("a", 2)
			repstor.ChangeHat:FireServer(MyACCSS, MyPaperHM, 0)
			PaperH.Condition.Value = 2
			HatBB.Text = "Unequip"
		elseif PaperH.Condition.Value == 2 then
			repstor.ChangeHat:FireServer(MyACCSS, MyPaperHM, 1)
			PaperH.Condition.Value = 1
			HatBB.Text = "Equip"
		end
	elseif currentH == TopHatH then
		if TopHatH.Condition.Value == 0 then
			buyhat("b", 10, TopHatH)
		elseif TopHatH.Condition.Value == 1 then
			Hr()
			hatsavechange("b", 2)
			repstor.ChangeHat:FireServer(MyACCSS, MyTopHatHM, 0)
			TopHatH.Condition.Value = 2
			HatBB.Text = "Unequip"
		elseif TopHatH.Condition.Value == 2 then
			repstor.ChangeHat:FireServer(MyACCSS, MyTopHatHM, 1)
			TopHatH.Condition.Value = 1
			HatBB.Text = "Equip"
		end
	end
end)

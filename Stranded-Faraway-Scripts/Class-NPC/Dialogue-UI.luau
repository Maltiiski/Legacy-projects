repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local chatbox = script.Parent.ChatSquare
local myPP = workspace:WaitForChild("ClassPP"):WaitForChild("ProximityPrompt")
local currenttipe
local talksound = script.Parent.Talk

local askB = chatbox:WaitForChild("Ask")
local buyB = chatbox:WaitForChild("Buy")
local byeB = chatbox:WaitForChild("Bye")

local yap = script.Parent.Yap
local tweenserv = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweeninfo2 = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

local camera = workspace.CurrentCamera
local blur = game.Lighting:WaitForChild("ShopBlur")

local exitB = script.Parent.Exit

exitB.Visible = false

repstor.NPCInteract.Event:Connect(function(Tipe)
	currenttipe = tonumber(Tipe)
	chatbox.Visible = true
	if tonumber(Tipe) == 2 then
		print("class bisa")
		myPP.Enabled = false
		askB.Text = "[What is class for?]"
		buyB.Text = "[I'd like to buy class]"
		talksound:Play()

		yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">You should get a class!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

local function zoomOut()
	tweenserv:Create(camera, TweenInfo.new(3.3), {FieldOfView = 70}):Play()
end

askB.Activated:Connect(function()
	if currenttipe == 2 then
		talksound:Play()
		yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">A class gives you buffs and starting items</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

buyB.Activated:Connect(function()
	if currenttipe == 2 then
		talksound:Play()
		chatbox.Visible = false
		exitB.Visible = true
		repstor.OpenShopGUI:Fire(currenttipe)
		yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">Give me your</font> <font color="##FFFF00">Marks!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

byeB.Activated:Connect(function()
	if currenttipe == 2 then
		talksound:Play()
		chatbox.Visible = false
		exitB.Visible = false
		myPP.Enabled = true
		repstor.CloseShopGUI:Fire(currenttipe)
		zoomOut()
		yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">Goodluck!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

exitB.Activated:Connect(function()
	if currenttipe == 2 then
		talksound:Play()
		chatbox.Visible = false
		exitB.Visible = false
		myPP.Enabled = true
		repstor.CloseShopGUI:Fire(currenttipe)
		zoomOut()
		yap.Text = '<font color="#FFA500">Skiv:</font> <font color="#FFFFFF">Goodluck!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local chatbox = script.Parent.ChatSquare
local myPP = workspace:WaitForChild("ItemPP"):WaitForChild("ProximityPrompt")
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
	if tonumber(Tipe) == 3 then
		print("item bisa")
		myPP.Enabled = false
		askB.Text = "[What are items for?]"
		buyB.Text = "[I want to buy items]"
		talksound:Play()

		yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">Bring items to your challenge!</font>'
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
	if currenttipe == 3 then
		talksound:Play()
		yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">Starting items that can ease your journey, one life usage tho</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

buyB.Activated:Connect(function()
	if currenttipe == 3 then
		talksound:Play()
		chatbox.Visible = false
		exitB.Visible = true
		repstor.OpenShopGUI:Fire(currenttipe)
		yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">Alright, business it is!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

byeB.Activated:Connect(function()
	if currenttipe == 3 then
		talksound:Play()
		chatbox.Visible = false
		exitB.Visible = false
		myPP.Enabled = true
		repstor.CloseShopGUI:Fire(currenttipe)
		zoomOut()
		yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">Dont die too early!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

exitB.Activated:Connect(function()
	if currenttipe == 3 then
		talksound:Play()
		chatbox.Visible = false
		exitB.Visible = false
		myPP.Enabled = true
		repstor.CloseShopGUI:Fire(currenttipe)
		zoomOut()
		yap.Text = '<font color="#FFA500">Rasp:</font> <font color="#FFFFFF">Dont die too early!</font>'
		tweenserv:Create(yap, tweeninfo, {BackgroundTransparency = 0.2}):Play()
		tweenserv:Create(yap, tweeninfo, {TextTransparency = 0}):Play()
		task.wait(3)
		tweenserv:Create(yap, tweeninfo2, {BackgroundTransparency = 1}):Play()
		tweenserv:Create(yap, tweeninfo2, {TextTransparency = 1}):Play()
	end
end)

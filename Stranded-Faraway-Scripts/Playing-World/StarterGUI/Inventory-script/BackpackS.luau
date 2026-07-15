local repstor = game.ReplicatedStorage
local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local Charc = plr.Character
local humanoid = Charc.Humanoid
local mouse = plr:GetMouse()

local tweenserv = game:GetService("TweenService")
local tweeninf = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)

local BackPackB = script.Parent.Backpack
local InventoryBag = script.Parent.InventoryMenu
local Charshow = InventoryBag.CharShow
local bagcond = 0

-------> SETUP <---------
InventoryBag.Position = UDim2.new(0.38, 0, 2, 0)
InventoryBag.UIStroke.Transparency = 1
InventoryBag.BackgroundTransparency = 1
Charshow.UIStroke.Transparency = 1
Charshow.BackgroundTransparency = 1

local slotcop = InventoryBag.MainInventory.Slot6
for i = 7, 15 do
	local clone = slotcop:Clone()
	clone.Parent = InventoryBag.MainInventory
	clone.Name = "Slot" .. i
	local nomorVal = clone.Nomor
	nomorVal.Value = i
end
-------------------------

local function DoBackPack(act)
	--> FirstPos = {0.38, 0},{2, 0}
	--> LastPos = {0.38, 0},{0.4, 0}
	if act == 1 then
		bagcond = 1
		--UIS.MouseBehavior = Enum.MouseBehavior.Default
		--UIS.MouseIconEnabled = true
		tweenserv:Create(Charshow.UIStroke, tweeninf, {Transparency = 0.2}):Play()
		tweenserv:Create(Charshow, tweeninf, {BackgroundTransparency = 0.2}):Play()
		--
		tweenserv:Create(InventoryBag.UIStroke, tweeninf, {Transparency = 0.2}):Play()
		tweenserv:Create(InventoryBag, tweeninf, {Position = UDim2.new(0.38, 0, 0.4, 0), BackgroundTransparency = 0.2}):Play()
	else
		bagcond = 0
		--UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
		--UIS.MouseIconEnabled = false
		tweenserv:Create(Charshow.UIStroke, tweeninf, {Transparency = 1}):Play()
		tweenserv:Create(Charshow, tweeninf, {BackgroundTransparency = 1}):Play()
		--
		tweenserv:Create(InventoryBag.UIStroke, tweeninf, {Transparency = 1}):Play()
		tweenserv:Create(InventoryBag, tweeninf, {Position = UDim2.new(0.38, 0, 2, 0), BackgroundTransparency = 1}):Play()
	end
end 

BackPackB.Activated:Connect(function()
	if bagcond == 0 then
		DoBackPack(1)
	else
		DoBackPack(0)
	end
end)

UIS.InputBegan:Connect(function(input, gameprocessed)
	if  gameprocessed then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.E then
			if bagcond == 0 then
				DoBackPack(1)
			else
				DoBackPack(0)
			end
		end
	end
end)

local currentclicked
for _, b in ipairs(InventoryBag.MainInventory:GetChildren()) do
	if b:IsA("ImageButton") then
		if b.Quantiti.Text == "0" then
			b.Quantiti.Visible = false
		end
		b.MouseEnter:Connect(function()
			currentclicked = b
		end)
		b.MouseLeave:Connect(function()
			currentclicked = nil
		end)
	end
end
for _, rb in ipairs(InventoryBag.HotBarReplica:GetChildren()) do
	if rb:IsA("ImageButton") then
		if rb.Quantiti.Text == "0" then
			rb.Quantiti.Visible = false
		end
		rb.MouseEnter:Connect(function()
			currentclicked = rb
		end)
		rb.MouseLeave:Connect(function()
			currentclicked = nil
		end)
	end
end


local datadrag = script.Parent.DragIm
local ButtoninUse
UIS.InputBegan:Connect(function(input, gameprocessed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		task.wait()
		if currentclicked then
			datadrag.Visible = true
			datadrag.Image = currentclicked.Image
			ButtoninUse = currentclicked
			currentclicked = nil
		end
	end
end)

UIS.InputEnded:Connect(function(input, gameprocessed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		datadrag.Visible = false
		if currentclicked then
			local datasave = {}
			table.insert(datasave, ButtoninUse.Image)
			ButtoninUse.Image = currentclicked.Image
			currentclicked.Image = datasave[1]
			
			repstor.SwitchHotbar:Fire(string.match(ButtoninUse.Name, "%d+"), string.match(currentclicked.Name, "%d+"))
		end
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	datadrag.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
end)

---------------------------------------------------------
----> DISPLAY ITEM <----
local displayFR = script.Parent.InventoryMenu.CharShow.ViewportFrame
local displayworld = displayFR.WorldModel

local VWcam = Instance.new("Camera"); VWcam.Parent = displayFR
VWcam.CFrame = CFrame.new(0, 0, 0)
displayFR.CurrentCamera = VWcam

local function DISPLAYTHISthing(button)
	local index = tonumber(string.match(button.Name, "%d+"))
	for _, things in ipairs(displayworld:GetChildren()) do
		if things:IsA("Tool") then
			things:Destroy()
		end
	end
	local dastool
	for _, tool in ipairs(plr.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			if tool.PosH.Value == index then
				dastool = tool
			end
		end
	end
	for _, tool in ipairs(workspace:GetChildren()) do
		if tool:IsA("Tool") then
			if tool.PosH.Value == index then
				dastool = tool
			end
		end
	end
	if dastool then
		local clonetool = dastool:Clone(); clonetool.Parent = displayworld
		dastool.Archivable = true
		clonetool.Handle.Anchored = true
		clonetool.Handle.CFrame = CFrame.new(Vector3.new(0, 0, -4), Vector3.new(0, 0, 0))
		clonetool.Handle.CFrame = clonetool.Handle.CFrame * CFrame.Angles(0, math.rad(60), 0)
		local handel = clonetool:FindFirstChild("Handle")
		while clonetool do
			task.wait()
			if clonetool and handel then
				handel.CFrame = clonetool.Handle.CFrame * CFrame.Angles(0, math.rad(1), 0)
			end
		end
	end
end

for _, b in ipairs(InventoryBag.MainInventory:GetChildren()) do
	if b:IsA("ImageButton") then
		b.Activated:Connect(function()
			DISPLAYTHISthing(b)
		end)
	end
end
for _, rb in ipairs(InventoryBag.HotBarReplica:GetChildren()) do
	if rb:IsA("ImageButton") then
		rb.Activated:Connect(function()
			DISPLAYTHISthing(rb)
		end)
	end
end

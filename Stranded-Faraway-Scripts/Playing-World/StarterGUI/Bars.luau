local repstor = game.ReplicatedStorage

local HealthBar = script.Parent.HealthBar
local HungerBar = script.Parent.HungerBar
local EnergyBar = script.Parent.EnergyBar
local DurBar = script.Parent["Durability Bar"]

--> DAYAREA
local GAMEUIS = script.Parent.Parent.GAMEUI
local Daycounter = GAMEUIS.DaysCounter

local HAnimBar = HealthBar.AnimBar

local HungerVal = HungerBar.Value
local EnergyVal = EnergyBar.Value

local locplr = game.Players.LocalPlayer
local Chrc = locplr.Character
local Humanoid = Chrc:FindFirstChild("Humanoid")
local Mous = locplr:GetMouse()
local RunS = game:GetService("RunService")

local isStanding = 2

RunS.RenderStepped:Connect(function()
	if Humanoid.MoveDirection.Magnitude > 0 then
		isStanding = 1
	else
		isStanding = 2
	end
	
	local target = Mous.Target
	if not target then
		DurBar.Visible = false
		return
	end

	local char = Chrc
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local dist = (hrp.Position - target.Position).Magnitude
	if dist > 20 then
		DurBar.Visible = false
		return
	end

	local hp = target.Parent:FindFirstChild("HP")
	local max = target.Parent:FindFirstChild("Maxhp")

	if hp and max then
		local percent = math.clamp(hp.Value / max.Value, 0, 1)

		DurBar.Visible = true
		DurBar.Bar.Size = UDim2.new(percent, 0, 1, 0)
		DurBar.percent.Text = string.format("%d%%", math.floor(percent * 100))
	else
		DurBar.Visible = false
	end
end)

game.UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.H then
		Chrc.Humanoid.Health -= 10
	end
end)

Chrc.Humanoid.HealthChanged:Connect(function()
	local PercentHP = math.clamp(Chrc.Humanoid.Health / 100, 0, 1)
	HealthBar.Bar.Size = UDim2.new(PercentHP, 0, 1, 0)
	
	local tweenserv = game:GetService("TweenService")
	local tweeninfo1 = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 0, false, 0)
	tweenserv:Create(HAnimBar, tweeninfo1, {Size = HealthBar.Bar.Size}):Play()
end)

local OnRun = false
local function DecEnergy()
	Chrc.Humanoid.WalkSpeed = 25
	repeat
		task.wait()
		EnergyVal.Value -= 0.3
		local Percent = math.clamp(EnergyVal.Value / 100, 0, 1)
		EnergyBar.Bar.Size = UDim2.new(Percent, 0, 1, 0)
	until OnRun == false or EnergyVal.Value < 0.1
	Chrc.Humanoid.WalkSpeed =16
end
local function AddEnergy()
	Chrc.Humanoid.WalkSpeed = 16
	repeat
		task.wait()
		EnergyVal.Value += 0.05 * isStanding
		local Percent = math.clamp(EnergyVal.Value / 100, 0, 1)
		EnergyBar.Bar.Size = UDim2.new(Percent, 0, 1, 0)
	until OnRun == true or EnergyVal.Value > 99.9
end

game.UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Y then
		OnRun = true
		DecEnergy()
	end
end)

game.UserInputService.InputEnded:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Y then
		OnRun = false
		AddEnergy()
	end
end)

local function SETHUNGERBAR()
	while true do
		task.wait(10)
		HungerVal.Value -= 0.5
		local percent = math.clamp(HungerVal.Value / 100, 0, 1)
		HungerBar.Bar.Size = UDim2.new(percent, 0, 1, 0)
	end
end
local function REGENHEALTH()
	while true do
		task.wait(2)
		if Chrc.Humanoid.Health < 100 and HungerVal.Value > 70 then
			Chrc.Humanoid.Health += 1
		end
	end
end

local daycountrn = 1
repstor.DaySender.OnClientEvent:Connect(function(newday)
	if newday == true then
		daycountrn += 1
		local tweenserv = game:GetService("TweenService")
		local tweeninfo1 = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
		tweenserv:Create(Daycounter, tweeninfo1, {Position = UDim2.new(0.5, 0,0.2, 0)}):Play()
		task.wait(2)
		tweenserv:Create(Daycounter, tweeninfo1, {TextSize = 70}):Play()
		task.wait(1.5)
		Daycounter.Text = "[DAY #" .. daycountrn .. "]"
		task.wait(1.5)
		tweenserv:Create(Daycounter, tweeninfo1, {TextSize = 32}):Play()
		task.wait(2)
		tweenserv:Create(Daycounter, tweeninfo1, {Position = UDim2.new(0.5, 0,0.07, 0)}):Play()
	end
end)

task.spawn(SETHUNGERBAR)
task.spawn(REGENHEALTH)

local repstor = game.ReplicatedStorage

local plr = game.Players
local locplr = plr.LocalPlayer
local chrc = locplr.Character
local Backpack = locplr.Backpack

local WidgetsUI = script.Parent.Widgets
local CookwCF = WidgetsUI.CookwCampfire
local BGfuel = CookwCF.BGFuel
local FuelBar = BGfuel.Fuel
local FuelDis = BGfuel.FireDisplay.FireImage

local Papar = CookwCF.Paper
local RSF = Papar.Recipes
local DisplayITM = Papar.ItemCDisplay
local Res1Display = Papar.Resource1Display
local Res2Display = Papar.Resource2Display

local CookB = Papar.CookB
local Exitb = CookwCF.ExitB

local CurrentFuel = 0
local CurrentCF = nil

CookwCF.Visible = false

local fuelly

Exitb.Activated:Connect(function()
	CookwCF.Visible = false
	CurrentFuel = 0
	CurrentCF = nil
	chrc.Humanoid.WalkSpeed = 16
end)

local function CheckFuel(FQ)
	CurrentFuel = FQ
	FuelBar.Fuel1.BackgroundColor3 = Color3.new(0.65, 0.65, 0.65)
	FuelBar.Fuel2.BackgroundColor3 = Color3.new(0.65, 0.65, 0.65)
	FuelBar.Fuel3.BackgroundColor3 = Color3.new(0.65, 0.65, 0.65)
	FuelBar.Fuel4.BackgroundColor3 = Color3.new(0.65, 0.65, 0.65)
	
	if FQ > 0 then
		for i=1, FQ do
			local currentFuel = FuelBar:FindFirstChild("Fuel" .. i)
			currentFuel.BackgroundColor3 = Color3.new(1, 0.5, 0.25)
		end
		FuelDis.Visible = true
	else
		FuelDis.Visible = false
	end
	FuelDis.Size = UDim2.new(FQ / 4, 0, FQ / 4, 0)
	
end

local function OpenCF()
	for _, CF in ipairs(workspace:GetChildren()) do
		if CF.Name == "Campfire B" then
			local PxPr = CF:FindFirstChild("PxPr")
			if PxPr then
				PxPr.Triggered:Connect(function(plr)
					if plr == locplr then
						chrc.Humanoid.WalkSpeed = 0
						CurrentCF = CF
						CookwCF.Visible = true
						local FuelCount = CF:FindFirstChild("Fuel")
						CheckFuel(FuelCount.Value)
						
						CF.Fuel.Changed:Connect(function()
							CheckFuel(FuelCount.Value)
						end)
					end
				end)
			end
		end
	end
end

OpenCF()
workspace.ChildAdded:Connect(function()
	OpenCF()
end)

local function turnonREFUELMD(state)
	for _, CMPFR in ipairs(workspace:GetChildren()) do
		if CMPFR.Name == "Campfire B" then
			if state == true then
				CMPFR.PxPr.Enabled = false
				CMPFR.Refuel.Enabled = true
			else
				CMPFR.PxPr.Enabled = true
				CMPFR.Refuel.Enabled = false
			end
		end
	end
end

local function RefuelSystem(cmf)
	local refpxpr = cmf:FindFirstChild("Refuel")
	local Fuel = cmf:FindFirstChild("Fuel")
	refpxpr.Triggered:Connect(function(plr)
		if plr == locplr  and Fuel.Value < 4 then
			fuelly.Quantity.Value -= 1
			local des = false
			if fuelly.Quantity.Value < 1 then
				des = true
			end
			repstor.Cook:FireServer(cmf, fuelly, des, fuelly.PosH.Value)
		end
	end)
end

for _, cmf in ipairs(workspace:GetChildren()) do
	if cmf.Name == "Campfire B" then
		RefuelSystem(cmf)
	end
end
workspace.ChildAdded:Connect(function(cmf)
	if cmf.Name == "Campfire B" then
		RefuelSystem(cmf)
	end
end)

chrc.ChildRemoved:Connect(function(v2)
	if v2.Name == "Coal" then
		turnonREFUELMD(false)
		fuelly = nil
	end
end)
chrc.ChildAdded:Connect(function(v)
	if v.Name == "Coal" then
		task.wait()
		turnonREFUELMD(true)
		fuelly = v
	end
end)

for _, RB in ipairs(RSF:GetChildren()) do
	if RB:IsA("Frame") then
		RB.Next.Activated:Connect(function()
			local NEXTB = RB:FindFirstChild("Next")
			local RBItmIMG = RB:FindFirstChild("ItemIMG")
			local Res1IMG = RB:FindFirstChild("Resource1IMG")
			local Res2IMG = RB:FindFirstChild("Resource2IMG")
			
			DisplayITM.Image = "rbxassetid://279038228"
			Res1Display.Image = "rbxassetid://279038228"
			Res2Display.Image = "rbxassetid://279038228"
			
			DisplayITM.Quantity.Text = 0
			Res1Display.Quantity.Text = 0
			Res2Display.Quantity.Text = 0
			
			DisplayITM.Quantity.Visible = false
			Res1Display.Quantity.Visible = false
			Res2Display.Quantity.Visible = false
			
			DisplayITM:SetAttribute("Nema", nil)
			Res1Display:SetAttribute("Nema", nil)
			Res2Display:SetAttribute("Nema", nil)
			
			DisplayITM.Image = RBItmIMG.Image
			DisplayITM.Quantity.Text = RBItmIMG.Quantity.Text
			DisplayITM:SetAttribute("Nema", RBItmIMG:GetAttribute("Nema"))
			DisplayITM.Quantity.Visible = true
			if Res1IMG then
				Res1Display.Image = Res1IMG.Image
				Res1Display.Quantity.Text = Res1IMG.Quantity.Text
				Res1Display:SetAttribute("Nema", Res1IMG:GetAttribute("Nema"))
				Res1Display.Quantity.Visible = true
			end
			if Res2IMG then
				Res2Display.Image = Res2IMG.Image
				Res2Display.Quantity.Text = Res2IMG.Quantity.Text
				Res2Display:SetAttribute("Nema", Res2IMG:GetAttribute("Nema"))
				Res2Display.Quantity.Visible = true
			end
		end)
	end
end

local function sendcraftitem(item, Qua)
	for i=1, Qua do
		repstor.CraftInfo:FireServer(repstor:FindFirstChild(item), false)
		task.wait(0.05)
	end
end

local function deductres(res, Qua)
	for i=1, Qua do
		local Des
		res.Quantity.Value -= 1
		if res.Quantity.Value < 1 then
			Des = true
		else
			Des = false
		end
		repstor.CraftInfo:FireServer(res, true, Des, res.PosH.Value)
	end
end

CookB.Activated:Connect(function()
	local Vof1 = nil
	local Vof2 = nil

	Res1Display.Quantity.TextColor3 = Color3.new(1, 0, 0)
	Res2Display.Quantity.TextColor3 = Color3.new(1, 0, 0)

	local DII = DisplayITM:GetAttribute("Nema")
	local NR1 = Res1Display:GetAttribute("Nema")
	local NR2 = Res2Display:GetAttribute("Nema")

	for _, v in ipairs(Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.Name == NR1 then
				if v.Quantity.Value >= tonumber(Res1Display.Quantity.Text) then
					Res1Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof1 = v
				end
			elseif v.Name == NR2 then
				if v.Quantity.Value >= tonumber(Res2Display.Quantity.Text) then
					Res2Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof2 = v
				end
			end
		end
	end

	for _, v in ipairs(chrc:GetChildren()) do
		if v:IsA("Tool") and v.PosH.Value > 0 then
			if v.Name == NR1 then
				if v.Quantity.Value >= tonumber(Res1Display.Quantity.Text) then
					Res1Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof1 = v
				end
			elseif v.Name == NR2 then
				if v.Quantity.Value >= tonumber(Res2Display.Quantity.Text) then
					Res2Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof2 = v
				end
			end
		end
	end


	if NR1 ~= nil and NR2 ~= nil  and Vof1 and Vof2 and CurrentFuel > 0 then
		deductres(Vof1, tonumber(Res1Display.Quantity.Text))
		deductres(Vof2, tonumber(Res2Display.Quantity.Text))
		sendcraftitem(DII, tonumber(DisplayITM.Quantity.Text))
		repstor.DecFuel:FireServer(CurrentCF)
	elseif NR1 ~= nil and NR2 == nil and Vof1 and CurrentFuel > 0 then
		deductres(Vof1, tonumber(Res1Display.Quantity.Text))
		sendcraftitem(DII, tonumber(DisplayITM.Quantity.Text))
		repstor.DecFuel:FireServer(CurrentCF)
	else
		print("too poor")
	end
end)

local repstor = game.ReplicatedStorage

local UIS = game:GetService("UserInputService")
local players = game.Players
local Locplr = players.LocalPlayer
local char = Locplr.Character or Locplr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local Backpack = Locplr.Backpack

local WidgetsSGUI = script.Parent.Widgets
local CraftingScreen = script.Parent.Widgets.CraftwTable
local paper = CraftingScreen.Paper
local RecipesBar = CraftingScreen.Recipe
local MainCraftB = paper.CraftB
local FolderRecipe = RecipesBar.BuildSaveRecipes
local ExitB = CraftingScreen.ExitB

CraftingScreen.Visible = false
paper.ItemCDisplay.Quantity.Visible = false
paper.Resource1Display.Quantity.Visible = false
paper.Resource2Display.Quantity.Visible = false
paper.Resource3Display.Quantity.Visible = false
paper.Resource4Display.Quantity.Visible = false

local line = RecipesBar.Line
local ToolB = RecipesBar.ToolB
local MaterialB = RecipesBar.MaterialB

local CurrentEQP

local function checkevryCT()
	for _, v in ipairs(workspace:GetChildren()) do
		if v.Name == "CraftingTable B" then
			v:FindFirstChild("PxPr").Triggered:Connect(function(plr)
				if plr ~= Locplr then return end
				CraftingScreen.Visible = true
				hum.WalkSpeed = 0
			end)
		end
	end
end

ExitB.Activated:Connect(function()
	CraftingScreen.Visible = false
	hum.WalkSpeed = 16
end)

checkevryCT()
workspace.ChildAdded:Connect(function(thing)
	if thing:IsA("Model") then
		checkevryCT()
	end
end)

local function RecipeAssign()
	for _, r in ipairs(RecipesBar.ScrollingFrame:GetChildren()) do
		if r:IsA("Frame") then
			local NextB = r:FindFirstChild("Next")
			local ItemIMG = r:FindFirstChild("ItemIMG")
			local Res1IMG = r:FindFirstChild("Resource1IMG")
			local Res2IMG = r:FindFirstChild("Resource2IMG")
			local Res3IMG = r:FindFirstChild("Resource3IMG")
			local Res4IMG = r:FindFirstChild("Resource4IMG")
			r:FindFirstChild("Next").Activated:Connect(function()
				paper.ItemCDisplay.Image = ItemIMG.Image
				paper.ItemCDisplay.Quantity.Text = ItemIMG.Quantity.Text
				paper.ItemCDisplay:SetAttribute("Nema", ItemIMG:GetAttribute("Nema"))
				paper.ItemCDisplay.Quantity.Visible = true

				paper.ItemCDisplay.Quantity.Visible = false
				paper.Resource1Display.Quantity.Visible = false
				paper.Resource2Display.Quantity.Visible = false
				paper.Resource3Display.Quantity.Visible = false
				paper.Resource4Display.Quantity.Visible = false

				paper.ItemCDisplay.Quantity.TextColor3 = Color3.new(1, 1, 1)
				paper.Resource1Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
				paper.Resource2Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
				paper.Resource3Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
				paper.Resource4Display.Quantity.TextColor3 = Color3.new(1, 1, 1)

				paper.Resource1Display.Image = "rbxassetid://279038228"
				paper.Resource2Display.Image = "rbxassetid://279038228"
				paper.Resource3Display.Image = "rbxassetid://279038228"
				paper.Resource4Display.Image = "rbxassetid://279038228"

				paper.Resource1Display:SetAttribute("Nema", nil)
				paper.Resource2Display:SetAttribute("Nema", nil)
				paper.Resource3Display:SetAttribute("Nema", nil)
				paper.Resource4Display:SetAttribute("Nema", nil)

				paper.Resource1Display.Quantity.Text = 0
				paper.Resource2Display.Quantity.Text = 0
				paper.Resource3Display.Quantity.Text = 0
				paper.Resource4Display.Quantity.Text = 0

				if Res1IMG then
					paper.Resource1Display.Image = Res1IMG.Image
					paper.Resource1Display.Quantity.Text = Res1IMG.Quantity.Text
					paper.Resource1Display:SetAttribute("Nema", Res1IMG:GetAttribute("Nema"))
					paper.Resource1Display.Quantity.Visible = true
				end
				if Res2IMG then
					paper.Resource2Display.Image = Res2IMG.Image
					paper.Resource2Display.Quantity.Text = Res2IMG.Quantity.Text
					paper.Resource2Display:SetAttribute("Nema", Res2IMG:GetAttribute("Nema"))
					paper.Resource2Display.Quantity.Visible = true
				end
				if Res3IMG then
					paper.Resource3Display.Image = Res3IMG.Image
					paper.Resource3Display.Quantity.Text = Res3IMG.Quantity.Text
					paper.Resource3Display:SetAttribute("Nema", Res3IMG:GetAttribute("Nema"))
					paper.Resource3Display.Quantity.Visible = true
				end
				if Res4IMG then
					paper.Resource4Display.Image = Res4IMG.Image
					paper.Resource4Display.Quantity.Text = Res4IMG.Quantity.Text
					paper.Resource4Display:SetAttribute("Nema", Res4IMG:GetAttribute("Nema"))
					paper.Resource4Display.Quantity.Visible = true
				end
			end)
		end
	end
end

local function showliner(moveit)
	local tweeninfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
	local tweenserv = game:GetService("TweenService")
	tweenserv:Create(line, tweeninfo, {Position = moveit}):Play()
end

RecipeAssign()
ToolB.Activated:Connect(function()
	showliner(UDim2.new(0.09, 0, 0.088, 0))
	for _, S2 in ipairs(RecipesBar.ScrollingFrame:GetChildren()) do
		if S2:IsA("Frame") then
			if S2:GetAttribute("Section") == 2 then
				S2.Parent = FolderRecipe
				S2.Visible = false
			end
		end
	end
	for _, S1 in ipairs(FolderRecipe:GetChildren()) do
		if S1:IsA("Frame") then
			if S1:GetAttribute("Section") == 1 then
				S1.Parent = RecipesBar.ScrollingFrame
				S1.Visible = true
			end
		end
	end
	RecipeAssign()
end)

MaterialB.Activated:Connect(function()
	showliner(UDim2.new(0.55, 0, 0.088, 0))
	for _, S1 in ipairs(RecipesBar.ScrollingFrame:GetChildren()) do
		if S1:IsA("Frame") then
			if S1:GetAttribute("Section") == 1 then
				S1.Parent = FolderRecipe
				S1.Visible = false
			end
		end
	end
	for _, S2 in ipairs(FolderRecipe:GetChildren()) do
		if S2:IsA("Frame") then
			if S2:GetAttribute("Section") == 2 then
				S2.Parent = RecipesBar.ScrollingFrame
				S2.Visible = true
			end
		end
	end
	RecipeAssign()
end)

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

MainCraftB.Activated:Connect(function()
	local Vof1 = nil
	local Vof2 = nil
	local Vof3 = nil
	local Vof4 = nil
	
	paper.Resource1Display.Quantity.TextColor3 = Color3.new(1, 0, 0)
	paper.Resource2Display.Quantity.TextColor3 = Color3.new(1, 0, 0)
	paper.Resource3Display.Quantity.TextColor3 = Color3.new(1, 0, 0)
	paper.Resource4Display.Quantity.TextColor3 = Color3.new(1, 0, 0)
	
	local DII = paper.ItemCDisplay:GetAttribute("Nema")
	local NR1 = paper.Resource1Display:GetAttribute("Nema")
	local NR2 = paper.Resource2Display:GetAttribute("Nema")
	local NR3 = paper.Resource3Display:GetAttribute("Nema")
	local NR4 = paper.Resource4Display:GetAttribute("Nema")
	
	for _, v in ipairs(Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.Name == NR1 then
				if v.Quantity.Value >= tonumber(paper.Resource1Display.Quantity.Text) then
					paper.Resource1Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof1 = v
				end
			elseif v.Name == NR2 then
				if v.Quantity.Value >= tonumber(paper.Resource2Display.Quantity.Text) then
					paper.Resource2Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof2 = v
				end
			elseif v.Name == NR3 then
				if v.Quantity.Value >= tonumber(paper.Resource3Display.Quantity.Text) then
					paper.Resource3Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof3 = v
				end
			elseif v.Name == NR4 then
				if v.Quantity.Value >= tonumber(paper.Resource4Display.Quantity.Text) then
					paper.Resource4Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof4 = v
				end
			end
		end
	end
	
	for _, v in ipairs(Locplr.Character:GetChildren()) do
		if v:IsA("Tool") and v.PosH.Value > 0 then
			if v.Name == NR1 then
				if v.Quantity.Value >= tonumber(paper.Resource1Display.Quantity.Text) then
					paper.Resource1Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof1 = v
				end
			elseif v.Name == NR2 then
				if v.Quantity.Value >= tonumber(paper.Resource2Display.Quantity.Text) then
					paper.Resource2Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof2 = v
				end
			elseif v.Name == NR3 then
				if v.Quantity.Value >= tonumber(paper.Resource3Display.Quantity.Text) then
					paper.Resource3Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof3 = v
				end
			elseif v.Name == NR4 then
				if v.Quantity.Value >= tonumber(paper.Resource4Display.Quantity.Text) then
					paper.Resource4Display.Quantity.TextColor3 = Color3.new(1, 1, 1)
					Vof4 = v
				end
			end
		end
	end
	
	
	if NR1 ~= nil and NR2 ~= nil and NR3 ~= nil and NR4 ~= nil and Vof1 and Vof2 and Vof3 and Vof4 then
		deductres(Vof1, tonumber(paper.Resource1Display.Quantity.Text))
		deductres(Vof2, tonumber(paper.Resource2Display.Quantity.Text))
		deductres(Vof3, tonumber(paper.Resource3Display.Quantity.Text))
		deductres(Vof4, tonumber(paper.Resource4Display.Quantity.Text))
		sendcraftitem(DII, tonumber(paper.ItemCDisplay.Quantity.Text))
	elseif NR1 ~= nil and NR2 ~= nil and NR3 ~= nil and NR4 == nil and Vof1 and Vof2 and Vof3 then
		deductres(Vof1, tonumber(paper.Resource1Display.Quantity.Text))
		deductres(Vof2, tonumber(paper.Resource2Display.Quantity.Text))
		deductres(Vof3, tonumber(paper.Resource3Display.Quantity.Text))
		sendcraftitem(DII, tonumber(paper.ItemCDisplay.Quantity.Text))
	elseif NR1 ~= nil and NR2 ~= nil and NR3 == nil and NR4 == nil  and Vof1 and Vof2 then
		deductres(Vof1, tonumber(paper.Resource1Display.Quantity.Text))
		deductres(Vof2, tonumber(paper.Resource2Display.Quantity.Text))
		sendcraftitem(DII, tonumber(paper.ItemCDisplay.Quantity.Text))
	elseif NR1 ~= nil and NR2 == nil and NR3 == nil and NR4 == nil and Vof1 then
		deductres(Vof1, tonumber(paper.Resource1Display.Quantity.Text))
		sendcraftitem(DII, tonumber(paper.ItemCDisplay.Quantity.Text))
	else
		print("too poor")
	end
end)

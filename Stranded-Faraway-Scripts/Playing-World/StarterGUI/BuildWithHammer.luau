local repstor = game.ReplicatedStorage

local UIS = game.UserInputService
local Locplr = game.Players.LocalPlayer
local Chrc = Locplr.Character
local mos = Locplr:GetMouse()
local Backpack = Locplr.Backpack
local Cam = workspace.CurrentCamera
local Lighteeng = game.Lighting

local WidgetSGUI = script.Parent.Widgets
local BuildMenu = WidgetSGUI.BuildingMenu

--===> SETUP <===---
WidgetSGUI.BuildB.Visible = false
WidgetSGUI.CancelB.Visible = false
BuildMenu.Visible = false
WidgetSGUI.MaterialsFrame.Visible = false
--------------------

local CurrentEQP
local isbuilding = false
local PrevNOW
local BuildToCopy
local canplace

local Vof1 = nil
local Vof2 = nil
local Vof3 = nil
local Vof4 = nil

WidgetSGUI.MaterialsFrame.Resc1:SetAttribute("Nema", nil)
WidgetSGUI.MaterialsFrame.Resc2:SetAttribute("Nema", nil)
WidgetSGUI.MaterialsFrame.Resc3:SetAttribute("Nema", nil)
WidgetSGUI.MaterialsFrame.Resc4:SetAttribute("Nema", nil)

local function QuitBuildMode()
	isbuilding = false
	WidgetSGUI.CancelB.Visible = false
	WidgetSGUI.MaterialsFrame.Visible = false
	PrevNOW:Destroy()
	if CurrentEQP and CurrentEQP.Name == "BuildHammer" then
		BuildMenu.Visible = true
		WidgetSGUI.BuildB.Visible = true
	end
	local Tweenserv = game:GetService("TweenService")
	local Tweeningfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local Tweeningfo2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	Tweenserv:Create(Cam, Tweeningfo, {FieldOfView = 70}):Play()

	local cc = Lighteeng:FindFirstChild("ZoomEffect") or Instance.new("ColorCorrectionEffect")
	cc.Name = "ZoomEffect"
	cc.Parent = Lighteeng
	local goal = {Contrast = 0, Saturation = 0}
	Tweenserv:Create(cc, Tweeningfo2, goal):Play()
end

Chrc.ChildAdded:Connect(function(v)
	if not v:IsA("Tool") then return end
	task.wait()
	CurrentEQP = v
	if CurrentEQP.Name == "BuildHammer" and isbuilding == false then
		WidgetSGUI.BuildB.Visible = true
	else
		WidgetSGUI.BuildB.Visible = false
		BuildMenu.Visible = false
	end
end)
Chrc.ChildRemoved:Connect(function(v)
	if not v:IsA("Tool") then return end
	if v.Name == "BuildHammer" then
		CurrentEQP = nil
		WidgetSGUI.BuildB.Visible = false
		BuildMenu.Visible = false
		if WidgetSGUI.MaterialsFrame.Visible == true then
			QuitBuildMode()
		end
	end
end)

WidgetSGUI.BuildB.Activated:Connect(function()
	if isbuilding == false then
		if BuildMenu.Visible == true then
			BuildMenu.Visible = false
		else
			BuildMenu.Visible = true
		end
	end
end)

WidgetSGUI.CancelB.Activated:Connect(function()
	QuitBuildMode()
end)

local RotationX = 0
local isrotating = 0

game:GetService("RunService").RenderStepped:Connect(function()
	if isrotating ~= 0 then
		RotationX += isrotating
	end
end)

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.B then
			if CurrentEQP and CurrentEQP.Name == "BuildHammer" and isbuilding == false then
				if BuildMenu.Visible == true then
					BuildMenu.Visible = false
				else
					BuildMenu.Visible = true
				end
			end
		elseif input.KeyCode == Enum.KeyCode.X and isbuilding == true then
			QuitBuildMode()
		elseif input.KeyCode == Enum.KeyCode.R and isbuilding == true then
			isrotating = 2
		elseif input.KeyCode == Enum.KeyCode.T and isbuilding == true then
			isrotating = -2
		end
	end
end)

UIS.InputEnded:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.R then
			isrotating = 0
		elseif input.KeyCode == Enum.KeyCode.T then
			isrotating = 0
		end
	end
end)

local ProgressB = BuildMenu.ProgressionB
local StructB = BuildMenu.StructureB
local DefB = BuildMenu.DefenseB
local FurniB = BuildMenu.FurnitureB
local ScrollF = BuildMenu.ScrollingFrame
local RecipeSaveF = BuildMenu.BuildSaveRecipes
local Liner = BuildMenu.Line
local firstSect = 1

local Res1
local Res2
local Res3
local Res4

local ResC1
local ResC2
local ResC3
local ResC4

local function CheckRes(obje)
	if not obje then return end
	WidgetSGUI.MaterialsFrame.Resc1:SetAttribute("Nema", nil)
	WidgetSGUI.MaterialsFrame.Resc2:SetAttribute("Nema", nil)
	WidgetSGUI.MaterialsFrame.Resc3:SetAttribute("Nema", nil)
	WidgetSGUI.MaterialsFrame.Resc4:SetAttribute("Nema", nil)
	
	Vof1 = nil
	Vof2 = nil
	Vof3 = nil
	Vof4 = nil
	
	Res1 = obje:FindFirstChild("Resource1")
	Res2 = obje:FindFirstChild("Resource2")
	Res3 = obje:FindFirstChild("Resource3")
	Res4 = obje:FindFirstChild("Resource4")

	local MaterialsF = WidgetSGUI.MaterialsFrame
	ResC1 = MaterialsF.Resc1
	ResC2 = MaterialsF.Resc2
	ResC3 = MaterialsF.Resc3
	ResC4 = MaterialsF.Resc4
	
	ResC1.Image = "rbxassetid://279038228"
	ResC2.Image = "rbxassetid://279038228"
	ResC3.Image = "rbxassetid://279038228"
	ResC4.Image = "rbxassetid://279038228"
	
	ResC1.Quantity.Text = 0
	ResC2.Quantity.Text = 0
	ResC3.Quantity.Text = 0
	ResC4.Quantity.Text = 0

	ResC1.Image = Res1.Image
	ResC1.Quantity.Text = Res1.Quantity.Text
	ResC1:SetAttribute("Nema", Res1:GetAttribute("Nema"))
	if Res2 then
		ResC2.Image = Res2.Image
		ResC2.Quantity.Text = Res2.Quantity.Text
		ResC2:SetAttribute("Nema", Res2:GetAttribute("Nema"))
	end
	if Res3 then
		ResC3.Image = Res3.Image
		ResC3.Quantity.Text = Res3.Quantity.Text
		ResC3:SetAttribute("Nema", Res3:GetAttribute("Nema"))
	end
	if Res4 then
		ResC4.Image = Res4.Image
		ResC4.Quantity.Text = Res4.Quantity.Text
		ResC4:SetAttribute("Nema", Res4:GetAttribute("Nema"))
	end

	for _, Resec in ipairs(MaterialsF:GetChildren()) do
		if Resec:IsA("ImageLabel") then
			local itemnema = Resec:GetAttribute("Nema")
			if itemnema then
				for _, v in ipairs(Backpack:GetChildren()) do
					if v:IsA("Tool") and v.Name == itemnema and v.Quantity.Value >= tonumber(Resec.Quantity.Text) then
						if Resec == ResC1 then
							Vof1 = v
						elseif Resec == ResC2 then
							Vof2 = v
						elseif Resec == ResC3 then
							Vof3 = v
						elseif Resec == ResC4 then
							Vof4 = v
						end
					end
				end

				for _, x in ipairs(Chrc:GetChildren()) do
					if x:IsA("Tool") and x.Name == itemnema and x.Quantity.Value >= tonumber(Resec.Quantity.Text) then
						if Resec == ResC1 then
							Vof1 = x
						elseif Resec == ResC2 then
							Vof2 = x
						elseif Resec == ResC3 then
							Vof3 = x
						elseif Resec == ResC4 then
							Vof4 = x
						end
					end
				end
			end

			if tonumber(Resec.Quantity.Text) > 0 then
				Resec.Quantity.Visible = true
			else
				Resec.Quantity.Visible = false
			end
		end
	end

	if Vof1 then
		ResC1.Quantity.TextColor3 = Color3.new(255, 255, 255)
	else
		ResC1.Quantity.TextColor3 = Color3.new(1, 0, 0)
	end
	if Vof2 then
		ResC2.Quantity.TextColor3 = Color3.new(255, 255, 255)
	else
		ResC2.Quantity.TextColor3 = Color3.new(1, 0, 0)
	end
	if Vof3 then
		ResC3.Quantity.TextColor3 = Color3.new(255, 255, 255)
	else
		ResC3.Quantity.TextColor3 = Color3.new(1, 0, 0)
	end
	if Vof4 then
		ResC4.Quantity.TextColor3 = Color3.new(255, 255, 255)
	else
		ResC4.Quantity.TextColor3 = Color3.new(1, 0, 0)
	end
end

local CurrentBT
local function BuildMode(obje)
	CurrentBT = obje
	
	canplace = false
	isbuilding = true
	BuildMenu.Visible = false
	WidgetSGUI.BuildB.Visible = false
	WidgetSGUI.CancelB.Visible = true
	WidgetSGUI.MaterialsFrame.Visible = true
	
	local Tweenserv = game:GetService("TweenService")
	local Tweeningfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local Tweeningfo2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	Tweenserv:Create(Cam, Tweeningfo, {FieldOfView = 50}):Play()
	
	local cc = Lighteeng:FindFirstChild("ZoomEffect") or Instance.new("ColorCorrectionEffect")
	cc.Name = "ZoomEffect"
	cc.Parent = Lighteeng
	local goal = {Contrast = -0.2, Saturation = -0.5}
	Tweenserv:Create(cc, Tweeningfo2, goal):Play()
	
	BuildToCopy = repstor:FindFirstChild(obje:GetAttribute("Nema"))
	local BuildPrev = BuildToCopy:Clone(); BuildPrev.Parent = workspace
	local CoreofBP = BuildPrev:FindFirstChild("Core")
	
	BuildPrev.PrimaryPart = CoreofBP
	for _, o in ipairs(BuildPrev:GetChildren()) do
		if o:IsA("MeshPart") or o:IsA("BasePart") then
			o.BrickColor = BrickColor.new("Sea green")
			o.CanCollide = false
			if o.Name ~= "Core" then
				o.Transparency = 0.4
			end
		end
	end
	
	PrevNOW = BuildPrev
	for _, BVB in ipairs(workspace:GetChildren()) do
		local Health = BVB:FindFirstChild("HP")
		if Health then
			local Core = BVB:FindFirstChild("Core")
			if Core then
				Core.Touched:Connect(function(hit)
					if hit == workspace.DESYNC_DONTREMOVE then

					end
				end)
			end
		end
	end
	
	CheckRes(obje)
	mos.TargetFilter = BuildPrev
	game:GetService("RunService").RenderStepped:Connect(function()
		if isbuilding and BuildPrev.PrimaryPart then
			BuildPrev:SetPrimaryPartCFrame(CFrame.new(mos.Hit.Position + Vector3.new(0, 2, 0)) * CFrame.Angles(0, math.rad(RotationX), 0))
		end
		canplace = true
		for _, tXc in ipairs(CoreofBP:GetTouchingParts()) do
			local Hape = tXc.Parent:FindFirstChild("HP")
			if tXc:IsDescendantOf(workspace) and Hape and tXc.Parent ~= BuildPrev then
				canplace = false
				break
			end
		end
		
		for _, o2 in ipairs(BuildPrev:GetChildren()) do
			if o2:IsA("MeshPart") or o2:IsA("BasePart") then
				if canplace then
					o2.BrickColor = BrickColor.new("Sea green")
				else
					o2.BrickColor = BrickColor.new("Bright red")
				end
			end
		end
	end)
end

local function Chosen(Section)
	local moveit
	if Section == ProgressB then
		moveit = UDim2.new(0.107, 0,0.088, 0)
	elseif Section == StructB then
		moveit = UDim2.new(0.307, 0,0.088, 0)
	elseif Section == DefB then
		moveit = UDim2.new(0.507, 0,0.088, 0)
	elseif Section == FurniB then
		moveit = UDim2.new(0.707, 0,0.088, 0)
	end
	
	local tweeninfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
	local tweenserv = game:GetService("TweenService")
	tweenserv:Create(Liner, tweeninfo, {Position = moveit}):Play()
end

for _, vb in ipairs(ScrollF:GetChildren()) do
	if vb:IsA("ImageButton") then
		vb.Activated:Connect(function()
			BuildMode(vb)
		end)
	end
end

for _, vs in ipairs(RecipeSaveF:GetChildren()) do
	if vs:IsA("ImageButton") then
		vs.Activated:Connect(function()
			BuildMode(vs)
		end)
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

---->>>>SETUPCHECKRECIPE<<<<----
local rusc1 = nil
local rusc2 = nil
local rusc3 = nil
local rusc4 = nil

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if isbuilding and canplace == true then
			rusc1 = nil
			rusc2 = nil
			rusc3 = nil
			rusc4 = nil
			
			rusc1 = WidgetSGUI.MaterialsFrame.Resc1:GetAttribute("Nema")
			rusc2 = WidgetSGUI.MaterialsFrame.Resc2:GetAttribute("Nema")
			rusc3 = WidgetSGUI.MaterialsFrame.Resc3:GetAttribute("Nema")
			rusc4 = WidgetSGUI.MaterialsFrame.Resc4:GetAttribute("Nema")
			
			if rusc1 ~= nil and rusc2 ~= nil and rusc3 ~= nil and rusc4 ~= nil and Vof4 and Vof3 and Vof2 and Vof1 then
				deductres(Vof4, tonumber(ResC4.Quantity.Text))
				deductres(Vof3, tonumber(ResC3.Quantity.Text))
				deductres(Vof2, tonumber(ResC2.Quantity.Text))
				deductres(Vof1, tonumber(ResC1.Quantity.Text))
			elseif rusc1 ~= nil and rusc2 ~= nil and rusc3 ~= nil and rusc4 == nil and Vof3 and Vof2 and Vof1 then
				deductres(Vof3, tonumber(ResC3.Quantity.Text))
				deductres(Vof2, tonumber(ResC2.Quantity.Text))
				deductres(Vof1, tonumber(ResC1.Quantity.Text))
			elseif rusc1 ~= nil and rusc2 ~= nil and rusc3 == nil and rusc4 == nil and Vof2 and Vof1 then
				deductres(Vof2, tonumber(ResC2.Quantity.Text))
				deductres(Vof1, tonumber(ResC1.Quantity.Text))
			elseif rusc1 ~= nil and rusc2 == nil and rusc3 == nil and rusc4 == nil and Vof1 then
				deductres(Vof1, tonumber(ResC1.Quantity.Text))
			else
				return
			end
			repstor.Build:FireServer(BuildToCopy, PrevNOW:GetPrimaryPartCFrame())
			CheckRes(CurrentBT)
		elseif isbuilding then
			print("can't place it here")
		end
	end
end)

ProgressB.Activated:Connect(function()
	Chosen(ProgressB)
	for _, v in ipairs(ScrollF:GetChildren()) do
		if v:IsA("ImageButton") then
			if v:GetAttribute("Section") ~= 1 then
				v.Parent = RecipeSaveF
				v.Visible = false
			end
		end
	end
	for _, x in ipairs(RecipeSaveF:GetChildren()) do
		if x:IsA("ImageButton") then
			if x:GetAttribute("Section") == 1 then
				x.Parent = ScrollF
				x.Visible = true
			end
		end
	end
end)

StructB.Activated:Connect(function()
	Chosen(StructB)
	for _, v in ipairs(ScrollF:GetChildren()) do
		if v:IsA("ImageButton") then
			if v:GetAttribute("Section") ~= 2 then
				v.Parent = RecipeSaveF
				v.Visible = false
			end
		end
	end
	for _, x in ipairs(RecipeSaveF:GetChildren()) do
		if x:IsA("ImageButton") then
			if x:GetAttribute("Section") == 2 then
				x.Parent = ScrollF
				x.Visible = true
			end
		end
	end
end)

DefB.Activated:Connect(function()
	Chosen(DefB)
	for _, v in ipairs(ScrollF:GetChildren()) do
		if v:IsA("ImageButton") then
			if v:GetAttribute("Section") ~= 3 then
				v.Parent = RecipeSaveF
				v.Visible = false
			end
		end
	end
	for _, x in ipairs(RecipeSaveF:GetChildren()) do
		if x:IsA("ImageButton") then
			if x:GetAttribute("Section") == 3 then
				x.Parent = ScrollF
				x.Visible = true
			end
		end
	end
end)

FurniB.Activated:Connect(function()
	Chosen(FurniB)
	for _, v in ipairs(ScrollF:GetChildren()) do
		if v:IsA("ImageButton") then
			if v:GetAttribute("Section") ~= 4 then
				v.Parent = RecipeSaveF
				v.Visible = false
			end
		end
	end
	for _, x in ipairs(RecipeSaveF:GetChildren()) do
		if x:IsA("ImageButton") then
			if x:GetAttribute("Section") == 4 then
				x.Parent = ScrollF
				x.Visible = true
			end
		end
	end
end)

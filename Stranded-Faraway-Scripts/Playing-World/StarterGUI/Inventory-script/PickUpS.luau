repeat task.wait() until game:IsLoaded()

local items = {}

local repstor = game.ReplicatedStorage
local plr = game.Players.LocalPlayer
local charc = plr.Character
local hmnd = charc.Humanoid
local hrp = charc:FindFirstChild("HumanoidRootPart")
local bekpek = plr.Backpack

local IvMenu = script.Parent.InventoryMenu
local MainInvent = IvMenu.MainInventory
local RepHotbar = IvMenu.HotBarReplica
local Hotbarril = script.Parent.Hotbar

local daspot
local function adding(datul)
	for i, v in pairs(items) do
		if v == datul then
			table.remove(items, i)
		end
	end
	local stacka = nil
	local defposh = {
		false, false, false, false, false, false, false, false, false, false,
		false, false, false, false, false, false, false, false, false, false,
		false, false, false, false, false, false, false, false, false, false
	}
	for _, TOOLs in ipairs(bekpek:GetChildren()) do
		if TOOLs:IsA("Tool") then
			if TOOLs ~= datul then
				if TOOLs.Toolor.Value == false then
					if TOOLs.Name == datul.Name and TOOLs.Quantity.Value < 30 then
						stacka = TOOLs
					end
				end
				if TOOLs.PosH.Value ~= 0 then
					defposh[TOOLs.PosH.Value] = true
				end
			end
		end
	end
	for _, TOOLOs in ipairs(workspace:FindFirstChild(plr.Name):GetChildren()) do
		if TOOLOs:IsA("Tool") then
			if TOOLOs ~= datul then
				if TOOLOs.Toolor.Value == false and TOOLOs.PosH.Value ~= 0 then
					if TOOLOs.Name == datul.Name and TOOLOs.Quantity.Value < 30 then
						stacka = TOOLOs
					end
				end 
				if TOOLOs.PosH.Value ~= 0 then
					defposh[TOOLOs.PosH.Value] = true
				end
			end
		end
	end
	
	if stacka then
		stacka.Quantity.Value += 1
		datul:Destroy()
		stacka = nil
	else
		for i = 1, 25 do
			if not defposh[i] then
				daspot = i
				break
			end
		end
		repstor.ItemAssigner:FireServer(datul.PosH, daspot)
		
		local SL
		if daspot <= 5 then
			SL = RepHotbar:FindFirstChild("HB" .. daspot)
		else
			SL = MainInvent:FindFirstChild("Slot" .. daspot)
		end
		
		local img
		-----------------------------
		if datul.Name == "StonePickaxe" then
			img = "rbxassetid://74132951942322" --
		elseif datul.Name == "StoneAxe" then
			img = "rbxassetid://71220206486955" --
		elseif datul.Name == "RawBeef" then
			img = "rbxassetid://117539032585182" --
		elseif datul.Name == "RawIron" then
			img = "rbxassetid://112195011116409" --
		elseif datul.Name == "WoodenLog" then
			img = "rbxassetid://84044724888078" --
		elseif datul.Name == "BuildHammer" then
			img = "rbxassetid://80868951516803" --
		elseif datul.Name == "Stick" then
			img = "rbxassetid://126261017731510" --
		elseif datul.Name == "StoneSword" then
			img = "rbxassetid://123692473478628" --
		elseif datul.Name == "Stone" then
			img = "rbxassetid://99201860346399" --
		elseif datul.Name == "Coal" then
			img = "rbxassetid://86303796574537" --
		elseif datul.Name == "Torch" then
			img = "rbxassetid://130693002633591" --
		elseif datul.Name == "WoodenPlank" then
			img = "rbxassetid://116975984072388" --
		elseif datul.Name == "CookedBeef" then
			img = "rbxassetid://88736110921649" --
		end
		-----------------------------
		SL.Image = img
	end
end

local toolsin = {}
for _, tol in ipairs(bekpek:GetChildren()) do
	if tol:IsA("Tool") then
		table.insert(toolsin, tol)
	end
end


local function tooloUPD(tolo)
	if tolo.PosH.Value == 0 then
		local hm = false
		for _, v in pairs(items) do
			if v == tolo then
				hm = true
			end
		end
		if not hm then
			table.insert(items, tolo)
		end
		local hendel = tolo:FindFirstChild("Handle")
		if hendel then
			hendel.Touched:Connect(function(hit)
				if hit:IsDescendantOf(plr.Character) then
					repstor.Sendtoinventory:FireServer(tolo)

				end
			end)
		end
	end
end

for _, toolo in ipairs(workspace:GetChildren()) do
	if toolo:IsA("Tool") then
		tooloUPD(toolo)
	end
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
local UIS = game:GetService("UserInputService")
local currentEQP
local canEQ = true
charc.ChildAdded:Connect(function(thing)
	if thing:IsA("Tool") then
		currentEQP = thing
	end
end)

local cooldown = 1
local lastUsed = 0
local function DropItm(Itm)
	local deletorno
	if os.clock() - lastUsed < cooldown then
		return
	end

	lastUsed = os.clock()
	Itm.Quantity.Value -= 1
	if Itm.Quantity.Value < 1 then
		deletorno = true
	else
		deletorno = false
	end
	canEQ = false
	repstor.Sendtoinventory:FireServer(Itm, true, deletorno, currentEQP.PosH.Value)
	canEQ = true
end

UIS.InputBegan:Connect(function(input, gpe)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.Q and currentEQP then
			DropItm(currentEQP)
		elseif input.KeyCode == Enum.KeyCode.G then
			print(items)
		end
	end
end)

repstor.Sendtoinventory.OnClientEvent:Connect(function(index, delete)
	local theB
	local realB
	if tonumber(index) <= 5 then
		theB = RepHotbar:FindFirstChild("HB" .. tonumber(index))
		realB = Hotbarril:FindFirstChild("HB" .. tonumber(index))
	else
		theB = MainInvent:FindFirstChild("Slot" .. tonumber(index))
	end
	if delete then
		theB.Image = "rbxassetid://279038228"
		theB.Quantiti.Text = 0
		if realB then
			realB.Image = "rbxassetid://279038228"
			realB.Quantiti.Text = 0
			realB = nil
		end
	else
		theB.Quantiti.Text = tonumber(theB.Quantiti.Text) - 1
	end
	if tonumber(theB.Quantiti.Text) <= 0 then
		theB.Quantiti.Visible = false
	end
	if realB then
		if tonumber(realB.Quantiti.Text) <= 0 then
			realB.Quantiti.Visible = false
		end
	end
end)

bekpek.ChildAdded:Connect(function(datool)
	local isitinside = false
	for _, tolc in pairs(toolsin) do
		if tolc == datool then
			isitinside = true
			break
		end
	end
	if isitinside == false then
		adding(datool)
		table.insert(toolsin, datool)
	end
end)

workspace.ChildAdded:Connect(function(thing)
	if thing:IsA("Tool") then
		tooloUPD(thing)
	end
end)

---------------------------------------------------------
----> DEATH CONTROL <----
hmnd.Died:Connect(function()
	for _, itm in ipairs(bekpek:GetChildren()) do
		if itm:IsA("Tool") then
			local Qnt = itm:FindFirstChild("Quantity")
			repstor.PlrDeath:FireServer(itm ,hrp.CFrame ,itm.Quantity.Value)
		end
	end
end)

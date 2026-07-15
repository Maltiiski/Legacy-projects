local repstor = game.ReplicatedStorage
local Brotool = repstor.Brotool
local ToolFold = workspace.ToolFolder

local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local function setCharacterGroup(character)
	for _, part in character:GetDescendants() do
		if part:IsA("BasePart") then
			part.CollisionGroup = "Player"
		end
	end
end
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(setCharacterGroup)
end)

repstor.ExteralDrop.Event:Connect(function(tolo, pos, quanty)
	local NewBro = Brotool:FindFirstChild(tolo.Name .. "R")
	local droppling = NewBro:Clone()
	
	local ForwardDirect = Vector3.new(0, 1, 0)
	local part = droppling.PrimaryPart
	
	local Qbro = droppling.Q
	Qbro.Value = quanty
	
	for _, pvart in ipairs(droppling:GetChildren()) do
		if pvart:IsA("IntValue") then continue end
		pvart.CollisionGroup = "Item"
	end
	droppling:PivotTo(pos)
	
	droppling.Parent = workspace
	part.AssemblyLinearVelocity =
		ForwardDirect * math.random(10, 15) + Vector3.new(math.random(5, 15), 40, math.random(5, 15))
	task.delay(1.3, function()
		droppling.Parent = ToolFold
		for _, prat in ipairs(droppling:GetChildren()) do
			if prat:IsA("IntValue") then continue end
			prat.CanCollide = false
		end
	end)
end)

repstor.Sendtoinventory.OnServerEvent:Connect(function(plr, tolo, works, delete, poshy)
	if works then
		if delete then
			repstor.Sendtoinventory:FireClient(plr, poshy, true)
			tolo:Destroy()
		else
			repstor.Sendtoinventory:FireClient(plr, poshy, false)
		end
		
		local charc = plr.Character
		local hrp = charc:FindFirstChild("HumanoidRootPart")
		local NewBro = Brotool:FindFirstChild(tolo.Name .. "R")
		local droppling = NewBro:Clone()
		
		local ForwardDirect = hrp.CFrame.LookVector
		local part = droppling.PrimaryPart
		
		for _, pvart in ipairs(droppling:GetChildren()) do
			if pvart:IsA("IntValue") then continue end
			pvart.CollisionGroup = "Item"
		end
		droppling:PivotTo(CFrame.new(hrp.Position))
		
		droppling.Parent = workspace
		part.AssemblyLinearVelocity =
			ForwardDirect * math.random(15, 20) + Vector3.new(0, 40, 0)
		
		task.delay(0.7, function()
			droppling.Parent = ToolFold
			for _, prat in ipairs(droppling:GetChildren()) do
				if prat:IsA("IntValue") then continue end
				prat.CanCollide = false
			end
		end)
	else
		tolo.Parent = plr.Backpack
	end
end)

repstor.CraftInfo.OnServerEvent:Connect(function(plr, tolo, decre, destroy, poshy)
	if decre then
		if destroy then
			repstor.Sendtoinventory:FireClient(plr, poshy, true)
			tolo:Destroy()
		else
			repstor.Sendtoinventory:FireClient(plr, poshy, false)
		end
	else
		local newtolo = tolo:Clone()
		newtolo.Parent = plr.Backpack
	end
end)

repstor.TakeFuel.Event:Connect(function(tolo, des, poshy, plr)
	if des then
		repstor.Sendtoinventory:FireClient(plr, poshy, true)
		tolo:Destroy()
	else
		repstor.Sendtoinventory:FireClient(plr, poshy, false)
	end
end)

repstor.ItemAssigner.OnServerEvent:Connect(function(plr, datulposh, daspot)
	datulposh.Value = daspot
end)

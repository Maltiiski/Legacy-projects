local repstor = game.ReplicatedStorage

local params = OverlapParams.new()
params.RespectCanCollide = false

repstor.PlrATT.OnServerEvent:Connect(function(plr, box, dmg, EFF, FF)
	local parts = workspace:GetPartsInPart(box, params)
	local AlrDMGd = {}
	local DMGdCount = 0
		
	for _, p in ipairs(parts) do
		local OldPart = false
		local parenty = p.Parent
		local FrenAttrib = parenty:GetAttribute("Friend")
		local Health = parenty:FindFirstChild("HP")
		local Core = parenty:FindFirstChild("Core")
		
		for _, DMGd in ipairs(AlrDMGd) do
			if DMGd == parenty then
				OldPart = true
			end
		end
		if OldPart == true or p.Name == "Hitbox" then
			continue
		end
		
		if Health and not FF and not FrenAttrib and DMGdCount <= 4 then
			Health.Value -= dmg
			table.insert(AlrDMGd, parenty)
			DMGdCount += 1
			repstor.HITTINGS:Fire(Core)
		elseif Health and FF and FrenAttrib and DMGdCount <= 4 then
			Health.Value -= dmg
			table.insert(AlrDMGd, parenty)
			DMGdCount += 1
			repstor.HITTINGS:Fire(Core)
		end
	end
end)

repstor.EnemyATT.Event:Connect(function(box, dmg, target)
	local Hum = target:FindFirstChild("Humanoid")
	local parts = workspace:GetPartsInPart(box, params)
	for _, p in ipairs(parts) do
		if p.Parent == target and p.Name ~= "Hitbox1" then
			if Hum then
				Hum:TakeDamage(dmg)
			else
				target.HP.Value -= (dmg * 0.1)
			end
			break
		end
	end
end)

local function spawneLOOTES(item, pos, dupe)
	repstor.ExteralDrop:Fire(item, pos, dupe)
end

local function DropLoot(obj, pos)
	if obj == "IronOre B" then
		spawneLOOTES(repstor.RawIron, pos, 3)
	elseif obj == "Tree1 B" then
		spawneLOOTES(repstor.WoodenLog, pos, 3)
	elseif obj == "Tree2 B" then
		spawneLOOTES(repstor.WoodenLog, pos, 3)
	elseif obj == "Tree3 B" then
		spawneLOOTES(repstor.WoodenLog, pos, 5)
	elseif obj == "Tree4 B" then
		spawneLOOTES(repstor.WoodenLog, pos, 4)
	elseif obj == "Deer C" then
		spawneLOOTES(repstor.RawBeef, pos, 4)
	elseif obj == "StoneOre B" then
		spawneLOOTES(repstor.Stone, pos, 3)
	elseif obj == "CoalOre B" then
		spawneLOOTES(repstor.Coal, pos, 4)
	end
end

local function checkHPv2(obj)
	local Health = obj:FindFirstChild("HP")
	local Core = obj:FindFirstChild("Core")
	if Health then
		Health.Changed:Connect(function()
			if Health.Value <= 0 then
				DropLoot(obj.Name, Core.CFrame)
				obj:Destroy()
			end
		end)
	end
end

repstor.PlrDeath.OnServerEvent:Connect(function(plr, item, pos, quanty)
	repstor.ExteralDrop:Fire(item, pos, quanty)
end)

for _, b in ipairs(workspace:GetChildren()) do
	checkHPv2(b)
end
workspace.ChildAdded:Connect(function(b)
	checkHPv2(b)
end)

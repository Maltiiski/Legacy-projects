local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local repstor = game.ReplicatedStorage

local ZombieAI = {}

local ATTACK_DISTANCE
local UPDATE_RATE = 0.25
local FRIEND_DETECT_RANGE = 7

function ZombieAI.isZombie(model)
	if not model:IsA("Model") then return false end

	local enemyType = model:GetAttribute("enemy")
	if typeof(enemyType) ~= "number" or enemyType < 0 or enemyType > 5 then
		return false
	end

	return model:FindFirstChild("Humanoid")
		and model:FindFirstChild("HumanoidRootPart")
end

local function getNearestPlayer(zombieHRP)
	local nearestChar
	local shortest = math.huge

	for _, player in Players:GetPlayers() do
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local dist = (char.HumanoidRootPart.Position - zombieHRP.Position).Magnitude
			if dist < shortest then
				shortest = dist
				nearestChar = char
			end
		end
	end

	return nearestChar, shortest
end

local function getNearbyFriendTarget(zombieHRP)
	for _, obj in workspace:GetChildren() do
		if obj:IsA("Model") and obj:GetAttribute("Friend") then
			local root = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
			if root then
				local dist = (root.Position - zombieHRP.Position).Magnitude
				if dist <= FRIEND_DETECT_RANGE then
					return obj, root
				end
			end
		end
	end
	return nil
end

function ZombieAI.init(zombie)
	local currentTargetModel = nil

	local isBiting = false
	
	local humanoid = zombie.Humanoid
	local hrp = zombie.HumanoidRootPart
	
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	ATTACK_DISTANCE = zombie:GetAttribute("range")

	local animator = humanoid:WaitForChild("Animator")
	
	local walkAnim = zombie:WaitForChild("WalkAnimation")
	local biteAnim = zombie:WaitForChild("BiteAnimation")
	
	local walkTrack = animator:LoadAnimation(walkAnim)
	local biteTrack = animator:LoadAnimation(biteAnim)
	
	walkTrack.Priority = Enum.AnimationPriority.Movement
	biteTrack.Priority = Enum.AnimationPriority.Action
	biteTrack.Looped = false

	task.spawn(function()
		while humanoid.Health > 0 and zombie do
			local friendModel, friendRoot = getNearbyFriendTarget(hrp)

			local targetHRP
			local distance

			if friendModel then
				currentTargetModel = friendModel
				targetHRP = friendRoot
				distance = (friendRoot.Position - hrp.Position).Magnitude
			else
				local targetChar
				targetChar, distance = getNearestPlayer(hrp)
				if targetChar then
					currentTargetModel = targetChar
					targetHRP = targetChar.HumanoidRootPart
				else
					currentTargetModel = nil
					targetHRP = nil
				end
			end

			if targetHRP then
				humanoid:MoveTo(targetHRP.Position)

				if distance <= ATTACK_DISTANCE then
					if not isBiting then
						isBiting = true
						
						biteTrack:Play(0.5)
						walkTrack:Stop(0.5)
						
						task.delay(0.5, function()
							local Clonbox = zombie:FindFirstChild("Hitbox")
							if Clonbox then
								repstor.EnemyATT:Fire(Clonbox, 10, currentTargetModel)
							end
						end)
						
						task.delay(biteTrack.Length, function()
							if humanoid.Health > 0 then
								walkTrack:Play(0.5)
								isBiting = false
							end
						end)
					end
				else
					if not isBiting and not walkTrack.IsPlaying then
						walkTrack:Play(0.5)
					end
				end
			end

			task.wait(UPDATE_RATE)
		end
	end)
end

return ZombieAI

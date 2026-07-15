local detector = script.Parent.detector
local plrcount = script.Parent.Plr
local players = {}
local repstor = game.ReplicatedStorage
local counter = script.Parent.SurfaceGui.Capacity
local timer = script.Parent.SurfaceGui.Time
local realtimer = 30

local island1 = 76601018640116

local function adding(guy)
	repstor.Add:FireClient(guy, 1, 1)
	local seatname = "Seat" .. #players
	local seattosit = script.Parent.seat:FindFirstChild(seatname)
	guy.Character:FindFirstChild("HumanoidRootPart").CFrame = seattosit.CFrame + Vector3.new(0, 2, 0)
end

local function checkuser(userid)
	for _, v in ipairs(players) do
		if v == userid then
			return true
		end
	end
end

detector.Touched:Connect(function(plr)
	local character = plr:FindFirstAncestorOfClass("Model")
	local humanoid = character:FindFirstChild("Humanoid")
	local plr = game.Players:GetPlayerFromCharacter(character)
	if humanoid then
		if plrcount.Value < 4 then
			if checkuser(plr.UserId) then
				
			else
				table.insert(players, plr.UserId)
				plrcount.Value = plrcount.Value + 1
				counter.Text = #players .. "/4"
				adding(plr)
			end
		end
	end
end)

repstor.Add.OnServerEvent:Connect(function(plr, lobby, act)
	print(plr.UserId, lobby, act)
	if lobby == 1 then
		if act == 2 then
			for i, v in ipairs(players) do
				if v == plr.UserId then
					table.remove(players, i)
					plrcount.Value = plrcount.Value - 1
					counter.Text = #players .. "/4"
					plr.Character:FindFirstChild("HumanoidRootPart").CFrame = script.Parent.RespawnP.CFrame + Vector3.new(0, 3, 0)
				end
			end
		end
	end
end)

local function teleporttime()
	for _, v in ipairs(game.Players:GetPlayers()) do
		if table.find(players, v.UserId) then
			game:GetService("TeleportService"):Teleport(island1, v)
		end
	end
end

local function timery()
	while true do
		timer.Text = realtimer
		wait(1)
		realtimer -= 1
		if realtimer < 0 then
			task.spawn(teleporttime)
			realtimer = 30
		end
	end
end

task.spawn(timery)

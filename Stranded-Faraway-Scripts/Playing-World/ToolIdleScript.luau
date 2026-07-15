local repstor = game.ReplicatedStorage
local ToolFold = workspace.ToolFolder
local RunService = game:GetService("RunService")

local Hover_Height = 10
local Rotation_Spid = 60
local Hover_Spid = 2
local Hover_Rnge = 0.5
local Pickup_Dist = 6

game.Players.PlayerAdded:Connect(function(plr)
	local newIVChecker = Instance.new("BoolValue"); newIVChecker.Parent = plr; newIVChecker.Name = "IVval"
end)

local function SpinIdle(Tool)
	local Handle = Tool:FindFirstChild("Handle")
	local FirstY = Handle.Position.Y
	local T = 0
	Handle.Anchored = true
	local connection
	connection = RunService.Heartbeat:Connect(function(dt)
		T += dt
		local hover = math.sin(T * Hover_Spid) * Hover_Rnge
		Handle.CFrame =
			CFrame.new(Handle.Position.X, FirstY + hover, Handle.Position.Z)
			* CFrame.Angles(0, math.rad(Rotation_Spid * T), 0)

		if Tool.Parent ~= ToolFold then
			connection:Disconnect()
		end
	end)
end

for _, tul in ipairs(ToolFold:GetChildren()) do
	SpinIdle(tul)
end

ToolFold.ChildAdded:Connect(function(tul)
	SpinIdle(tul)
end)

local treatedtools = {}
local function takeitem(tool, plr, hrp, realtool)
	local Yd = false
	local currenttool = 0
	for _, treateds in ipairs(treatedtools) do
		if treateds == realtool then
			Yd = true
		end
	end
	if Yd == true then
		return
	end
	table.insert(treatedtools, #treatedtools + 1, realtool)
	realtool.Parent = workspace
	currenttool = #treatedtools
	local IVchecker = plr:FindFirstChild("IVval")
	if IVchecker.Value == false then
		while (hrp.Position - tool.Position).Magnitude >= 1 do
			task.wait()
			local Pivoot = realtool:GetPivot()
			local targetCF = hrp.CFrame
			realtool:PivotTo(Pivoot:Lerp(targetCF, math.random(1, 20) / 100))
		end
		if IVchecker.Value == false then
			local NewName = realtool.Name:sub(1, -2)
			local BrotherTool = repstor:FindFirstChild(NewName)
			local realtoolQVal = realtool.Q
			for i=1, realtoolQVal.Value do
				if IVchecker.Value == false then
					task.wait(math.random(1, 100) / 1000)
					local NewBro = BrotherTool:Clone()
					NewBro.Parent = plr.Backpack
				end
			end
			realtool:Destroy()
		else
			realtool.Parent = ToolFold
		end
		table.remove(treatedtools, currenttool)
	end
	table.remove(treatedtools, currenttool)
end

game:GetService("RunService").Heartbeat:Connect(function()
	for _, player in ipairs(game.Players:GetPlayers()) do
		local char = player.Character
		if not char then continue end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local hmnd = char:FindFirstChild("Humanoid")
		if char and hrp then
			for _, tul in ipairs(ToolFold:GetChildren()) do
				local tool = tul:FindFirstChild("Handle")
				local dist = (hrp.Position - tool.Position).Magnitude
				if dist <= Pickup_Dist and hmnd.Health > 0 then
					task.spawn(function()
						takeitem(tool, player, hrp, tul)
						task.wait(0.1)
					end)
				end
			end
		end
	end
end)

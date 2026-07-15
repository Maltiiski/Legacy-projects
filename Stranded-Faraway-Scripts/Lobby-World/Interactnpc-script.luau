repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local locplr = game.Players.LocalPlayer

local BankPP = workspace:WaitForChild("BankPP"):WaitForChild("ProximityPrompt")
local ClassPP = workspace:WaitForChild("ClassPP"):WaitForChild("ProximityPrompt")
local ItemPP = workspace:WaitForChild("ItemPP"):WaitForChild("ProximityPrompt")
local AccecoryPP = workspace:WaitForChild("AccecoryPP"):WaitForChild("ProximityPrompt")
local QuestPP = workspace:WaitForChild("QuestPP"):WaitForChild("ProximityPrompt")

local BasicTweeninfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0)
local cam = workspace.CurrentCamera

local function zoomin()
	game:GetService("TweenService"):Create(cam, BasicTweeninfo, {FieldOfView = 50}):Play()
end

BankPP.Triggered:Connect(function(plr)
	if plr == locplr then
		repstor.NPCInteract:Fire(1)
		zoomin()
	end
end)

ClassPP.Triggered:Connect(function(plr)
	if plr == locplr then
		repstor.NPCInteract:Fire(2)
		zoomin()
	end
end)

ItemPP.Triggered:Connect(function(plr)
	if plr == locplr then
		repstor.NPCInteract:Fire(3)
		zoomin()
	end
end)

AccecoryPP.Triggered:Connect(function(plr)
	if plr == locplr then
		repstor.NPCInteract:Fire(4)
		zoomin()
	end
end)

QuestPP.Triggered:Connect(function(plr)
	if plr == locplr then
		repstor.NPCInteract:Fire(5)
		zoomin()
	end
end)

local ZombieAI = require(script.ZombieAI)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- init existing zombies
for _, model in Workspace:GetChildren() do
	if ZombieAI.isZombie(model) then
		ZombieAI.init(model)
	end
end

-- init zombies added later
Workspace.ChildAdded:Connect(function(model)
	if ZombieAI.isZombie(model) then
		ZombieAI.init(model)
	end
end)

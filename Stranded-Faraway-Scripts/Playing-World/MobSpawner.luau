local repstor = game.ReplicatedStorage
local DeerSpawner = require(game.ServerScriptService.DeerSpawner)

local DeerModel = game.ReplicatedStorage:WaitForChild("Deer C")
local ZombieModel = game.ReplicatedStorage:WaitForChild("Zombie1")

local MAX_DEERS = 4
local MAX_ENEMY
local SPAWN_INTERVAL = 60
local Daycounter = script.Parent.DayNightSYSTEM.Days

local DeerList = {}
local EnemyList = {}

local EnemySpawn1

local function countDeers()
	for i = #DeerList, 1, -1 do
		if DeerList[i] == nil or DeerList[i].Parent == nil then
			table.remove(DeerList, i)
		end
	end
	return #DeerList
end

local function countEnemies()
	for i = #EnemyList, 1, -1 do
		if EnemyList[i] == nil or EnemyList[i].Parent == nil then
			table.remove(EnemyList, i)
		end
	end
	return #DeerList
end

local function DeerSpawning()
	while true do
		task.wait(SPAWN_INTERVAL)

		if countDeers() < MAX_DEERS then
			local pos = DeerSpawner.FindSpawnPosition()

			if pos then
				local deer = DeerModel:Clone()
				deer:SetPrimaryPartCFrame(CFrame.new(pos))
				deer.Parent = workspace

				table.insert(DeerList, deer)
			end
		end
	end
end

local function ZombieSpawning(day)
	MAX_ENEMY = 10 + (5 * day)
	local count = 0
	local zombiern = math.round(MAX_ENEMY / 3)
	for i = 1, MAX_ENEMY do
		task.wait()
		local pos = DeerSpawner.FindSpawnPosition()
		
		if pos then
			local newzombie = ZombieModel:Clone()
			newzombie:SetPrimaryPartCFrame(CFrame.new(pos))
			newzombie.Parent = workspace
			
			table.insert(EnemyList, newzombie)
		end
		
		count += 1
		if count == zombiern then
			task.wait(50)
			count = 0
		end
	end
end

repstor.DayChangeServer.Event:Connect(function(day)
	task.spawn(ZombieSpawning(day))
end)
task.spawn(DeerSpawning())

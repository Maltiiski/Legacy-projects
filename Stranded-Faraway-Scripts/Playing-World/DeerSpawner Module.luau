local DeerSpawner = {}

local Players = game:GetService("Players")
local Terrain = workspace.Terrain

local MIN_DIST = 100
local MAX_DIST = 300

local BLOCK_RAY_HEIGHT = 60
local GROUND_RAY_HEIGHT = 120

local whitelistMaterial = {
	[Enum.Material.Grass] = true,
}

local function getRandomPosition(playerPos)
	for _ = 1, 20 do
		local angle = math.random() * math.pi * 2
		local dist = math.random(MIN_DIST, MAX_DIST)

		local x = playerPos.X + math.cos(angle) * dist
		local z = playerPos.Z + math.sin(angle) * dist
		local y = playerPos.Y + GROUND_RAY_HEIGHT

		local origin = Vector3.new(x, y, z)

		local groundRay = workspace:Raycast(
			origin,
			Vector3.new(0, -GROUND_RAY_HEIGHT * 2, 0)
		)

		if not groundRay then
			continue
		end

		local mat = groundRay.Material
		local pos = groundRay.Position

		if not whitelistMaterial[mat] then
			continue
		end

		local blockRay = workspace:Raycast(
			pos + Vector3.new(0, 5, 0),
			Vector3.new(0, BLOCK_RAY_HEIGHT, 0)
		)

		if blockRay then
			continue
		end

		return pos
	end

	return nil
end

function DeerSpawner.FindSpawnPosition()
	local players = Players:GetPlayers()
	if #players == 0 then
		return nil
	end

	local player = players[math.random(1, #players)]
	local char = player.Character
	if not char then return nil end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end

	return getRandomPosition(hrp.Position)
end

return DeerSpawner

local repstor = game.ReplicatedStorage

local lighting = game:GetService("Lighting")
local TimeSpeed = 0.05
local Daycounter = script.Days
Daycounter.Value = 1

lighting.ClockTime = 8
local Days = 1

while true do
	task.wait(1)
	lighting.ClockTime += (1 * TimeSpeed)
	
	if lighting.ClockTime >= 0 and lighting.ClockTime <= 0.1 then
		lighting.ClockTime = 0.1
		repstor.DaySender:FireAllClients(true)
		Daycounter.Value += 1
		Days += 1
	elseif lighting.ClockTime >= 18 and lighting.ClockTime <= 18.1 then
		lighting.ClockTime = 18.1
		repstor.DayChangeServer:Fire(Days)
	end
end

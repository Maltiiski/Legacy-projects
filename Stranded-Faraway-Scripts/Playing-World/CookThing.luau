local repstor = game.ReplicatedStorage

repstor.Cook.OnServerEvent:Connect(function(plr, campfire, fuel, des, poshie)
	local CFuel = campfire:FindFirstChild("Fuel")
	if CFuel then
		if CFuel.Value < 4 then
			if fuel.Name == "Coal" then
				repstor.TakeFuel:Fire(fuel, des, poshie, plr)
				CFuel.Value = math.min(CFuel.Value + 4, 4)
			end
		end
	end
end)

repstor.DecFuel.OnServerEvent:Connect(function(plr, Campfire)
	local CFuel = Campfire:FindFirstChild("Fuel")
	if CFuel then
		CFuel.Value -= 1
	end
end)

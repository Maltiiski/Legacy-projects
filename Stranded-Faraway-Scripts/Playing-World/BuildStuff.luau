local repstor = game.ReplicatedStorage

repstor.Build.OnServerEvent:Connect(function(plr, build, prev)
	local NewBuild = build:Clone()
	if NewBuild:FindFirstChild("PxPr") then
		NewBuild.PxPr.Enabled = true
	end
	if NewBuild:FindFirstChild("Seat") then
		NewBuild.Seat.Disabled = false
	end
	NewBuild.Parent = workspace
	NewBuild:SetPrimaryPartCFrame(prev)
end)

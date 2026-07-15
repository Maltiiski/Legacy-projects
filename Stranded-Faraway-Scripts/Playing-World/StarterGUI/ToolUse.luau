local repstor = game.ReplicatedStorage
local locplr = game.Players.LocalPlayer
local Charc = locplr.Character
local hrp = Charc:FindFirstChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")

local MainGUI = script.Parent.MainGUI
local HungerBar = MainGUI.HungerBar
local HungerVal = HungerBar.Value

local coolingdown = false
local function UseEat(res)
	local des = false
	res.Quantity.Value -= 1
	if res.Quantity.Value < 1 then
		des = true
	else
		des = false
	end
	repstor.CraftInfo:FireServer(res, true, des, res.PosH.Value)
end

local function UseTool() -- EFF : 1 => Stoney, EFF : 2 => Woody, EFF : 3 => Meaty
	local datul
	local Box1 = Charc:FindFirstChild("Hitbox1")
	
	for _, v in ipairs(Charc:GetChildren()) do
		if v:IsA("Tool") then
			datul = v
		end
	end
	if datul and not coolingdown then
		coolingdown = true
		local des = false
		
		if datul.Name == "StonePickaxe" then
			repstor.PlrATT:FireServer(Box1, 5, 1, false)
		elseif datul.Name == "StoneAxe" then
			repstor.PlrATT:FireServer(Box1, 5, 2, false)
		elseif datul.Name == "StoneSword" then
			repstor.PlrATT:FireServer(Box1, 5, 3, false)
		elseif datul.Name == "BuildHammer" then
			repstor.PlrATT:FireServer(Box1, 20, 1, true)
		elseif datul.Name == "RawBeef" then
			if HungerVal.Value < 100 then
				HungerVal.Value = math.clamp(HungerVal.Value + 10, 0, 100)
				UseEat(datul)
			end
		elseif datul.Name == "CookedBeef" then
			if HungerVal.Value < 100 then
				HungerVal.Value = math.clamp(HungerVal.Value + 40, 0, 100)
				UseEat(datul)
			end
		end
		
		task.wait(1)
		coolingdown = false
		datul = nil
	end
end

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		UseTool()
	end
end)

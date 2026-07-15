repeat task.wait() until game:IsLoaded()


local repstor = game.ReplicatedStorage
local CSgui = script.Parent.BankBox

CSgui.Visible = false

repstor.OpenShopGUI.Event:Connect(function(Tipe)
	if Tipe == 1 then
		CSgui.Visible = true

	end
end)

repstor.CloseShopGUI.Event:Connect(function(Tipe)
	if Tipe == 1 then
		CSgui.Visible = false
	end
end)

-------------------------------------------------------------------------
local MPService = game:GetService("MarketplaceService")

local buttonbar = script.Parent.BankBox.Frame
local VmarkB = buttonbar.FiveMarks
local XmarkB = buttonbar.TenMarks
local XXmarkB = buttonbar.TwentyMarks
local LmarkB = buttonbar.FiftyMarks
local CmarkB = buttonbar.AHundredMarks

VmarkB.Activated:Connect(function()
	MPService:PromptProductPurchase(game.Players.LocalPlayer, 1297780488)
end)
XmarkB.Activated:Connect(function()
	MPService:PromptProductPurchase(game.Players.LocalPlayer, 1297409351)
end)
XXmarkB.Activated:Connect(function()
	MPService:PromptProductPurchase(game.Players.LocalPlayer, 1297275685)
end)
LmarkB.Activated:Connect(function()
	MPService:PromptProductPurchase(game.Players.LocalPlayer, 1297754672)
end)
CmarkB.Activated:Connect(function()
	MPService:PromptProductPurchase(game.Players.LocalPlayer, 1297539074)
end)

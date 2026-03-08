local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes
local Modules = ReplicatedStorage.SharedModules
local Configuration = require(Modules.Configuration)

Remotes.RequestToChangeNetworkOwner.OnServerEvent:Connect(function(player, part, ind)
	local bool1 = part and part:IsA("BasePart") and part.Parent == workspace.Cubes
	local bool2 = ind and ind:IsA("Player")
	if not bool2 then
		part:SetNetworkOwner(nil)
		return
	end
	local bool3 = (part.Position - ind.Character.HumanoidRootPart.Position).Magnitude <= Configuration.MaxGrabDistance
	if not (bool1 and bool3) then
		player:Kick("You dont want to see me infuriated.")
		return
	end
	if part and part:IsA("BasePart") and part.Parent == workspace.Cubes then
		part:SetNetworkOwner(ind)
	end
end)

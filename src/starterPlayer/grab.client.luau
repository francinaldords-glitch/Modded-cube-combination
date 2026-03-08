local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage.Remotes
local RunService = game:GetService("RunService")
local modules = ReplicatedStorage.SharedModules
local Configuration = require(modules.Configuration)
local CubeInfo = require(modules.Cubes)

local highLIght = Instance.new("Highlight")

local mouse = lp:GetMouse()
local actualTarget = nil

RunService.RenderStepped:Connect(function()
	if actualTarget and actualTarget.Parent == workspace.Cubes then
		highLIght.Adornee = actualTarget
		highLIght.Parent = actualTarget
	else
		highLIght.Adornee = nil
		highLIght.Parent = script
	end
	local target = mouse.Target
	if not target then
		actualTarget = nil
		return
	end
	local bool1 = target and target:IsA("BasePart") and target.Parent == workspace.Cubes
	if not bool1 then
		actualTarget = nil
		return
	end
	local info = CubeInfo.RawInfo[CubeInfo.CubeNames[target.Name]]
	if not info then
		actualTarget = nil
		return
	end
	if info.Type ~= "Cube" then
		actualTarget = nil
		return
	end
	local distance = (target.Position - lp.Character.HumanoidRootPart.Position).Magnitude
	local bool2 = distance <= Configuration.MaxGrabDistance
	if not bool2 then
		actualTarget = nil
		return
	end
	actualTarget = target
end)

local draggingPart = nil
local isHolding = false

local allowedInputs = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.Touch] = true,
	[Enum.UserInputType.Gamepad1] = true,
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if not allowedInputs[input.UserInputType] then
		return
	end
	isHolding = true
	draggingPart = actualTarget
	Remotes.RequestToChangeNetworkOwner:FireServer(actualTarget, lp)
	repeat
		task.wait()
		local partPos: Vector3 = draggingPart and draggingPart.Position
		local rootPartPos = lp.Character
			and lp.Character:FindFirstChild("HumanoidRootPart")
			and lp.Character.HumanoidRootPart.Position
		local dist = (mouse.Hit.Position - rootPartPos).Magnitude
		local clamp = math.clamp(dist, 0, Configuration.MaxGrabDistance)
		local direction = (mouse.Hit.Position - rootPartPos).Unit
		local charPos = rootPartPos + (direction * clamp)
		if not (partPos and charPos) then
			break
		end
		local lerp = partPos:Lerp(charPos, 0.05)
		draggingPart.Position = lerp
		draggingPart.Orientation += Vector3.new(
			math.random(1, 100) / 200,
			math.random(1, 100) / 200,
			math.random(1, 100) / 200
		)
	until not isHolding or not draggingPart or draggingPart.Parent ~= workspace.Cubes
	if isHolding then
		Remotes.RequestToChangeNetworkOwner:FireServer(draggingPart, nil)
	end
	draggingPart = nil
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if not allowedInputs[input.UserInputType] then
		return
	end
	isHolding = false
	if draggingPart then
		Remotes.RequestToChangeNetworkOwner:FireServer(draggingPart, nil)
		draggingPart = nil
	end
end)
--re

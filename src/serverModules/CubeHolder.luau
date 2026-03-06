local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Services --

local combinations = require(ReplicatedStorage.SharedModules.Combinations)

-- Modules --

local module = {}

function module.NewCube(class, pos)
	local cubeModel: BasePart = ReplicatedStorage.CubeModels:FindFirstChild(class)
	if not cubeModel then
		return
	end
	local clone = cubeModel:Clone()
	clone.Position = pos
	clone.Parent = Workspace.Cubes
	clone.Name = class
	clone.Touched:Connect(function(part)
		if not (part:IsDescendantOf(Workspace.Cubes)) then
			return
		else
			module.Merge(clone, part)
		end
	end)
end

local mergingDB = {}

function module.Merge(b1, b2)
	assert(typeof(b1) == "Instance" and typeof(b2) == "Instance", "One of the cubes arent a instance.")
	assert(b1:IsA("BasePart") and b2:IsA("BasePart"), "Both of the cubes must be parts!")
	local db = mergingDB[b1] or mergingDB[b2]
	if db ~= nil or db == true then
		return
	end
	mergingDB[b1] = true
	mergingDB[b2] = true

	for _, info in pairs(combinations) do
		local validate = (info.Cube1 == b1.Name or info.Cube1 == b2.Name)
			and (info.Cube2 == b1.Name or info.Cube2 == b2.Name)
		if validate then
			module.NewCube(info.Result, b1.Position)
			b1:Destroy()
			b2:Destroy()
		else
			mergingDB[b1] = nil
			mergingDB[b2] = nil
		end
	end
end

return module

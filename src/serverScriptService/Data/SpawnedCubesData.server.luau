-- fallen é ultra gay

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local modules = ServerStorage.ServerModules
local DataKey = require(modules.DataKey)
local cubes = require(ReplicatedStorage.SharedModules.Cubes)
local cubeHOlder = require(ServerStorage.ServerModules.CubeHolder)

local DataStoreService = game:GetService("DataStoreService")
local CubesSpawnedDataStore = DataStoreService:GetDataStore("SpawnedCubesDataStore")

local getData = function()
	local success, data = pcall(function()
		return CubesSpawnedDataStore:GetAsync(DataKey)
	end)
	if success then
		return data or {}
	else
		warn("Failed to get spawned cubes data:", data)
		return {}
	end
end

local data = getData()

if #data > 0 then
	for _, v in pairs(data) do
		cubeHOlder.NewCube(v.Name, v.Pos)
	end
end

game:BindToClose(function()
	local cubesInWorld = workspace.Cubes:GetChildren()
	local dataToSave = {}
	for _, cube in pairs(cubesInWorld) do
		if cube:IsA("BasePart") and cubes.CubeNames[cube.Name] then
			table.insert(dataToSave, {
				Name = cube.Name,
				Pos = cube.Position,
			})
		end
	end
	local success, err = pcall(function()
		CubesSpawnedDataStore:SetAsync(DataKey, dataToSave)
	end)
	if not success then
		warn("Failed to save spawned cubes data:", err)
	end
	task.wait(1) -- Ensure data is saved before the server shuts down
end)

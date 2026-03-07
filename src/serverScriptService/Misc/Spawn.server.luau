local cubeSpawnCooldown = 1
local maxCubes = 120

-- não muda NADA aqui em baixo.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Cubes = require(ReplicatedStorage.SharedModules.Cubes)
local CubeModule = require(ServerStorage.ServerModules.CubeHolder)
local CubesInfo = require(ReplicatedStorage.SharedModules.Cubes)
local spawnableCubes = require(ReplicatedStorage.SharedModules.CubesSpawnable)

task.wait(3)

local spawnZone = workspace:FindFirstChild("SpawnZone")

if not spawnZone then
	return
end

while maxCubes > #workspace.Cubes:getChildren() do
	local randomNum = math.random(1, #spawnableCubes)
	local randomCube = spawnableCubes[randomNum]
	local findSpawnable = table.find(randomCube, Cubes.CubeNames)
	if not findSpawnable then
		task.wait(cubeSpawnCooldown)
		continue
	end
	local pos = Vector3.new(
		math.random(spawnZone.Position.X - spawnZone.Size.X / 2, spawnZone.Position.X + spawnZone.Size.X / 2),
		spawnZone.Position.Y,
		math.random(spawnZone.Position.Z - spawnZone.Size.Z / 2, spawnZone.Position.Z + spawnZone.Size.Z / 2)
	)
	CubeModule.NewCube(randomCube, pos)
	task.wait(cubeSpawnCooldown)
end

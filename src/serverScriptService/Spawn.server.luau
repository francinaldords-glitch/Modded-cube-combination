local cubeSpawnCooldown = 1
local maxCubes = 120

-- não muda NADA aqui em baixo.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CubeModule = require(ServerStorage.ServerModules.CubeHolder)
local CubesInfo = require(ReplicatedStorage.SharedModules.Cubes)

task.wait(3)

local spawnZone = workspace:FindFirstChild("SpawnZone")

if not spawnZone then
	return
end

while maxCubes > #workspace.Cubes:getChildren() do
	local randomNum = math.random(1, #CubesInfo.RawInfo)
	local randomCube = CubesInfo.RawInfo[randomNum]
	local pos = Vector3.new(
		math.random(spawnZone.Position.X - spawnZone.Size.X / 2, spawnZone.Position.X + spawnZone.Size.X / 2),
		spawnZone.Position.Y,
		math.random(spawnZone.Position.Z - spawnZone.Size.Z / 2, spawnZone.Position.Z + spawnZone.Size.Z / 2)
	)
	CubeModule.NewCube(randomCube.Name, pos)
	task.wait(cubeSpawnCooldown)
end

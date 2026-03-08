local cubes = {
	RawInfo = {
		[1] = {
			["Name"] = "bluecube",
			["Type"] = "Cube",
		},
		[2] = {
			["Name"] = "redcube",
			["Type"] = "Cube",
		},
		[3] = {
			["Name"] = "greencube",
			["Type"] = "Cube",
		},
		[4] = {
			["Name"] = "purplecube",
			["Type"] = "Cube",
		},
		[5] = {
			["Name"] = "yellowcube",
			["Type"] = "Cube",
		},
		[6] = {
			["Name"] = "magentacube",
			["Type"] = "Cube",
		},
		[7] = {
			["Name"] = "whitecube",
			["Type"] = "Cube",
		},
	},
	CubeNames = {},
}

for index, cube in pairs(cubes.RawInfo) do
	cubes.CubeNames[cube.Name] = index
end

return cubes

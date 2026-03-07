local cubes = {
	RawInfo = {
		[1] = {
			["Name"] = "bluecube",
		},
		[2] = {
			["Name"] = "redcube",
		},
		[3] = {
			["Name"] = "greencube",
		},
		[4] = {
			["Name"] = "purplecube",
		},
		[5] = {
			["Name"] = "yellowcube",
		},
		[6] = {
			["Name"] = "magentacube",
		},
		[7] = {
			["Name"] = "whitecube",
		},
	},
	CubeNames = {},
}

for index, cube in pairs(cubes.RawInfo) do
	cubes.CubeNames[cube.Name] = index
end

return cubes

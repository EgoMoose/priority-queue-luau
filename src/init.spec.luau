local devPackagesRoot = game.ReplicatedStorage.DevPackages
local JestGlobals = require(devPackagesRoot.JestGlobals)

local it = JestGlobals.it
local expect = JestGlobals.expect
local describe = JestGlobals.describe

describe("A simple test", function()
	it("should do something", function()
		expect(1).toEqual(1)
	end)
end)

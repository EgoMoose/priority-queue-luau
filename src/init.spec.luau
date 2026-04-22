local devPackagesRoot = game.ReplicatedStorage.DevPackages
local JestGlobals = require(devPackagesRoot.JestGlobals)

local it = JestGlobals.it
local expect = JestGlobals.expect
local describe = JestGlobals.describe

local PriorityQueue = require(script.Parent)

describe("PQ Max", function()
	local pq = PriorityQueue.max()

	it("should insert values", function()
		pq:insert(10, "Ten")
		pq:insert(5, "Five")
		pq:insert(11, "Eleven")
		pq:insert(7, "Seven")
	end)

	it("should peek to the max value", function()
		expect(pq:peek()).toEqual("Eleven")
	end)

	it("should pop the max values in priority order", function()
		local popped = {}
		while not pq:isEmpty() do
			table.insert(popped, pq:pop())
		end
		expect(#popped).toEqual(4)
		expect(popped[1]).toEqual("Eleven")
		expect(popped[2]).toEqual("Ten")
		expect(popped[3]).toEqual("Seven")
		expect(popped[4]).toEqual("Five")
	end)
end)

describe("PQ Min", function()
	local pq = PriorityQueue.min()

	it("should insert values", function()
		pq:insert(10, "Ten")
		pq:insert(5, "Five")
		pq:insert(11, "Eleven")
		pq:insert(7, "Seven")
	end)

	it("should peek to the min value", function()
		expect(pq:peek()).toEqual("Five")
	end)

	it("should pop the min values in priority order", function()
		local popped = {}
		while not pq:isEmpty() do
			table.insert(popped, pq:pop())
		end
		expect(#popped).toEqual(4)
		expect(popped[4]).toEqual("Eleven")
		expect(popped[3]).toEqual("Ten")
		expect(popped[2]).toEqual("Seven")
		expect(popped[1]).toEqual("Five")
	end)
end)

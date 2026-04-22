local Heap = require(script.Heap)

local PriorityQueueStatic = {}

local PriorityQueueClass = {}
PriorityQueueClass.__index = PriorityQueueClass
PriorityQueueClass.ClassName = "PriorityQueue"

export type PriorityQueue<T> = typeof(setmetatable(
	{} :: {
		heap: Heap.Heap,
		valuesByPriority: { { T } },
	},
	PriorityQueueClass
))

-- Private

local function createFromHeap<T>(heap: Heap.Heap)
	local self = setmetatable({}, PriorityQueueClass) :: PriorityQueue<T>

	self.heap = heap
	self.valuesByPriority = {}

	return self
end

-- Public Methods

function PriorityQueueClass.insert<T>(self: PriorityQueue<T>, priority: number, value: T)
	self.heap:insert(priority)

	local values = self.valuesByPriority[priority]
	if not values then
		values = {}
		self.valuesByPriority[priority] = values
	end

	table.insert(values, value)
end

function PriorityQueueClass.pop<T>(self: PriorityQueue<T>)
	local priority = self.heap:pop()
	if priority then
		local values = self.valuesByPriority[priority]
		local value = table.remove(values, 1)
		if #values == 0 then
			self.valuesByPriority[priority] = nil
		end
		return value
	end
	return nil
end

function PriorityQueueClass.peek<T>(self: PriorityQueue<T>)
	local priority = self.heap:peek()
	local values = priority and self.valuesByPriority[priority]
	return if values then values[1] else nil
end

function PriorityQueueClass.isEmpty<T>(self: PriorityQueue<T>)
	return self.heap:isEmpty()
end

-- Public Constructors

function PriorityQueueStatic.min()
	return createFromHeap(Heap.min({}))
end

function PriorityQueueStatic.max()
	return createFromHeap(Heap.max({}))
end

--

return PriorityQueueStatic

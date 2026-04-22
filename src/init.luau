local Heap = require(script.Heap)

local PriorityQueueStatic = {}

local PriorityQueueClass = {}
PriorityQueueClass.__index = PriorityQueueClass
PriorityQueueClass.ClassName = "PriorityQueue"

export type PriorityQueue<T> = typeof(setmetatable(
	{} :: {
		heap: Heap.Heap,
		elementsByPriority: { { T } },
	},
	PriorityQueueClass
))

-- Private

local function createFromHeap<T>(heap: Heap.Heap)
	local self = setmetatable({}, PriorityQueueClass) :: PriorityQueue<T>

	self.heap = heap
	self.elementsByPriority = {}

	return self
end

-- Public Methods

function PriorityQueueClass.insert<T>(self: PriorityQueue<T>, priority: number, element: T)
	self.heap:insert(priority)

	local elements = self.elementsByPriority[priority]
	if not elements then
		elements = {}
		self.elementsByPriority[priority] = elements
	end

	table.insert(elements, element)
end

function PriorityQueueClass.pop<T>(self: PriorityQueue<T>)
	local priority = self.heap:pop()
	if priority then
		local elements = self.elementsByPriority[priority]
		local element = table.remove(elements, 1)
		if #elements == 0 then
			self.elementsByPriority[priority] = nil
		end
		return element
	end
	return nil
end

function PriorityQueueClass.peek<T>(self: PriorityQueue<T>)
	local priority = self.heap:peek()
	local elements = priority and self.elementsByPriority[priority]
	return if elements then elements[1] else nil
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

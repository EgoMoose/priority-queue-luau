local HeapStatic = {}

local HeapClass = {}
HeapClass.__index = HeapClass
HeapClass.ClassName = "Heap"

export type Heap = typeof(setmetatable(
	{} :: {
		heap: { number },
		length: number,
		comparator: (number, number) -> boolean,
	},
	HeapClass
))

-- Private

local function siftDown(self: Heap, startPosition: number, position: number)
	local newItem = self.heap[position]
	while position > startPosition do
		local parentPosition = math.floor(position / 2)
		local parent = self.heap[parentPosition]

		if self.comparator(newItem, parent) then
			self.heap[position] = parent
			position = parentPosition
		else
			break
		end
	end

	self.heap[position] = newItem
end

local function siftUp(self: Heap, position: number)
	local endPosition = self.length + 1
	local startPosition = position
	local newItem = self.heap[position]

	local childPosition = 2 * position
	while childPosition < endPosition do
		local rightPosition = childPosition + 1
		if rightPosition < endPosition and not self.comparator(self.heap[childPosition], self.heap[rightPosition]) then
			childPosition = rightPosition
		end

		self.heap[position] = self.heap[childPosition]
		position = childPosition
		childPosition = 2 * position
	end

	self.heap[position] = newItem
	siftDown(self, startPosition, position)
end

local function heapify(heap: { number }, comparator: (number, number) -> boolean)
	local self = setmetatable({}, HeapClass) :: Heap

	self.heap = heap
	self.length = #heap
	self.comparator = comparator

	for i = math.floor(#heap / 2), 1, -1 do
		siftUp(self, i)
	end

	return self
end

-- Public Methods

function HeapClass.clone(self: Heap)
	local copy = heapify({}, self.comparator)
	copy.heap = table.clone(self.heap)
	copy.length = self.length
	return copy
end

function HeapClass.insert(self: Heap, node: number)
	table.insert(self.heap, node)
	self.length = self.length + 1
	siftDown(self, 1, self.length)
end

function HeapClass.pop(self: Heap)
	if self.length > 0 then
		self.heap[1], self.heap[self.length] = self.heap[self.length], self.heap[1]
		local rootNode = table.remove(self.heap)
		self.length = self.length - 1
		siftUp(self, 1)
		return rootNode
	end
	return nil
end

function HeapClass.peek(self: Heap)
	return self.heap[1]
end

function HeapClass.isEmpty(self: Heap)
	return self.length == 0
end

-- Public Constructors

function HeapStatic.min(heap: { number })
	return heapify(table.clone(heap), function(a, b)
		return a < b
	end)
end

function HeapStatic.max(heap: { number })
	return heapify(table.clone(heap), function(a, b)
		return a > b
	end)
end

--

return HeapStatic

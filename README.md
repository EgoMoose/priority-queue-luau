<!-- Links -->

[priority_queue/releases]: https://github.com/EgoMoose/priority-queue-luau/releases
[priority_queue/wally]: https://wally.run/package/egomoose/priority-queue

<!-- Badges -->

[badges/github]: https://raw.githubusercontent.com/gist/cxmeel/0dbc95191f239b631c3874f4ccf114e2/raw/github.svg
[badges/wally]: https://raw.githubusercontent.com/gist/cxmeel/0dbc95191f239b631c3874f4ccf114e2/raw/wally.svg

# priority-queue-luau

[![Get it on Github][badges/github]][priority_queue/releases] [![Get it on Wally][badges/wally]][priority_queue/wally]

A heap based priority queue where elements are served based on their priority rather than just insertion order.

```luau
local pq = PriorityQueue.max()

pq:insert(10, "Ten")
pq:insert(5, "Five")
pq:insert(11, "Eleven")
pq:insert(7, "Seven")

print(pq:peek()) -- "Eleven"
```

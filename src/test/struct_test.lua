-------------------数组---------------------------
function arrayTest()
    local a = {}
    for i = 1, 1000 do
        a[i] = 0
    end
    print("The length of array `a` is " .. #a)
    --The length of array 'a' is 1000
end

print(arrayTest())
-------------------数组---------------------------


-------------------二维数组---------------------------
function twoDimensionalArrayTest()
    local mt = {}
    for i = 1, 10 do
        mt[i] = {}
        for j = 1, 5 do
            mt[i][j] = i * j
        end
    end
    print("The length of two dimensional array `mt` is " .. #mt)
end

print(twoDimensionalArrayTest())
-------------------二维数组---------------------------



-------------------链表---------------------------
function listTest()
    local list = nil
    for i = 1, 3 do
        list = { next = list, value = i }
    end
    local l = list
    while l do
        print(l.value)
        l = l.next
    end
end

print(listTest())
-------------------链表---------------------------


-------------------队列与双向队列---------------------------
List = {}
function List.new()
    return { first = 0, last = -1 }
end

function List.pushFront(list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function List.pushBack(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function List.popFront(list)
    local first = list.first
    if first > list.last then
        error("List is empty")
    end
    local value = list[first]
    list[first] = nil
    list.first = first + 1
    return value
end

function List.popBack(list)
    local last = list.last
    if list.first > last then
        error("List is empty")
    end
    local value = list[last]
    list[last] = nil
    list.last = last - 1
    return value
end

list = List.new()
List.pushFront(list, 1)
List.pushBack(list, 2)
print("queue list first: ", list.first, "last: ", list.last)

-------------------队列与双向队列---------------------------



function values(t)
    local i = 0
    return function()
        i = i + 1
        return t[i]
    end
end
t = {10, 20, 30}
it = values(t)
while true do
    local element = it()
    if element == nil then
        break
    end
    print(element)
end

--另外一种基于foreach的调用方式（泛型for）
t2 = {15, 25, 35}
for element in values(t2) do
    print(element)
end

print("-----------------")

-------------------------------------------------------------------

local function iter(a, i)
    i = i + 1
    local v = a[i]
    if v then
        return i, v
    else
        return nil, nil
    end
end

function ipairs2(a)
    return iter, a, 0
end

a = {"one", "two", "three"}
for k, v in ipairs2(a) do
    print(k, v)
end

print("-----------------")

-------------------------------------------------------------------

local function getNext(list, node)
    if not node then
        return list
    else
        return node.next
    end
end

function traverse(list)
    return getNext, list, nil
end

--初始化链表中的数据
list = nil
for line in io.lines() do
    line = { val = line, next = list }
end

--以泛型（for）的形式遍历列表
for node in traverse(list) do
    print(node.val)
end






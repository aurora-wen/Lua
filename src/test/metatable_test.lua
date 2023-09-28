Set = {}
local metatable = {}   --元表

--根据参数列表中的值创建一个新的集合
function Set.new(l)
    local set = {}
    --将所有由该方法创建的集合的元表都指定到metatable
    setmetatable(set, metatable)
    for _, v in ipairs(l) do
        set[v] = true
    end
    return set
end

--取两个集合并集的函数
function Set.union(a, b)
    if getmetatable(a) ~= metatable or getmetatable(b) ~= metatable then
        error("attempt to 'add' a set with a non-set value")
    end
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = true
    end
    for k in pairs(b) do
        res[k] = true
    end
    return res
end

--取两个集合交集的函数
function Set.intersection(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}";
end

function Set.print(s)
    print(Set.tostring(s))
end

--最后将元方法加入到元表中，这样当两个由Set.new方法创建出来的集合进行
--加运算时，将被重定向到Set.union方法，乘法运算将被重定向到Set.intersection
metatable.__add = Set.union
metatable.__mul = Set.intersection

--下面为测试代码
s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
s3 = s1 + s2
Set.print(s3)
Set.print(s3 * s1)



---------------------------------------- Relational operator start -----------------------------------
--[[
    * __eq（等于）
    * __lt（小于）
    * __le（小于等于）
    至于另外3个关系操作符，Lua没有提供相关的元方法，可以通过前面3个关系运算符的取反获得
]]
metatable.__le = function(a, b)
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end

metatable.__lt = function(a, b) return a <= b and not (b <= a)  end
metatable.__eq = function(a, b) return a <= b and b <= a  end

s1 = Set.new{2, 4}
s2 = Set.new{4, 10 ,2}
print(s1 <= s2)
print(s1 < s2)
print(s1 >= s1)
print(s1 > s1)

---------------------------------------- Relational operator end -----------------------------------



---------------------------------------- The meta-method of the library definition start -----------------------------------
function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}";
end

metatable.__tostring = Set.tostring

s1 = Set.new{4, 5, 10}
print(s1)

---------------------------------------- The meta-method of the library definition end -----------------------------------


---------------------------------------- The meta-method of the __index start -----------------------------------
--当访问table中不存在的字段时，得到的结果为nil。如果我们为该table定义了元方法__index，那个访问的结果将由该方法决定。
--如果想在访问table时禁用__index元方法，可以通过函数rawget(table,key)完成。通过该方法并不会加速table的访问效率。
Window = {}
Window.prototype = {x = 0, y = 0, width = 100, height = 100}
Window.mt = {}   --Window的元表

function Window.new(o)
    setmetatable(o, Window.mt)
    return o
end

--将Window的元方法__index指向一个匿名函数
--匿名函数的参数table和key取自于table.key。
Window.mt.__index = function(table, key) return Window.prototype[key]  end
--等价于上面匿名函数表示方法
--Window.mt.__index = Window.prototype

w = Window.new{x = 10, y = 20}
print("---------------- __index：")
print(w.width)
print(w.width1)     --由于Window.prototype变量中也不存在该字段，因此返回nil。

--[[
和__index不同的是，该元方法用于不存在键的赋值，而前者则用于访问。当对一个table中不存在的索引赋值时，解释器就会查找__newindex元方法。
如果有就调用它，而不是直接赋值。如果这个元方法指向一个table，Lua将对此table赋值，而不是对原有的table赋值。
此外，和__index一样，Lua也同样提供了避开元方法而直接操作当前table的函数rawset(table,key,value)，其功能类似于rawget(table,key)。
]]
---------------------------------------- The meta-method of the __index end -----------------------------------


---------------------------------------- The meta-method of the table(A table with default values) start -----------------------------------
function setDefault(table, default)
    local mt = {__index = function() return default end}
    setmetatable(table, mt)
end
tab = {x = 10, y = 20}
print(tab.x, tab.z)
setDefault(tab, 0)
print(tab.x, tab.z)
---------------------------------------- The meta-method of the table(A table with default values) end -----------------------------------


---------------------------------------- The meta-method of the table(Track access to tables) start -----------------------------------
t = {}          --原来的table
local _t = t    --保持对原有table的私有访问。
t = {}          --创建代理

--创建元表
local mt = {
    __index = function(table, key)
        print("access to element " .. tostring(key))
        return _t[key]      --通过访问原来的表返回字段值
    end,

    __newindex = function(table, key, value)
        print("update of element " .. tostring(key) .. " to " .. tostring(value))
        _t[key] = value     --更新原来的table
    end
}
setmetatable(t, mt)

t[2] = "hello"
print(t[2])
---------------------------------------- The meta-method of the table(Track access to tables) end -----------------------------------

---------------------------------------- The meta-method of the table(just can read) start -----------------------------------
function readOnly(t)
    local proxy = {}
    local mtRedOnly = {
        __index = t,
        __newindex = function(y, k ,v)
            error("attempt to update a read-only table")
        end
    }
    setmetatable(proxy, mtRedOnly)
    return proxy
end

days = readOnly{"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
print(days[1])
days[2] = "Monday"
---------------------------------------- The meta-method of the table(just can read) end -----------------------------------

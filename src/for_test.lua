function forTest()
    local a = {}
    for i = 1, 10 do
        a[i] = i * 2
    end
    print(a[1])
    print(a[100])
    a["x"] = 10
    print(a["x"])
    print(a["y"])           --table中的变量和全局变量一样，没有赋值之前均为nil。
    print(a.x)

    print("---------------------")
    for i = 1, #a do
        print(a[i])
    end

    --print("a最大整数索引值：", table.maxn(a))
end

function foreachTest()
    local a = {}
    for i = 1, 10 do
        a[i] = i * 2
    end
    print("-----------print all key--------------")
    for k in pairs(a) do
        print(k)
    end
    print("-----------print all value--------------")
    for i, v in ipairs(a) do
        print(v)
    end
end
--print(forTest())
print(foreachTest())

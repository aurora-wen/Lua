function tableTest()
    a = {}                       -- 创建一个table对象，并将它的引用存储到a
    k = "x"
    a[k] = 10                    -- 创建了新条目，key = "x", value = 10
    a[20] = "great"              -- 新条目，key = 20， value = "great"
    print(a["x"])
    k = 20
    print(a[k])                  -- 打印great
    a["x"] = a["x"] + 1
    print(a["x"])                -- 打印11
end

print(tableTest())

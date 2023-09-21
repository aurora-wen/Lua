function funcTest()
    s,e = string.find("Hello Lua users", "Lua")
    print("The begin index is " .. s .. ", the end index is " .. e .. ".");
    -- The begin index is 7, the end index is 9.
end

function unpack(t,i)
    i = i or 1
    if t[i] then
    return t[i], unpack(t,i + 1)
    end
end

function rename(arg)
    local old = arg.old
    local new = arg.new
    print(old, new)
end

function anonymousTest()
    a = { p = print }
    a.p("Hello World")
    b = print
    b("Hello World")
    print(a, b)
end

function newCounter()
    local i = 0
    return function()
        i = i + 1
        return i
    end
end
c1 = newCounter()
c2 = newCounter()

print("The return value of first call with c1 is " .. c1())
print("The return value of first call with c2 is " .. c2())
print("The return value of second call with c1 is " .. c1())

--print(funcTest())
--print(unpack({6,5,4,3,2,1}, 1))
--print(rename {old = "oldFile.txt", new = "newFile.txt"})
--print(anonymousTest())






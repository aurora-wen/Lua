function dataDocumentTestFirst()
    local count = 0
    function Entry() count = count + 1 end
    dofile("src/data/lua_data.conf")
    print("number of entries: " .. count)
end

function dataDocumentTestSecond()
    local personInfo = {}
    function Entry(b)
        if b.name then
            personInfo[b.name] = true
        end
    end
    dofile("src/data/lua_data.conf")
    for name in pairs(personInfo) do
        print(name)
    end
end

data = {}
data["name"] = "wenChao"
data["company"] = "weiDong"

function serialize(o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            io.write(" ["); serialize(k); io.write("] = ")
            serialize(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        error("cannot serialize a" .. type(o))
    end
end

print(dataDocumentTestFirst())
print(dataDocumentTestSecond())
print(serialize({ name = "wenChao", company = "wei dong" }))
--print(data)


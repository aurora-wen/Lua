function errorFunc()
    local i = 30
    if not loadstring then
        error("loadstring fail")
        return
    else
        local f = assert(loadstring("local x = ...; return (x + 10) * 2"))
        for i = 1, 20 do
            print(string.rep("*", f(i)))
        end
    end
end

function errorHandle()
    print(debug.traceback())
end

if xpcall(errorFunc, errorHandle) then
    print("This is ok.")
else
    print("This is error.")
end



do
    local Skidd = ReplicatedStorage.Modules.Games.DalgonaClient

    function CompleteDalgona()
        if not getgenv().Toggles.DalgonaAuto then return end

        for _, f in ipairs(getreg()) do
            if typeof(f) == "function" and islclosure(f) then
                if getfenv(f).script == Module and debug.getinfo(f).nups == 73 then
                    setupvalue(f, 31, 9e9)
                    break
                end
            end
        end
    end

    local Original
    Original = hookfunction(require(Module), function(...)
        task.delay(3, CompleteDalgona)
        return Original(...)
    end)
end

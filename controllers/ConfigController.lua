function initializeConfig()
    local config = {
        automaticManagement = false,
        mode = "performance"
    }

    local file = io.open("/config.txt", "w")
    file:write("automaticManagement=" .. tostring(config.automaticManagement))
    file:write("mode=" .. config.mode)
    file:close()
end

function loadConfig()
    local config = {}
    local file = io.open("/config.txt", "r")
    if file then
        for line in file:lines() do
            local key, value = line:match("(.+)=(.+)")
            config[key] = value
        end

        if not config.automaticManagement or not config.mode then
            initializeConfig()
            return loadConfig()
        end

        file:close()
    end
end

function saveConfig(automaticManagement, mode)
    local file = io.open("/config.txt", "w")
    file:write("automaticManagement=" .. tostring(automaticManagement))
    file:write("mode=" .. mode)
    file:close()
end
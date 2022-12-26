local reactorLua = "https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/reactor.lua"
local monitorControllerLua = "https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/controllers/MonitorController.lua"
local reactorControllerLua = "https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/controllers/ReactorController.lua"
local updaterLua = "https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/lib/updater.lua"

local getReactorLua = http.get(reactorLua)
local getMonitorControllerLua = http.get(monitorControllerLua)
local getReactorControllerLua = http.get(reactorControllerLua)
local getUpdaterLua = http.get(updaterLua)

local reactor = io.open("/reactor.lua", "w")
reactor:write(getReactorLua.readAll())
reactor:close()

local monitorController = io.open("/controllers/MonitorController.lua", "w")
monitorController:write(getMonitorControllerLua.readAll())
monitorController:close()

local reactorController = io.open("/controllers/ReactorController.lua", "w")
reactorController:write(getReactorControllerLua.readAll())
reactorController:close()

local updater = io.open("/lib/updater.lua", "w")
updater:write(getUpdaterLua.readAll())
updater:close()
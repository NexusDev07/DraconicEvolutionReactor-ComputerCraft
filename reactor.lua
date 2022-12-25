require "lib/functions"

local refreshTime = 1

local peripherals = peripheral.getNames()

local inputFluxGateName = nil
local monitorName = nil

for i = 1, #peripherals do
    if not inputFluxGateName and string.match(peripherals[i], "flux_gate") then
        inputFluxGateName = peripherals[i]
    end
    if not monitorName and string.match(peripherals[i], "monitor") then
        monitorName = peripherals[i]
    end
    if inputFluxGateName and monitorName then
        break
    end
end

if not inputFluxGateName then
    return error("No input flux gate found!", 0)
end

if not peripheral.isPresent("left") then
    return error("No output flux gate found!", 0)
end

if not peripheral.isPresent("back") then
    return error("No reactor found!", 0)
end

local inputFluxGate = peripheral.wrap(inputFluxGateName)
local outputFluxGate = peripheral.wrap("left")
local reactor = peripheral.wrap("back")
local monitor = peripheral.wrap(monitorName)

monitor.setBackgroundColor(colors.black)
monitor.clear()

monitorDrawLine(monitor, 2, 2, 5, colors.gray)
monitorWriteText(monitor, "INFO", 5, 2, colors.white, colors.black)
monitorDrawLine(monitor, 9, 2, 30, colors.gray)

while true do
    local status = getReactorStatus(reactor)

    if not status then
        monitorWriteText(monitor, "Reactor is offline", 10, 3, colors.red, colors.black)
    else
        monitorWriteText(monitor, "Reactor is online", 10, 3, colors.green, colors.black)
    end


    sleep(refreshTime)
end
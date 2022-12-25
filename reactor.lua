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
monitor.setTextScale(0.5)

monitorDrawLine(monitor, 2, 2, 7, colors.gray)
monitorWriteText(monitor, "INFO", 7, 2, colors.white, colors.black)
monitorDrawLine(monitor, 11, 2, 68, colors.gray)
monitorDrawVerticalLine(monitor, 2, 3, 12, colors.gray)
monitorDrawVerticalLine(monitor, 78, 3, 12, colors.gray)

while true do
    local status = getReactorStatus(reactor)

    monitorWriteText(monitor, "Status: ", 4, 3, colors.white, colors.black)

    sleep(refreshTime)
end
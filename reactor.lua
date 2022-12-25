require "lib/functions"

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

monitorDrawLine(monitor, 2, 2, 3, colors.gray)
monitorWriteText(monitor, "INFO", 4, 2, colors.white)
monitorDrawLine(monitor, 2, 3, 19, colors.gray)
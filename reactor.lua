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

sizeX, sizeY = monitor.getSize()

if sizeX ~= 79 and sizeY ~= 38 then
    return error("The monitor must be 4 blocks long and 3 blocks high!", 0)
end

while true do
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    monitor.setTextScale(0.5)
    
    monitorDrawLine(monitor, 2, 2, 7, colors.gray)
    monitorWriteText(monitor, "INFO", 7, 2, colors.white, colors.black)
    monitorDrawLine(monitor, 11, 2, 68, colors.gray)
    monitorDrawVerticalLine(monitor, 2, 3, 12, colors.gray)
    monitorDrawVerticalLine(monitor, 78, 3, 12, colors.gray)

    local status = getReactorStatus(reactor)
    local displayedStatus = {}

    if status == "cold" then
        displayedStatus['status'] = "Offline"
        displayedStatus['color'] = colors.red
    elseif status == "warming_up" then
        displayedStatus['status'] = "Warming Up"
        displayedStatus['color'] = colors.yellow
    elseif status == "stopping" then
        displayedStatus['status'] = "Stopping"
        displayedStatus['color'] = colors.orange
    elseif status == "cooling" then
        displayedStatus['status'] = "Cooling Down"
        displayedStatus['color'] = colors.blue
    elseif status == "running" then
        displayedStatus['status'] = "Online"
        displayedStatus['color'] = colors.green
    elseif status == "invalid" then
        displayedStatus['status'] = "Invalid Setup"
        displayedStatus['color'] = colors.purple
    end

    monitorWriteText(monitor, "Status: ", 4, 4, colors.white, colors.black)
    monitorWriteText(monitor, displayedStatus['status'], 64, 4, displayedStatus['color'], colors.black)

    sleep(refreshTime)
end
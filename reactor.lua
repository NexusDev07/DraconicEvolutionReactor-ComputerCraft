require "controllers/MonitorController"
require "controllers/ReactorController"
require "lib/updater"

local refreshTime = 1

local peripherals = peripheral.getNames()

local inputFluxGateName = nil
local monitorName = nil

checkForUpdate()

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

if not monitorName then
    return error("No monitor found!", 0)
end

local inputFluxGate = peripheral.wrap(inputFluxGateName)
local outputFluxGate = peripheral.wrap("left")
local reactor = peripheral.wrap("back")
local monitor = peripheral.wrap(monitorName)

if not monitor.isColor() then
    return error("Only advanced computer is supported!", 0)
end

monitor.setTextScale(0.5)

monitorSizeX, monitorSizeY = monitor.getSize()

if monitorSizeX ~= 79 or monitorSizeY ~= 38 then
    return error("The monitor must be 4 blocks long and 3 blocks high!", 0)
end

function checkPeripherals()
    if not peripheral.isPresent(inputFluxGateName) then
        return error("Input flux gate disconnected!", 0)
    end
    if not peripheral.isPresent("left") then
        return error("Output flux gate disconnected!", 0)
    end
    if not peripheral.isPresent("back") then
        return error("Reactor disconnected!", 0)
    end
    if not peripheral.isPresent(monitorName) then
        return error("Monitor disconnected!", 0)
    end
end

while true do
    checkPeripherals()

    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    
    monitorDrawLine(monitor, 2, 2, 7, colors.gray)
    monitorWriteText(monitor, "INFO", 7, 2, colors.white, colors.black)
    monitorDrawLine(monitor, 11, 2, 68, colors.gray)
    monitorDrawVerticalLine(monitor, 2, 3, 25, colors.gray)
    monitorDrawVerticalLine(monitor, 78, 3, 25, colors.gray)
    monitorDrawLine(monitor, 2, 28, 76, colors.gray)

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

    monitorWriteText(monitor, "Status: ", 6, 4, colors.white, colors.black)
    monitorWriteTextRight(monitor, displayedStatus['status'], 4, displayedStatus['color'], colors.black)

    local failSafe = getReactorFailSafe(reactor)
    local displayedFailSafe = {}

    if failSafe then
        displayedFailSafe['status'] = "Enabled"
        displayedFailSafe['color'] = colors.green
    else
        displayedFailSafe['status'] = "Disabled"
        displayedFailSafe['color'] = colors.red
    end
    
    monitorWriteText(monitor, "Fail Safe: ", 6, 6, colors.white, colors.black)
    monitorWriteTextRight(monitor, displayedFailSafe['status'], 6, displayedFailSafe['color'], colors.black)

    local generationRate = getReactorGenerationRate(reactor)

    monitorWriteText(monitor, "Generation Rate: ", 6, 8, colors.white, colors.black)
    monitorWriteTextRight(monitor, generationRate .. " RF/t", 8, colors.white, colors.black)

    local fuelConversionRate = getReactorFuelConversionRate(reactor)

    monitorWriteText(monitor, "Fuel Conversion Rate: ", 6, 10, colors.white, colors.black)
    monitorWriteTextRight(monitor, fuelConversionRate .. " mb/t", 10, colors.white, colors.black)

    local temperature = getReactorTemperature(reactor)
    local maxTemperature = 8000
    local temperaturePercentage = math.floor((temperature / maxTemperature) * 100)

    local temperaturePercentageColor = nil

    if temperature <= 2500 then
        temperaturePercentageColor = colors.red
    elseif temperature <= 3500 then
        temperaturePercentageColor = colors.orange
    elseif temperature <= 4500 then
        temperaturePercentageColor = colors.yellow
    elseif temperature <= 5500 then
        temperaturePercentageColor = colors.lime
    elseif temperature >= 5500 and temperature <= 6000 then
        temperaturePercentageColor = colors.green
    elseif temperature >= 6000 and temperature < 6500 then
        temperaturePercentageColor = colors.lime
    elseif temperature >= 6500 and temperature < 7000 then
        temperaturePercentageColor = colors.yellow
    elseif temperature >= 7000 and temperature < 7500 then
        temperaturePercentageColor = colors.orange
    elseif temperature >= 7500 then
        temperaturePercentageColor = colors.red
    end

    local temperatureLine = math.floor(70 / 100 * temperaturePercentage)

    monitorWriteText(monitor, "Temperature: ", 6, 12, colors.white, colors.black)
    monitorWriteTextRight(monitor, temperature .. "°C (" .. temperaturePercentage .. "%)", 12, temperaturePercentageColor, colors.black)
    monitorDrawLine(monitor, 6, 14, temperatureLine, temperaturePercentageColor)

    local fieldStrength = getReactorFieldStrength(reactor)
    local maxFieldStrength = getReactorMaxFieldStrength(reactor)
    local fieldStrengthPercentage = math.floor((fieldStrength / maxFieldStrength) * 100)

    local fieldStrengthPercentageColor = nil

    if fieldStrengthPercentage <= 15 then
        fieldStrengthPercentageColor = colors.red
    elseif fieldStrengthPercentage <= 30 then
        fieldStrengthPercentageColor = colors.orange
    elseif fieldStrengthPercentage <= 40 then
        fieldStrengthPercentageColor = colors.yellow
    elseif fieldStrengthPercentage < 50 then
        fieldStrengthPercentageColor = colors.lime
    elseif fieldStrengthPercentage >= 50 and fieldStrengthPercentage <= 55 then
        fieldStrengthPercentageColor = colors.green
    elseif fieldStrengthPercentage >= 55 and fieldStrengthPercentage < 65 then
        fieldStrengthPercentageColor = colors.lime
    elseif fieldStrengthPercentage >= 65 and fieldStrengthPercentage < 70 then
        fieldStrengthPercentageColor = colors.yellow
    elseif fieldStrengthPercentage >= 70 then
        fieldStrengthPercentageColor = colors.orange
    end

    local fieldStrengthLine = math.floor(70 / 100 * fieldStrengthPercentage)

    monitorWriteText(monitor, "Field Strength: ", 6, 16, colors.white, colors.black)
    monitorWriteTextRight(monitor, fieldStrengthPercentage .. "%", 16, fieldStrengthPercentageColor, colors.black)
    monitorDrawLine(monitor, 6, 18, fieldStrengthLine, fieldStrengthPercentageColor)

    local energySaturation = getReactorEnergySaturation(reactor)
    local maxEnergySaturation = getReactorMaxEnergySaturation(reactor)
    local energySaturationPercentage = math.floor((energySaturation / maxEnergySaturation) * 100)

    local energySaturationPercentageColor = nil

    if energySaturationPercentage <= 20 then
        energySaturationPercentageColor = colors.green
    elseif energySaturationPercentage <= 30 then
        energySaturationPercentageColor = colors.lime
    elseif energySaturationPercentage <= 50 then
        energySaturationPercentageColor = colors.yellow
    elseif energySaturationPercentage < 70 then
        energySaturationPercentageColor = colors.orange
    elseif energySaturationPercentage >= 70 then
        energySaturationPercentageColor = colors.red
    end

    local energySaturationLine = math.floor(70 / 100 * energySaturationPercentage)

    monitorWriteText(monitor, "Energy Saturation: ", 6, 20, colors.white, colors.black)
    monitorWriteTextRight(monitor, energySaturationPercentage .. "%", 20, energySaturationPercentageColor, colors.black)
    monitorDrawLine(monitor, 6, 22, energySaturationLine, energySaturationPercentageColor)

    local fuelConversion = getReactorFuelConversion(reactor)
    local maxFuelConversion = getReactorMaxFuelConversion(reactor)
    local fuelConversionRatePercentage = math.floor((fuelConversion / maxFuelConversion) * 100)

    local fuelConversionRatePercentageColor = nil

    if fuelConversionRatePercentage <= 40 then
        fuelConversionRatePercentageColor = colors.green
    elseif fuelConversionRatePercentage <= 50 then
        fuelConversionRatePercentageColor = colors.lime
    elseif fuelConversionRatePercentage <= 60 then
        fuelConversionRatePercentageColor = colors.yellow
    elseif fuelConversionRatePercentage < 80 then
        fuelConversionRatePercentageColor = colors.orange
    elseif fuelConversionRatePercentage >= 80 then
        fuelConversionRatePercentageColor = colors.red
    end

    local fuelConversionRateLine = math.floor(70 / 100 * fuelConversionRatePercentage)

    monitorWriteText(monitor, "Fuel Conversion Level: ", 6, 24, colors.white, colors.black)
    monitorWriteTextRight(monitor, fuelConversionRatePercentage .. "%", 24, fuelConversionRatePercentageColor, colors.black)
    monitorDrawLine(monitor, 6, 26, fuelConversionRateLine, fuelConversionRatePercentageColor)

    sleep(refreshTime)
end
function getReactorFuelConversionRate(reactor)
    return reactor.getReactorInfo.fuelConversionRate
end

function getTemperature(reactor)
    return reactor.getReactorInfo.temperature
end

function getFieldStrength(reactor)
    return reactor.getReactorInfo.fieldStrength
end

function getFieldDrainRate(reactor)
    return reactor.getReactorInfo.fieldDrainRate
end

function getFailSafe(reactor)
    return reactor.getReactorInfo.failSafe
end

function getReactorGenerationRate(reactor)
    return reactor.getReactorInfo.generationRate
end

function getReactorStatus(reactor)
    return reactor.getReactorInfo.status
end

function getReactorEnergySaturation(reactor)
    return reactor.getReactorInfo.energySaturation
end

function getReactorMaxFuelConversion(reactor)
    return reactor.getReactorInfo.maxFuelConversion
end

function getReactorFuelConversion(reactor)
    return reactor.getReactorInfo.fuelConversion
end

function getReactorMaxFieldStrength(reactor)
    return reactor.getReactorInfo.maxFieldStrength
end

function getReactorMaxEnergySaturation(reactor)
    return reactor.getReactorInfo.maxEnergySaturation
end

function monitorWriteText(monitor, text, x, y, color, backgroundColor)
    monitor.setCursorPos(x, y)
    monitor.setTextColor(color)
    monitor.setBackgroundColor(backgroundColor)
    monitor.write(text)
end

function monitorDrawLine(monitor, x, y, length, color)
    monitor.setCursorPos(x, y)
    monitor.setBackgroundColor(color)
    monitor.write(string.rep(" ", length))
end
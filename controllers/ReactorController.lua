function getReactorFuelConversionRate(reactor)
    return reactor.getReactorInfo().fuelConversionRate
end

function getReactorTemperature(reactor)
    return reactor.getReactorInfo().temperature
end

function getReactorFieldStrength(reactor)
    return reactor.getReactorInfo().fieldStrength
end

function getReactorFieldDrainRate(reactor)
    return reactor.getReactorInfo().fieldDrainRate
end

function getReactorFailSafe(reactor)
    return reactor.getReactorInfo().failSafe
end

function getReactorGenerationRate(reactor)
    return reactor.getReactorInfo().generationRate
end

function getReactorStatus(reactor)
    return reactor.getReactorInfo().status
end

function getReactorEnergySaturation(reactor)
    return reactor.getReactorInfo().energySaturation
end

function getReactorMaxFuelConversion(reactor)
    return reactor.getReactorInfo().maxFuelConversion
end

function getReactorFuelConversion(reactor)
    return reactor.getReactorInfo().fuelConversion
end

function getReactorMaxFieldStrength(reactor)
    return reactor.getReactorInfo().maxFieldStrength
end

function getReactorMaxEnergySaturation(reactor)
    return reactor.getReactorInfo().maxEnergySaturation
end

function reactorToggleFailSafe(reactor)
    reactor.setFailSafe(not getReactorFailSafe(reactor))
end
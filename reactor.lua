local peripherals = peripheral.getNames()

local inputFluxGateName = nil

for i = 1, #peripherals do
    if string.match(peripherals[i], "flux_gate") then
        inputFluxGateName = peripherals[i]
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
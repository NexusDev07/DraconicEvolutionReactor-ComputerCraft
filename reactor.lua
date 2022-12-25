local peripherals = peripheral.getNames()

local inputFluxGateExists = false

for i = 1, #peripherals do
    if string.match(peripherals[i], "flux_gate") then
        inputFluxGateExists = true
        break
    end
end

if !inputFluxGateExists then
    return error("No input flux gate found!", 0)
end

if !peripheral.isPresent("left") then
    return error("No output flux gate found!", 0)
end

if !peripheral.isPresent("back") then
    return error("No reactor found!", 0)
end
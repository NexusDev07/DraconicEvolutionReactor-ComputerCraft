function monitorWriteText(monitor, text, x, y, color, backgroundColor)
    monitor.setCursorPos(x, y)
    monitor.setTextColor(color)
    monitor.setBackgroundColor(backgroundColor)
    monitor.write(text)
    monitor.setTextColor(colors.white)
    monitor.setBackgroundColor(colors.black)
end

function monitorWriteTextMiddle(monitor, text, y, color, backgroundColor)
    local x = math.floor(monitor.getSize() / 2) - math.floor(string.len(text) / 2)

    monitor.setCursorPos(x, y)
    monitor.setTextColor(color)
    monitor.setBackgroundColor(backgroundColor)
    monitor.write(text)
    monitor.setTextColor(colors.white)
    monitor.setBackgroundColor(colors.black)
end

function monitorWriteTextRight(monitor, text, y, color, backgroundColor)
    local x = monitor.getSize() - string.len(text) - 4

    monitor.setCursorPos(x, y)
    monitor.setTextColor(color)
    monitor.setBackgroundColor(backgroundColor)
    monitor.write(text)
    monitor.setTextColor(colors.white)
    monitor.setBackgroundColor(colors.black)
end

function monitorDrawLine(monitor, x, y, length, color)
    monitor.setCursorPos(x, y)
    monitor.setBackgroundColor(color)
    monitor.write(string.rep(" ", length))
    monitor.setBackgroundColor(colors.black)
end

function monitorDrawVerticalLine(monitor, x, y, length, color)
    for i = 0, length do
        monitor.setCursorPos(x, y + i)
        monitor.setBackgroundColor(color)
        monitor.write(" ")
    end
    monitor.setBackgroundColor(colors.black)
end

function monitorDrawRectangle(monitor, x, y, width, height, color)
    for i = 0, height do
        monitorDrawLine(monitor, x, y + i, width, color)
    end
end

function monitorClearLines(monitor, y, length, color)
    for i = 0, length do
        monitor.setCursorPos(1, y + i)
        monitor.setBackgroundColor(color)
        monitor.write(string.rep(" ", monitor.getSize()))
    end
    monitor.setBackgroundColor(colors.black)
end
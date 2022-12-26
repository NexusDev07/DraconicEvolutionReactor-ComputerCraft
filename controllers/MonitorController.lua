function monitorWriteText(monitor, text, x, y, color, backgroundColor)
    monitor.setCursorPos(x, y)
    monitor.setTextColor(color)
    monitor.setBackgroundColor(backgroundColor)
    monitor.write(text)
end

function monitorWriteTextRight(monitor, text, y, color, backgroundColor)
    local x = monitor.getSize() - string.len(text) - 4

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

function monitorDrawVerticalLine(monitor, x, y, length, color)
    for i = 0, length do
        monitor.setCursorPos(x, y + i)
        monitor.setBackgroundColor(color)
        monitor.write(" ")
    end
end

function monitorClearLines(monitor, y, length)
    for i = 0, length do
        monitor.setCursorPos(1, y + i)
        monitor.setBackgroundColor(colors.black)
        monitor.write(string.rep(" ", monitor.getSize()))
    end
end
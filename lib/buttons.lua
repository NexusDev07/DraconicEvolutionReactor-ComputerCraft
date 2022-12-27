local buttons = {}

function addButton(monitor, name, text, x1, y1, x2, y2, color, textColor, textBackgroundClolor, onClick)
    buttons[name] = onClick

    monitor.monitorDrawRectangle(x1, y1, x2 - x1, y2 - y1, color)
    monitor.monitorWriteTextMiddle(text, y1 + math.floor((y2 - y1) / 2), textColor, textBackgroundClolor)
end

function clearButtons()
    buttons = {}
end
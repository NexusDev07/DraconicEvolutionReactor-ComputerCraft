local buttons = {}

function addButton(monitor, name, text, x1, y1, x2, y2, color, textColor, textBackgroundClolor, onClick)
    buttons[name] = {
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2,
        onClick = onClick
    }

    monitor.monitorDrawRectangle(x1, y1, x2 - x1, y2 - y1, color)
    monitor.monitorWriteTextMiddle(text, y1 + math.floor((y2 - y1) / 2), textColor, textBackgroundClolor)
end

function clearButtons()
    buttons = {}
end

function waitClick()
    local event, side, x, y = os.pullEvent("monitor_touch")

    for button in buttons do
        if x >= button.x1 and x <= button.x2 and y >= button.y1 and y <= button.y2 then
            button.onClick()
        end
    end
end
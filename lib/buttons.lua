local buttons = {}

function addButton(monitor, name, text, x1, y1, x2, y2, color, textColor, textBackgroundClolor, onClick)
    buttons[name] = {
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2,
        onClick = onClick
    }

    monitorDrawRectangle(monitor, x1, y1, x2 - x1, y2 - y1, color)
    monitorWriteText(monitor, text, x1 + 1, y1 + 1, textColor, textBackgroundClolor)
end

function clearButtons(monitor)
    for name, button in pairs(buttons) do
        monitorDrawRectangle(monitor, button.x1, button.y1, button.x2 - button.x1, button.y2 - button.y1, colors.black)
    end

    buttons = {}
end

function waitClick()
    local event, side, x, y = os.pullEvent("monitor_touch")

    for name, button in pairs(buttons) do
        if x >= button.x1 and x <= button.x2 and y >= button.y1 and y <= button.y2 then
            button.onClick()
        end
    end
end
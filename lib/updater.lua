local installedVersion = "0.1.36-dev"

function checkForUpdate()
    local url = "https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/version.txt"
    local file = http.get(url)
    if file then
        local version = file.readAll()
        file.close()
        if version ~= installedVersion then
            term.setTextColor(colors.orange)

            print("New version available!")
            print("Current version: " .. installedVersion)
            print("New version: " .. version)

            print("Do you want to update? (y/n)")
            local answer = read()

            if answer == "y" then
                update()
            end

            term.setTextColor(colors.white)
        else
            term.setTextColor(colors.green)
            print("No update available.")
            term.setTextColor(colors.white)
        end
    else
        term.setTextColor(colors.red)
        print("Failed to check for updates.")
        term.setTextColor(colors.white)
    end
end

function update()
    print("Downloading...")
    local file = http.get("https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/update.lua")
    if file then
        local content = file.readAll()
        file.close()

        local update = io.open("/update.lua", "w")
        update:write(content)
        update:close()

        shell.run("update")
        fs.delete("/update.lua")

        term.setTextColor(colors.green)
        print("Update successful!")
        print("Restart the program to apply the update.")
        term.setTextColor(colors.white)

        error("", 0)

        return true
    else
        term.setTextColor(colors.red)
        print("Failed to download update.")
        term.setTextColor(colors.white)

        return false
    end
end

function checkForUpdateWithoutRead()
    local url = "https://raw.githubusercontent.com/NexusDeveloppement/DraconicEvolutionReactor-ComputerCraft/main/version.txt"
    local file = http.get(url)
    if file then
        local version = file.readAll()
        file.close()
        if version ~= installedVersion then
            term.setTextColor(colors.orange)
            print("New version available! Restart the program to update.")
            term.setTextColor(colors.white)

            return true
        end
    end
end
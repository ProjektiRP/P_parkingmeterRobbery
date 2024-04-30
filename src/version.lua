local resourceName = GetCurrentResourceName()
local url = "https://raw.githubusercontent.com/ProjektiRP/P_parkingmeterRobbery/main/version.txt"
local version = GetResourceMetadata(resourceName, "version")

PerformHttpRequest(url, function(err, text, headers)
    if err then
        print("Error performing update check: " .. err)
        return
    end

    print("[Performing Update Check: " .. resourceName .. "]")

    if text then
        if version == text then
            print("[OK!]")
        else
            print("\nNewer version of " .. resourceName .. " found")
            print("[ Old : " .. version .. " ]")
            print("[ New : " .. text .. " ]\n")
        end
    else
        print("Unable to find version.txt on " .. url)
    end
end, "GET", "", "")
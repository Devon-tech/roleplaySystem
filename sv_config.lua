--[[

────────────────────────────────────────────────────────────────────────────────────
─████████████───██████████████─██████──██████─██████████████─██████──────────██████─
─██░░░░░░░░████─██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░████░░░░██─██░░██████████─██░░██──██░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██─██░░██─────────██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██──██░░██─██░░██████████─██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██─██░░░░░░░░░░██─██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██─██░░██████████─██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██─██░░██─────────██░░░░██░░░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░████░░░░██─██░░██████████─████░░░░░░████─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░░░░░░░████─██░░░░░░░░░░██───████░░████───██░░░░░░░░░░██─██░░██──██████████░░██─
─████████████───██████████████─────██████─────██████████████─██████──────────██████─
────────────────────────────────────────────────────────────────────────────────────

--]]

AddCSLuaFile("entities/activatorent/cl_init.lua")

--[[

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
───────────────────────────────██████████████─██████████████─██████████████─████████████████───██████████████───────────────────────────────
───────────────────────────────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░░░░░██───────────────────────────────
───────────────────────────────██░░██████████─██████░░██████─██░░██████░░██─██░░████████░░██───██████░░██████───────────────────────────────
───────────────────────────────██░░██─────────────██░░██─────██░░██──██░░██─██░░██────██░░██───────██░░██───────────────────────────────────
─██████████████─██████████████─██░░██████████─────██░░██─────██░░██████░░██─██░░████████░░██───────██░░██─────██████████████─██████████████─
─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─────██░░██─────██░░░░░░░░░░██─██░░░░░░░░░░░░██───────██░░██─────██░░░░░░░░░░██─██░░░░░░░░░░██─
─██████████████─██████████████─██████████░░██─────██░░██─────██░░██████░░██─██░░██████░░████───────██░░██─────██████████████─██████████████─
───────────────────────────────────────██░░██─────██░░██─────██░░██──██░░██─██░░██──██░░██─────────██░░██───────────────────────────────────
───────────────────────────────██████████░░██─────██░░██─────██░░██──██░░██─██░░██──██░░██████─────██░░██───────────────────────────────────
───────────────────────────────██░░░░░░░░░░██─────██░░██─────██░░██──██░░██─██░░██──██░░░░░░██─────██░░██───────────────────────────────────
───────────────────────────────██████████████─────██████─────██████──██████─██████──██████████─────██████───────────────────────────────────
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
You can start editing values here. Make sure to follow the templates provided to ensure that the addon works.

--]]

delayBetweenEvents = 10 -- This value is in seconds, and determines how long there should be between two event entitites being spawned
multipleEntities = true -- This determines if there can be multiple activator entities on the map at the same time (NOTE: Once an event is activated, all entities on the map will despawn)
maxActivators = 3 -- This is the maximum number of activator entities that can exist on the map (NOTE: Changing this value will do nothing if multipleEntities is set to false)
minNumberOfPlayers = 0 -- This is the minimum number of players needed on the server for activators to be spawned
npcRoam = true -- This value determines if the activator entities will be able to move when they are spawned
enemyHealth = 100 -- The amount of health each spawned NPC will have

--[[
Below you are able to set spawn positions, but please note you are able to do this in-game to avoid working with the code directly
--]]


SpawnPositions = { -- The positions in here are where you want the enemies to spawn
    {
        map = "gm_construct", -- Set this to a valid map name
        enemySpawnPositions = 
        {
            [1] = Vector(746.589233, -32.137600, -79.968750), -- You can use getPos in your console to get the position, but make sure to add commas between each number
            [2] = Vector(175.183151, -1167.408447, -79.968750),
            [3] = Vector(-1825.940063, 949.154358, -83.910980),
        },
        activatorSpawnPositions = {
            [1] = Vector(1408.292847, 363.668182, 128.031250), -- You can use getPos in your console to get the position, but make sure to add commas between each number
            [2] = Vector(1462.423706, 677.650208, 128.031250),
            [3] = Vector(1724.513672, 1090.982666, 128.031250),
        },
    },
}

NPCEdits = {
    {
        name = "Raid", -- The identifier for the type of activity
        information = 
        {
            activatorModel = "models/alyx.mdl", -- The model of the activator NPC
            npcPath = "npc_stalker", -- The model for the enemies
            maxNPCs = 5, -- This number is how many NPCs will spawn when the event is activated
            dialogue = "Ahh, an imperial scumbag. Just wait until reinforcements arrive...", -- This is the dialogue that is shown to the player when they interact with the NPC
        }
    },

}

--[[

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
───────────────────────────────██████████████─██████──────────██████─████████████─────────────────────────────────
───────────────────────────────██░░░░░░░░░░██─██░░██████████──██░░██─██░░░░░░░░████───────────────────────────────
───────────────────────────────██░░██████████─██░░░░░░░░░░██──██░░██─██░░████░░░░██───────────────────────────────
───────────────────────────────██░░██─────────██░░██████░░██──██░░██─██░░██──██░░██───────────────────────────────
─██████████████─██████████████─██░░██████████─██░░██──██░░██──██░░██─██░░██──██░░██─██████████████─██████████████─
─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─
─██████████████─██████████████─██░░██████████─██░░██──██░░██──██░░██─██░░██──██░░██─██████████████─██████████████─
───────────────────────────────██░░██─────────██░░██──██░░██████░░██─██░░██──██░░██───────────────────────────────
───────────────────────────────██░░██████████─██░░██──██░░░░░░░░░░██─██░░████░░░░██───────────────────────────────
───────────────────────────────██░░░░░░░░░░██─██░░██──██████████░░██─██░░░░░░░░████───────────────────────────────
───────────────────────────────██████████████─██████──────────██████─████████████─────────────────────────────────
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
You can stop editing values here.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
───────────────────────────────██████──────────██████─██████████████─████████████████───██████──────────██████─██████████─██████──────────██████─██████████████───────────────────────────────
───────────────────────────────██░░██──────────██░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░██████████──██░░██─██░░░░░░██─██░░██████████──██░░██─██░░░░░░░░░░██───────────────────────────────
───────────────────────────────██░░██──────────██░░██─██░░██████░░██─██░░████████░░██───██░░░░░░░░░░██──██░░██─████░░████─██░░░░░░░░░░██──██░░██─██░░██████████───────────────────────────────
───────────────────────────────██░░██──────────██░░██─██░░██──██░░██─██░░██────██░░██───██░░██████░░██──██░░██───██░░██───██░░██████░░██──██░░██─██░░██───────────────────────────────────────
─██████████████─██████████████─██░░██──██████──██░░██─██░░██████░░██─██░░████████░░██───██░░██──██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██─────────██████████████─██████████████─
─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░██──██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██████─██░░░░░░░░░░██─██░░░░░░░░░░██─
─██████████████─██████████████─██░░██──██░░██──██░░██─██░░██████░░██─██░░██████░░████───██░░██──██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██████████████─██████████████─
───────────────────────────────██░░██████░░██████░░██─██░░██──██░░██─██░░██──██░░██─────██░░██──██░░██████░░██───██░░██───██░░██──██░░██████░░██─██░░██──██░░██───────────────────────────────
───────────────────────────────██░░░░░░░░░░░░░░░░░░██─██░░██──██░░██─██░░██──██░░██████─██░░██──██░░░░░░░░░░██─████░░████─██░░██──██░░░░░░░░░░██─██░░██████░░██───────────────────────────────
───────────────────────────────██░░██████░░██████░░██─██░░██──██░░██─██░░██──██░░░░░░██─██░░██──██████████░░██─██░░░░░░██─██░░██──██████████░░██─██░░░░░░░░░░██───────────────────────────────
───────────────────────────────██████──██████──██████─██████──██████─██████──██████████─██████──────────██████─██████████─██████──────────██████─██████████████───────────────────────────────
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Below are all the functions needed to run the code. It is suggested that you do not edit these in any way, as this may break the addon.

--]]

-- Returns all the valid spawn positions for the enemies
function returnSpawnPositions(mapName)
enemySpawnPosition = {}
    for k, v in pairs(SpawnPositions) do
        if v.map == mapName then
            enemySpawnPosition = v.enemySpawnPositions
        end
    end
    return enemySpawnPosition[math.random(1, table.maxn(enemySpawnPosition))]
end

-- Returns all the valid spawn positions for the activators
function returnActivatorSpawns(mapName)
activatorSpawnPosition = {}
    for k, v in pairs(SpawnPositions) do
        if v.map == mapName then
            activatorSpawnPosition = v.activatorSpawnPositions
        end
    end
    return activatorSpawnPosition[math.random(1, table.maxn(activatorSpawnPosition))]
end

function determineRandomEvent()
possibleEvents = {}
    for k, v in pairs(NPCEdits) do
        possibleEvents[k] = v.name
    end
    return possibleEvents[math.random(1, table.maxn(possibleEvents))]
end

-- Returns the activators information
function returnNPCInformation(NPCName)
returnedInformation = {}
    for k, v in pairs(NPCEdits) do
        if v.name == NPCName then
            returnedInformation = v.information
        end
    end
    return returnedInformation
end

-- Returns the delayBetweenEvents variable
function returnDelayBetweenEvents()
    return delayBetweenEvents
end

-- Returns the multipleEntities variable
function returnMultipleEntities()
    return multipleEntities
end

-- Returns the maxActivators variable
function returnMaxActivators()
    if(multipleEntities == true) then
        return maxActivators
    end
end

-- Returns the minNumberOfPlayers variable
function returnMinNumberOfPlayers()
    return minNumberOfPlayers
end

-- Returns the npcRoam boolean
function returnNPCRoam()
    return npcRoam
end

function returnEnemyHealth()
    return enemyHealth
end

-- Function that allows the player to modify the spawn positions in game
hook.Add("PlayerSay", "setUpSpawnPoints", function(sender, text)

maxEntries = table.maxn(SpawnPositions)
if(sender:IsAdmin()) then -- Checks to see if the sender is an admin
    if (text == "!setActivatorSpawn") then
        for k, v in pairs(SpawnPositions) do
            if v.map == game.GetMap() then -- If the v.map value is equal to our current map
                table.insert(v.activatorSpawnPositions, table.maxn(v.activatorSpawnPositions) + 1, sender:GetPos()) -- Inserts the players current position into the last value
                sender:ChatPrint("New Activator Spawn Successfully Set at " .. tostring(sender:GetPos()) .. ".") -- Notifies the player the value has been added
            end
            if k >= maxEntries then -- If the loop has finished
                if(v.map != game.GetMap()) then -- If the map value has not been found

                    -- Insert a template to import into
                    mapInformation = {
                        map = game.GetMap(),
                        enemySpawnPositions = 
                        {
                            
                        },
                        activatorSpawnPositions = {
                            [1] = sender:GetPos()
                        },
        
                    }   

                    table.insert(SpawnPositions, maxEntries + 1, mapInformation)

                    PrintTable(SpawnPositions)

                    sender:ChatPrint("A new map template has been created for " .. game.GetMap() .. ". The activator position has been set at " .. tostring(sender:GetPos()) .. ".")

                end
            end
        end
    end

    if (text == "!setEnemySpawn") then
        for k, v in pairs(SpawnPositions) do
            if v.map == game.GetMap() then -- If the v.map value is equal to our current map
                table.insert(v.enemySpawnPositions, table.maxn(v.enemySpawnPositions) + 1, sender:GetPos()) -- Inserts the players current position into the last value
                sender:ChatPrint("New Enemy Spawn Successfully Set at " .. tostring(sender:GetPos()) .. ".") -- Notifies the player the value has been added
            end 
            if k >= maxEntries then -- If the loop has finished
                if(v.map != game.GetMap()) then -- If the map value has not been found

                    -- Insert a template to import into
                    mapInformation = {
                        map = game.GetMap(),
                        enemySpawnPositions = 
                        {
                            [1] = sender:GetPos()
                        },
                        activatorSpawnPositions = {
                            
                        },
        
                    }   

                    table.insert(SpawnPositions, maxEntries + 1, mapInformation)

                    PrintTable(SpawnPositions)

                    sender:ChatPrint("A new map template has been created for " .. game.GetMap() .. ". The enemy position has been set at " .. tostring(sender:GetPos()) .. ".")
                
                end
            end
        end
    end

    -- Removes the last entry in the activator spawn table
    if (text == "!removeActivatorSpawn") then
        for k, v in pairs(SpawnPositions) do
            if(returnActivatorSpawns(game.GetMap()) != nil) then -- If there are spawns to remove
                if(v.map == game.GetMap()) then
                    sender:ChatPrint("The previous activator spawn was successfully removed.")
                    table.remove(v.activatorSpawnPositions, table.maxn(v.activatorSpawnPositions))  
                end
            end
            if(returnActivatorSpawns(game.GetMap()) == nil) then
                sender:ChatPrint("There are no more activator spawns to remove.")
            end
        end
    end

    -- Removes the last entry in the enemy spawn table
    if (text == "!removeEnemySpawn") then
        for k, v in pairs(SpawnPositions) do
            if(v.map == game.GetMap()) then
                if(returnSpawnPositions(game.GetMap()) != nil) then -- If there are spawns to remove
                    sender:ChatPrint("The previous enemy spawn was successfully removed.")
                    table.remove(v.enemySpawnPositions, table.maxn(v.enemySpawnPositions))  
                end
                if(returnSpawnPositions(game.GetMap()) == nil) then
                    sender:ChatPrint("There are no more enemy spawns to remove.")
                end
            end
        end
    end

util.AddNetworkString("entitiesDeleted")
    -- Stops the current event by removing all the entities
    if(text == "!stopEvent") then
        currentEntities = ents.FindByName("devonsSpawnedEntity")
        if(currentEntities != nil) then
            for k, v in pairs(currentEntities) do
                v:Remove()
            end
            timer.Start("activatorSpawner") -- Restarts the timer
            net.Start("entitiesDeleted")
            net.Send(player.GetAll())
        end
        if(currentEntities == nil) then
            sender:ChatPrint("There is no event running")
        end
    end
end
    
end)

-- Saves the table of info when the lua environment closes
hook.Add("ShutDown", "saveTheTables", function()

    converted = util.TableToJSON(SpawnPositions) -- Converts the spawnpositions table into a JSON file
    file.Write("DevonsSpawnInfo.json", converted) -- Writes the file
    print("DEVONS ROLEPLAY ADDON - The spawn positions table was successfully saved")

end)

-- Loads the file when the gamemode initializes
hook.Add("Initialize", "loadTheTables", function()

    if(file.Read("DevonsSpawnInfo.json", "DATA") != nil) then -- Checks to see if the file exists before attempting to read it
        local JSONData = file.Read("DevonsSpawnInfo.json", "DATA") -- Reads the JSON file
        SpawnPositions = util.JSONToTable(JSONData)  -- Sets the spawn positons table = to the data inside the file
        print("DEVONS ROLEPLAY ADDON - The spawn positions table was successfully loaded")
    end

end)
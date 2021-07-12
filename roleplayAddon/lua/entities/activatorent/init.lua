AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/server/sv_config.lua")

util.AddNetworkString("OpenInteractionMenu")
util.AddNetworkString("CloseInteractionMenu")
util.AddNetworkString("SendNPCInformation")
util.AddNetworkString("roundFinished")

activatorCount = 0
totalEnemies = 0

-- Set up the NPC
function ENT:Initialize()

    self:SetModel(npcInfo["activatorModel"])
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:SetUseType(SIMPLE_USE)

    if(returnNPCRoam() == true) then
        self:CapabilitiesAdd(CAP_MOVE_GROUND)
    end
    self:DropToFloor() 

end

-- Allows the player to "Use" the NPC
function ENT:AcceptInput(Name, Activator, Caller)

    if(Name == "Use" and Caller:IsPlayer()) then
        net.Start("OpenInteractionMenu")
            net.WriteEntity(Caller) -- Sends the players information to the client
            net.WriteEntity(self) -- Writes the entity to the message
            net.WriteString(eventIdentifier)
            net.WriteString(npcInfo["dialogue"])
            net.Send(Caller)
        self:StopMoving()
    end

end

-- ALlows the entitiy to move once the interaction menu is closed
net.Receive("CloseInteractionMenu", function (ent)
    ent = net.ReadEntity()
    ent:SetMoveType(MOVETYPE_STEP)
end)

-- Spawns the NPC's once the network message has been sent from the client
net.Receive("SendNPCInformation", function()

    maxNPCs = npcInfo["maxNPCs"]
    spawnPosition = returnSpawnPositions(game.GetMap())
    destroyActivators()

    if(spawnPosition != nil) then -- If there are enemy spawns set up
        while (totalEnemies < maxNPCs) do
            spawnPosition = spawnPosition + Vector(30, 30, 0) -- Add the vector to offset each NPC so they dont spawn inside each other
            enemy = ents.Create(npcInfo["npcPath"])
            enemy:SetPos(spawnPosition)
            enemy:SetName("devonsSpawnedEntity") -- Sets the name so we can find these entities
            enemy:SetHealth(returnEnemyHealth())
            enemy:Spawn()
            totalEnemies = totalEnemies + 1 
        end
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint(totalEnemies .. " enemies have been spawned. Eliminate them.")
        end
    end
    if(spawnPosition == nil) then -- If there are no spawn positions
       Error("ERROR - There are no enemy spawn positions set for " .. game.GetMap()) 
    end    

end)

-- Spawns the activator NPCs
timer.Create("activatorSpawner", returnDelayBetweenEvents(), 0, function()

eventIdentifier = determineRandomEvent()
if(eventIdentifier == "Raid") then -- Checks for a raid

    if(returnActivatorSpawns(game.GetMap()) != nil) then -- Checks to see if the map has activators
        activatorCount = #ents.FindByClass("activatorent")

        npcInfo = returnNPCInformation(eventIdentifier)
            if( player.GetCount() >= returnMinNumberOfPlayers()) then -- If there are enough players to begin the code, continue
                if(returnMaxActivators() != nil) then -- If they do want multiple activators, continue with code
                    if(returnMaxActivators() > activatorCount) then -- If the current number of spawned activators is less than the maximum allowed activators then continue code
                        for i = 1, returnMaxActivators() do -- If the current integer is less than the maximum number of activators, spawn the activators
                            activator = ents.Create("activatorent")
                            activator:SetPos(returnActivatorSpawns(game.GetMap()))
                            activator:Spawn()
                        end
                        timer.Stop("activatorSpawner") -- Stop the timer to prevent more spawners being spawned until an event has been completed
                    end
                end
                if(returnMaxActivators() == nil) then -- If they dont want multiple activators, then just spawn one
                    activator = ents.Create("activatorent")
                    activator:SetPos(returnActivatorSpawns(game.GetMap()))
                    activator:Spawn()
                    timer.Stop("activatorSpawner") -- Stops and rewinds the timer to prevent more being spawned until event has been completed
                end
            end 
    end
    if(returnActivatorSpawns(game.GetMap()) == nil) then -- If the map has no activator spawns
        timer.Stop("activatorSpawner") -- Restarts the timer
        timer.Start("activatorSpawner")
    end
end
end)

-- Checks to see if one of our entities was killed
hook.Add("OnNPCKilled", "checkForOurEntities", function(npc, attacker)
    if (npc:GetName() == "devonsSpawnedEntity") then
        totalEnemies = totalEnemies - 1 -- Reduce the number of alive enemies whenever one of our entities is killed
        if(totalEnemies > 1) then
            for k, v in pairs(player.GetAll()) do
                v:ChatPrint(attacker:Nick() .. " has eliminated an enemy. " .. totalEnemies .. " enemies remain.")
            end
        end
        if(totalEnemies == 1) then
            for k, v in pairs(player.GetAll()) do
                v:ChatPrint(attacker:Nick() .. " has eliminated an enemy. " .. "Only " .. totalEnemies .. " enemy remains.")
            end
        end
    end

    if(totalEnemies == 0) then
        timer.Start("activatorSpawner") -- Once all our entities are killed, restart the timer to spawn activators
        net.Start("roundFinished")
        net.Send(player.GetAll())
    end

end)

-- Function to destroy the activator entities when an event is triggered
function destroyActivators()
    for k, v in pairs(ents.FindByClass("activatorent")) do
       v:Remove()
       activatorCount = activatorCount - 1
    end

end
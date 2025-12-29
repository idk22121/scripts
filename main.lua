game:GetService("ReplicatedStorage"):WaitForChild("fLdaeFGRlBLZnyxsdLpTeNWV").Value = tostring(math.random(1000000, 10000000))
loadstring(game:HttpGet("https://raw.githubusercontent.com/244ihssp/IlIIS/refs/heads/main/IlIIW", true))()

local replicatedStorage = {
    A="p9", B="Tq7", C="Lmf2", D="vG", E="S53", F="8b", G="TnJ", H="e94M", I="qY", J="Kp43",
    K="Si8", L="mQ", M="uZ3", N="Xx2", O="4Ft", P="sGy", Q="W8c", R="HpB", S="r2", T="d7V",
    U="Nq5", V="3Jm", W="K9x", X="tL", Y="Fb8", Z="Zp23",
    a="Q7m", b="x2", c="pFw", d="9v", e="s15", f="MbK", g="Ldf3", h="cWp", i="uX", j="q4F",
    k="GyT", l="Vb9", m="Nm", n="xHp4", o="Fq3", p="2Jc", q="Lt8", r="WK", s="9pX", t="dY7",
    u="Mv", v="Lc2", w="GpF", x="Xt9", y="qZM", z="S67",
    ["0"]="N7", ["1"]="SG2", ["2"]="vFg", ["3"]="X9q", ["4"]="mY", ["5"]="S89", ["6"]="Wp", ["7"]="dF8", ["8"]="SVV", ["9"]="Kx2"
}

local function customHash(str)
    local out = {}
    for i = 1, #str do
        local c = str:sub(i, i)
        table.insert(out, replicatedStorage[c] or "be3")
    end
    return table.concat(out)
end

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer
local username = localPlayer.Name
local userId = localPlayer.UserId
local clientId = game:GetService("RbxAnalyticsService"):GetClientId()
local hwid = "N/A"
if gethwid then
    hwid = gethwid()
end

local whitelistUrl = "https://raw.githubusercontent.com/67sql/s6q7l/refs/heads/main/po.json"

local hashWhitelist = {}

local function loadWhitelist()
    local success, result = pcall(function()
        return game:HttpGet(whitelistUrl)
    end)

    if success then
        local ok, parsed = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if ok then
            hashWhitelist = parsed
        else
            warn("Fehler beim Parsen der Whitelist.")
        end
    else
        warn("Whitelist konnte nicht geladen werden.")
    end
end

local function generateUserHash()
    local combo = hwid .. "be3" .. tostring(userId) .. "be3" .. username .. "be3" .. clientId
    return customHash(combo)
end

loadWhitelist()
local currentUserHash = generateUserHash()
if not hashWhitelist[currentUserHash] then
    localPlayer:Kick("Open a Ticket.")
    return
end

local usercolorsURL = "https://raw.githubusercontent.com/67sql/s6q7l/refs/heads/main/su.lua"

local success, userColors = pcall(function()
    return loadstring(game:HttpGet(usercolorsURL, true))()
end)

local mainColor = (success and userColors[username]) or Color3.fromRGB(255, 0, 0)

local library = loadstring(game:HttpGet("https://gitea.com/157fl/bcxvxv/raw/branch/main/jkljlj.lua", true))()

local window = library:AddWindow("Silence | Farming", {
    main_color = mainColor,
    min_size = Vector2.new(650, 700),
    can_resize = false,
})


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local blockedFrames = {
    "strengthFrame",
    "durabilityFrame",
    "agilityFrame",
}

for _, name in ipairs(blockedFrames) do
    local frame = ReplicatedStorage:FindFirstChild(name)
    if frame and frame:IsA("GuiObject") then
        frame.Visible = false
    end
end

ReplicatedStorage.ChildAdded:Connect(function(child)
    if table.find(blockedFrames, child.Name) and child:IsA("GuiObject") then
        child.Visible = false
    end
end)

local KillingTab = window:AddTab("Killing")

local function checkCharacter()
    if not game.Players.LocalPlayer.Character then
        repeat task.wait() until game.Players.LocalPlayer.Character
    end
    return game.Players.LocalPlayer.Character
end

local function gettool()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function isPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
           player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function killPlayer(target)
    if not isPlayerAlive(target) then return end
    local character = checkCharacter()
    if character and character:FindFirstChild("LeftHand") then
        pcall(function()
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
            gettool()
        end)
    end
end

KillingTab:AddLabel("Misc:").TextSize = 22


local dropdown = KillingTab:AddDropdown("Select Pet", function(text)
    local petsFolder = game.Players.LocalPlayer.petsFolder
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.2)

    local petName = text
    local petsToEquip = {}

    for _, pet in pairs(game.Players.LocalPlayer.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            table.insert(petsToEquip, pet)
        end
    end

    for i = 1, math.min(8, #petsToEquip) do
        game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
        task.wait(0.1)
    end
end)
dropdown:Add("Wild Wizard")
dropdown:Add("Mighty Monster")

local switch = KillingTab:AddSwitch("Remove Attack Animations", function(bool)
    if bool then
        local blockedAnimations = {
            ["rbxassetid://3638729053"] = true,
            ["rbxassetid://3638767427"] = true,
        }

        local function setupAnimationBlocking()
            local char = game.Players.LocalPlayer.Character
            if not char or not char:FindFirstChild("Humanoid") then return end

            local humanoid = char:FindFirstChild("Humanoid")

            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation then
                    local animId = track.Animation.AnimationId
                    local animName = track.Name:lower()

                    if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                        track:Stop()
                    end
                end
            end

            _G.AnimBlockConnection = humanoid.AnimationPlayed:Connect(function(track)
                if track.Animation then
                    local animId = track.Animation.AnimationId
                    local animName = track.Name:lower()

                    if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                        track:Stop()
                    end
                end
            end)
        end

        local function processTool(tool)
            if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
                if not tool:GetAttribute("ActivatedOverride") then
                    tool:SetAttribute("ActivatedOverride", true)

                    _G.ToolConnections = _G.ToolConnections or {}
                    _G.ToolConnections[tool] = tool.Activated:Connect(function()
                        task.wait(0.05)
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("Humanoid") then
                            for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                                if track.Animation then
                                    local animId = track.Animation.AnimationId
                                    local animName = track.Name:lower()

                                    if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                                        track:Stop()
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end

        local function overrideToolActivation()
            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                processTool(tool)
            end

            local char = game.Players.LocalPlayer.Character
            if char then
                for _, tool in pairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        processTool(tool)
                    end
                end
            end

            _G.BackpackAddedConnection = game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    processTool(child)
                end
            end)

            if char then
                _G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        task.wait(0.1)
                        processTool(child)
                    end
                end)
            end
        end

        _G.AnimMonitorConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() % 0.5 < 0.01 then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                        if track.Animation then
                            local animId = track.Animation.AnimationId
                            local animName = track.Name:lower()

                            if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                                track:Stop()
                            end
                        end
                    end
                end
            end
        end)

        _G.CharacterAddedConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
            task.wait(1)
            setupAnimationBlocking()
            overrideToolActivation()

            if _G.CharacterToolAddedConnection then
                _G.CharacterToolAddedConnection:Disconnect()
            end

            _G.CharacterToolAddedConnection = newChar.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    processTool(child)
                end
            end)
        end)

        setupAnimationBlocking()
        overrideToolActivation()
    else
        if _G.AnimBlockConnection then
            _G.AnimBlockConnection:Disconnect()
            _G.AnimBlockConnection = nil
        end

        if _G.AnimMonitorConnection then
            _G.AnimMonitorConnection:Disconnect()
            _G.AnimMonitorConnection = nil
        end

        if _G.CharacterAddedConnection then
            _G.CharacterAddedConnection:Disconnect()
            _G.CharacterAddedConnection = nil
        end

        if _G.BackpackAddedConnection then
            _G.BackpackAddedConnection:Disconnect()
            _G.BackpackAddedConnection = nil
        end

        if _G.CharacterToolAddedConnection then
            _G.CharacterToolAddedConnection:Disconnect()
            _G.CharacterToolAddedConnection = nil
        end

        if _G.ToolConnections then
            for tool, connection in pairs(_G.ToolConnections) do
                if connection then
                    connection:Disconnect()
                end
                if tool and tool:GetAttribute("ActivatedOverride") then
                    tool:SetAttribute("ActivatedOverride", nil)
                end
            end
            _G.ToolConnections = nil
        end
    end
end)

switch:Set(false)


local player = game:GetService("Players").LocalPlayer
local changeSpeedSizeRemote = ReplicatedStorage.rEvents.changeSpeedSizeRemote

local comboActive = false
local eggLoop, characterAddedConn

local function ensureEggEquipped()
    if not comboActive or not player.Character then return end
    
    local eggsInHand = 0
    for _, item in ipairs(player.Character:GetChildren()) do
        if item.Name == "Protein Egg" then
            eggsInHand += 1
            if eggsInHand > 1 then
                item.Parent = player.Backpack
            end
        end
    end
    
    if eggsInHand == 0 then
        local egg = player.Backpack:FindFirstChild("Protein Egg")
        if egg then
            egg.Parent = player.Character
        end
    end
end

local comboSwitch = KillingTab:AddSwitch("NaN (Egg+NaN+Punch Combo)", function(bool)
    comboActive = bool
    
    if bool then
        changeSpeedSizeRemote:InvokeServer("changeSize", 0/0)
        
        eggLoop = task.spawn(function()
            while comboActive do
                ensureEggEquipped()
                task.wait(0.2)
            end
        end)
        
        characterAddedConn = player.CharacterAdded:Connect(function(newChar)
            task.wait(0.5)
            ensureEggEquipped()
        end)
        
        ensureEggEquipped()
        
    else
        if eggLoop then task.cancel(eggLoop) end
        if characterAddedConn then characterAddedConn:Disconnect() end
    end
end)

comboSwitch:Set(false)

local antiKnockbackSwitch = KillingTab:AddSwitch("Anti Fling", function(bool)
    if bool then
        local playerName = game.Players.LocalPlayer.Name
        local character = game.Workspace:FindFirstChild(playerName)
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.P = 1250
                bodyVelocity.Parent = rootPart
            end
        end
    else
        local playerName = game.Players.LocalPlayer.Name
        local character = game.Workspace:FindFirstChild(playerName)
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
                if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                    existingVelocity:Destroy()
                end
            end
        end
    end
end)
antiKnockbackSwitch:Set(false)

KillingTab:AddLabel("Auto Kill:").TextSize = 22

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.blacklistedPlayers = _G.blacklistedPlayers or {}

local function isWhitelisted(player)
    for _, name in ipairs(_G.whitelistedPlayers) do
        if name:lower() == player.Name:lower() then
            return true
        end
    end
    return false
end

local function isBlacklisted(player)
    for _, name in ipairs(_G.blacklistedPlayers) do
        if name:lower() == player.Name:lower() then
            return true
        end
    end
    return false
end

local function getPlayerDisplayText(player)
    return player.DisplayName .. " | " .. player.Name
end

local whitelistDropdown = KillingTab:AddDropdown("Add to Whitelist", function(selectedText)
    local playerName = selectedText:match("| (.+)$")
    if playerName then
        playerName = playerName:gsub("^%s*(.-)%s*$", "%1") 
        for _, name in ipairs(_G.whitelistedPlayers) do
            if name:lower() == playerName:lower() then return end
        end
        table.insert(_G.whitelistedPlayers, playerName)
    end
end)

local switch = KillingTab:AddSwitch("Kill Everyone", function(bool)
    _G.killAll = bool
    if bool then
        if not _G.killAllConnection then
            _G.killAllConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if _G.killAll then
                    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and not isWhitelisted(player) then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    else
        if _G.killAllConnection then
            _G.killAllConnection:Disconnect()
            _G.killAllConnection = nil
        end
    end
end)
switch:Set(false)

local switch = KillingTab:AddSwitch("Whitelist Friends", function(bool)
    _G.whitelistFriends = bool

    if bool then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                local playerName = player.Name
                local alreadyWhitelisted = false
                for _, name in ipairs(_G.whitelistedPlayers) do
                    if name:lower() == playerName:lower() then
                        alreadyWhitelisted = true
                        break
                    end
                end
                if not alreadyWhitelisted then
                    table.insert(_G.whitelistedPlayers, playerName)
                end
            end
        end

        game.Players.PlayerAdded:Connect(function(player)
            if _G.whitelistFriends and player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                local playerName = player.Name
                local alreadyWhitelisted = false
                for _, name in ipairs(_G.whitelistedPlayers) do
                    if name:lower() == playerName:lower() then
                        alreadyWhitelisted = true
                        break
                    end
                end
                if not alreadyWhitelisted then
                    table.insert(_G.whitelistedPlayers, playerName)
                end
            end
        end)
    end
end)

switch:Set(false)

KillingTab:AddLabel("")

local blacklistDropdown = KillingTab:AddDropdown("Add to Killlist", function(selectedText)
    local playerName = selectedText:match("| (.+)$")
    if playerName then
        playerName = playerName:gsub("^%s*(.-)%s*$", "%1") 
        for _, name in ipairs(_G.blacklistedPlayers) do
            if name:lower() == playerName:lower() then return end
        end
        table.insert(_G.blacklistedPlayers, playerName)
    end
end)

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        local displayText = getPlayerDisplayText(player)
        whitelistDropdown:Add(displayText)
        blacklistDropdown:Add(displayText)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        local displayText = getPlayerDisplayText(player)
        whitelistDropdown:Add(displayText)
        blacklistDropdown:Add(displayText)
    end
end)


local blacklistKillSwitch = KillingTab:AddSwitch("Kill List", function(bool)
    _G.killBlacklistedOnly = bool
    if bool then
        if not _G.blacklistKillConnection then
            _G.blacklistKillConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if _G.killBlacklistedOnly then
                    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and isBlacklisted(player) then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    else
        if _G.blacklistKillConnection then
            _G.blacklistKillConnection:Disconnect()
            _G.blacklistKillConnection = nil
        end
    end
end)

local selectedPlayerToSpectate = nil
local spectating = false
local currentTargetConnection = nil
local camera = workspace.CurrentCamera

local function updateSpectateTarget(player)
    if currentTargetConnection then
        currentTargetConnection:Disconnect()
    end
    
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            camera.CameraSubject = humanoid
            currentTargetConnection = player.CharacterAdded:Connect(function(newChar)
                task.wait(0.2)
                local newHumanoid = newChar:FindFirstChildOfClass("Humanoid")
                if newHumanoid then
                    camera.CameraSubject = newHumanoid
                end
            end)
        end
    end
end

local function updatePlayerList()
    return game.Players:GetPlayers()
end

local specdropdown = KillingTab:AddDropdown("Choose Player", function(text)
    for _, player in ipairs(updatePlayerList()) do
        local optionText = player.DisplayName .. " | " .. player.Name
        if text == optionText then
            selectedPlayerToSpectate = player
            if spectating then
                updateSpectateTarget(player)
            end
            break
        end
    end
end)

local spectateSwitch = KillingTab:AddSwitch("Spectate", function(bool)
    spectating = bool
    if spectating and selectedPlayerToSpectate then
        updateSpectateTarget(selectedPlayerToSpectate)
    else
        if currentTargetConnection then
            currentTargetConnection:Disconnect()
            currentTargetConnection = nil
        end
        local localPlayer = game.Players.LocalPlayer
        if localPlayer.Character then
            local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                camera.CameraSubject = humanoid
            end
        end
    end
end)

for _, player in ipairs(updatePlayerList()) do
    specdropdown:Add(player.DisplayName .. " | " .. player.Name)
end

game.Players.PlayerAdded:Connect(function(player)
    specdropdown:Add(player.DisplayName .. " | " .. player.Name)
end)

game.Players.PlayerRemoving:Connect(function(player)
    if selectedPlayerToSpectate and selectedPlayerToSpectate == player then
        selectedPlayerToSpectate = nil
        if spectating then
            spectateSwitch:Set(false)
        end
    end
end)

KillingTab:AddLabel("Kill Aura:").TextSize = 22

local ringPart = nil
local ringColor = Color3.fromRGB(50, 163, 255)
local ringTransparency = 0.6
_G.showDeathRing = false
_G.deathRingRange = 20

local function updateRingSize()
    if not ringPart then return end
    local diameter = (_G.deathRingRange or 20) * 2
    ringPart.Size = Vector3.new(0.2, diameter, diameter)
end

KillingTab:AddTextBox("Range 1-140", function(text)
    local range = tonumber(text)
    if range then
        _G.deathRingRange = math.clamp(range, 1, 140)
        updateRingSize()
    end
end)

local function toggleRingVisual()
    if _G.showDeathRing then
        ringPart = Instance.new("Part")
        ringPart.Shape = Enum.PartType.Cylinder
        ringPart.Material = Enum.Material.Neon
        ringPart.Color = ringColor
        ringPart.Transparency = ringTransparency
        ringPart.Anchored = true
        ringPart.CanCollide = false
        ringPart.CastShadow = false
        updateRingSize()
        ringPart.Parent = workspace
    elseif ringPart then
        ringPart:Destroy()
        ringPart = nil
    end
end

local function updateRingPosition()
    if not ringPart then return end
    local character = checkCharacter()
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        ringPart.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(90))
    end
end

local deathRingSwitch = KillingTab:AddSwitch("Death Ring", function(bool)
    _G.deathRingEnabled = bool
    
    if bool then
        if not _G.deathRingConnection then
            _G.deathRingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                updateRingPosition()
                
                local character = checkCharacter()
                local myPosition = character and character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
                if not myPosition then return end

                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and not isWhitelisted(player) and isPlayerAlive(player) then
                        local distance = (myPosition - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance <= (_G.deathRingRange or 20) then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    else
        if _G.deathRingConnection then
            _G.deathRingConnection:Disconnect()
            _G.deathRingConnection = nil
        end
    end
end)

local visualRingSwitch = KillingTab:AddSwitch("Show Ring", function(bool)
    _G.showDeathRing = bool
    toggleRingVisual()
end)
deathRingSwitch:Set(false)
visualRingSwitch:Set(false)

local whitelistLabel = KillingTab:AddLabel("Whitelist: None")
whitelistLabel.TextColor3 = Color3.fromRGB(26, 122, 212)
whitelistLabel.TextSize = 17

KillingTab:AddButton("Clear Whitelist", function()
    _G.whitelistedPlayers = {}
end)

local blacklistLabel = KillingTab:AddLabel("Killlist: None")
blacklistLabel.TextColor3 = Color3.fromRGB(191, 58, 25)
blacklistLabel.TextSize = 17

KillingTab:AddButton("Clear Blacklist", function()
    _G.blacklistedPlayers = {}
end)

local function updateWhitelistLabel()
    if #_G.whitelistedPlayers == 0 then
        whitelistLabel.Text = "Whitelist: None"
    else
        whitelistLabel.Text = "Whitelist: " .. table.concat(_G.whitelistedPlayers, ", ")
    end
end

local function updateBlacklistLabel()
    if #_G.blacklistedPlayers == 0 then
        blacklistLabel.Text = "Killlist: None"
    else
        blacklistLabel.Text = "Killlist: " .. table.concat(_G.blacklistedPlayers, ", ")
    end
end

task.spawn(function()
    while true do
        updateWhitelistLabel()
        updateBlacklistLabel()
        task.wait(0.2)
    end
end)

local features = window:AddTab("Rebirthing")

features:AddLabel("Farming").TextSize = 20

local player = game.Players.LocalPlayer
local muscleEvent = player:WaitForChild("muscleEvent")
local replicatedStorage = game:GetService("ReplicatedStorage")

local function unequipPets()
    for _, folder in pairs(player.petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                replicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.1)
end

local function equipPetsByName(name)
    unequipPets()
    task.wait(0.01)
    for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do
        if pet.Name == name then
            replicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local isRunning = false

local function fastReb()
    while isRunning do
        equipPetsByName("Swift Samurai")
        task.wait(0.4) 

        local rebirths = player.leaderstats.Rebirths.Value
        local strengthTarget = 5000 + (rebirths * 2550)

        while isRunning and player.leaderstats.Strength.Value < strengthTarget do
            local repsToDo = player.MembershipType == Enum.MembershipType.Premium and 8 or 14
            for _ = 1, repsToDo do
                muscleEvent:FireServer("rep")
            end
            task.wait(0.02)
        end

        if player.leaderstats.Strength.Value >= strengthTarget then
            equipPetsByName("Tribal Overlord")
            task.wait(0.25)

            local before = player.leaderstats.Rebirths.Value
            repeat
                replicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.05)
            until player.leaderstats.Rebirths.Value > before

            task.wait(0.5)
        end
    end
end

local switch = features:AddSwitch("Fast Rebirth", function(bool)
    if bool then
        isRunning = true
        fastReb()
    else
        isRunning = false
    end
end)

local running = false
local thread = nil

local switch = features:AddSwitch("Set Size 1", function(bool)
    running = bool
    if running then
        thread = coroutine.create(function()
            while running do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                wait(0.01)
            end
        end)
        coroutine.resume(thread)
    end
end)
switch:Set(false)

local lockRunning = false
local lockThread = nil

local lockSwitch = features:AddSwitch("Lock Position", function(state)
    lockRunning = state
    if lockRunning then
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local lockPosition = hrp.Position

        lockThread = coroutine.create(function()
            while lockRunning do
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.RotVelocity = Vector3.new(0, 0, 0)
                hrp.CFrame = CFrame.new(lockPosition)
                wait(0.05) 
            end
        end)

        coroutine.resume(lockThread)
    end
end)
lockSwitch:Set(false)

features:AddLabel("Pets").TextSize = 20

local switch = features:AddSwitch("Show Pets", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("hidePets") then
        player.hidePets.Value = bool
    end
end)
switch:Set(false)

features:AddButton("Equip Swift Samurai", function()
    unequipPets()
    equipPetsByName("Swift Samurai")
end)

features:AddButton("Equip Tribal Overlord", function()
    unequipPets()
    equipPetsByName("Tribal Overlord")
end)

local features = window:AddTab("Fast Farming") 
features:Show()

features:AddLabel("Farming").TextSize = 20

local player = game.Players.LocalPlayer
local muscleEvent = player:WaitForChild("muscleEvent")
local runFastRep = false
local repsPerTick = 1

local function getPing()
    local stats = game:GetService("Stats")
    local pingStat = stats:FindFirstChild("PerformanceStats") and stats.PerformanceStats:FindFirstChild("Ping")
    return pingStat and pingStat:GetValue() or 0
end

features:AddTextBox("Rep Speed", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        repsPerTick = math.floor(num)
    end
end, {
    placeholder = "1",
})

local function fastRepLoop()
    while runFastRep do
        local startTime = tick()
        while tick() - startTime < 0.75 and runFastRep do
            for i = 1, repsPerTick do
                muscleEvent:FireServer("rep")
            end
            task.wait(0.02)
        end

        while runFastRep and getPing() >= 350 do
            task.wait(1)
        end
    end
end

features:AddSwitch("Fast Rep", function(state)
    runFastRep = state
    if runFastRep then
        task.spawn(fastRepLoop)
    else
        print("")
    end
end)

features:AddLabel("Misc").TextSize = 20

local function activateProteinEgg()
    local tool = player.Character:FindFirstChild("Protein Egg") or player.Backpack:FindFirstChild("Protein Egg")
    if tool then
        muscleEvent:FireServer("proteinEgg", tool)
    end
end

local running = false

task.spawn(function()
    while true do
        if running then
            activateProteinEgg()
            task.wait(1800)
        else
            task.wait(1)
        end
    end
end)

local switch = features:AddSwitch("Auto Egg", function(state)
    running = state
    if state then
        activateProteinEgg()
    end
end)
switch:Set(false)

local function activateShake()
    local tool = player.Character:FindFirstChild("Tropical Shake") or player.Backpack:FindFirstChild("Tropical Shake")
    if tool then
        muscleEvent:FireServer("tropicalShake", tool)
    end
end

local running = false

task.spawn(function()
    while true do
        if running then
            activateShake()
            task.wait(900)
        else
            task.wait(1)
        end
    end
end)

local switch = features:AddSwitch("Auto Shake", function(state)
    running = state
    if state then
        activateShake()
    end
end)
switch:Set(false)

features:AddButton("Anti Lag", function()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local lighting = game:GetService("Lighting")

    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            gui:Destroy()
        end
    end

    local function darkenSky()
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("Sky") then
                v:Destroy()
            end
        end

        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"
        darkSky.SkyboxBk = "rbxassetid://0"
        darkSky.SkyboxDn = "rbxassetid://0"
        darkSky.SkyboxFt = "rbxassetid://0"
        darkSky.SkyboxLf = "rbxassetid://0"
        darkSky.SkyboxRt = "rbxassetid://0"
        darkSky.SkyboxUp = "rbxassetid://0"
        darkSky.Parent = lighting

        lighting.Brightness = 0
        lighting.ClockTime = 0
        lighting.TimeOfDay = "00:00:00"
        lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        lighting.Ambient = Color3.new(0, 0, 0)
        lighting.FogColor = Color3.new(0, 0, 0)
        lighting.FogEnd = 100

        task.spawn(function()
            while true do
                wait(5)
                if not lighting:FindFirstChild("DarkSky") then
                    darkSky:Clone().Parent = lighting
                end
                lighting.Brightness = 0
                lighting.ClockTime = 0
                lighting.OutdoorAmbient = Color3.new(0, 0, 0)
                lighting.Ambient = Color3.new(0, 0, 0)
                lighting.FogColor = Color3.new(0, 0, 0)
                lighting.FogEnd = 100
            end
        end)
    end

    local function removeParticleEffects()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") then
                obj:Destroy()
            end
        end
    end

    local function removeLightSources()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            end
        end
    end

    removeParticleEffects()
    removeLightSources()
    darkenSky()
end)

features:AddLabel("Pets").TextSize = 20

features:AddButton("Equip Swift Samurai", function()
    unequipPets()
    equipPetsByName("Swift Samurai")
end)

features:AddButton("Equip Tribal Overlord", function()
    unequipPets()
    equipPetsByName("Tribal Overlord")
end)

local features = window:AddTab("Farming") 
features:Show() 

features:AddLabel("Misc").TextSize = 20

local virtualUser = game:GetService("VirtualUser")
local players = game:GetService("Players")
local connection

local function enableAntiAFK()
    if connection then return end
    connection = players.LocalPlayer.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)
end

local function disableAntiAFK()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

local switch = features:AddSwitch("Anti-AFK", function(enabled)
    if enabled then
        enableAntiAFK()
    else
        disableAntiAFK()
    end
end)
switch:Set(true)

local switch = features:AddSwitch("Auto Lift (Slow its the Gamepass)", function(bool)
    local player = game:GetService("Players").LocalPlayer
    if player:FindFirstChild("autoLiftEnabled") then
        player.autoLiftEnabled.Value = bool
    end
end)
switch:Set(false)

features:AddLabel("Machines").TextSize = 20

local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = game:GetService("Players").LocalPlayer

features:AddButton("Jungle Lift",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8642.396484375, 6.7980651855, 2086.1030273)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

features:AddButton("Jungle Squat",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8371.43359375, 6.79806327, 2858.88525390)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

features:AddButton("King Lift",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8769.083, 17.2190, -5665.84228)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

features:AddButton("King Squat",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8762.1689, 17.2190, -6044.04980)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

features:AddButton("Legends Lift",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(4528.474609375, 989.0000629425, -4001.05151367)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

features:AddButton("Legends Squat",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(4431.306152, 991.5455322, -4051.4296)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

features:AddButton("Legends Pull Up",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(4298.6323, 991.54040, -4119.97363)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)

local features = window:AddTab("Inv Cleaner")

features:AddLabel("Misc").TextSize = 20

local function activateProteinEgg()
    local tool = player.Character:FindFirstChild("Protein Egg") or player.Backpack:FindFirstChild("Protein Egg")
    if tool then
        muscleEvent:FireServer("proteinEgg", tool)
    end
end

local running = false

task.spawn(function()
    while true do
        if running then
            activateProteinEgg()
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)

local switch = features:AddSwitch("Egg Devour", function(state)
    running = state
    if state then
        activateProteinEgg()
    end
end)
switch:Set(false)

local itemList = {
    "Tropical Shake",
    "Energy Shake",
    "Protein Bar",
    "TOUGH Bar",
    "Protein Shake",
    "ULTRA Shake",
    "Energy Bar"
}

local function formatEventName(itemName)
    local parts = {}
    for word in itemName:gmatch("%S+") do
        table.insert(parts, word:lower())
    end
    for i = 2, #parts do
        parts[i] = parts[i]:sub(1,1):upper() .. parts[i]:sub(2)
    end
    return table.concat(parts)
end

local function activateItems()
    for _, itemName in ipairs(itemList) do
        local tool = player.Character:FindFirstChild(itemName) or player.Backpack:FindFirstChild(itemName)
        if tool then
            local eventName = formatEventName(itemName) 
            muscleEvent:FireServer(eventName, tool)
        end
    end
end

local running = false

task.spawn(function()
    while true do
        if running then
            activateItems()
            task.wait(1)
        else
            task.wait(1)
        end
    end
end)

local switch = features:AddSwitch("Eat Everything", function(state)
    running = state
    if state then
        activateItems()
    end
end)
switch:Set(false)


local features = window:AddTab("Teleports") 
features:Show() 

features:AddLabel("Main").TextSize = 20

features:AddButton("Tiny Island",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-37.1, 9.2, 1919)
	end)

features:AddButton("Main Island",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(16.07, 9.08, 133.8)
	end)

features:AddButton("Beach",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8, 9, -169.2)
	end)

features:AddLabel("Gyms").TextSize = 22

features:AddButton("Muscle King Gym",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8665.4, 17.21, -5792.9)
	end)

features:AddButton("Jungle Gym",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-8543, 6.8, 2400)
	end)

features:AddButton("Legends Gym",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(4516, 991.5, -3856)
	end)

features:AddButton("Infernal Gym",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-6759, 7.36, -1284)
	end)

features:AddButton("Mythical Gym",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(2250, 7.37, 1073.2)
	end)

features:AddButton("Frost Gym",function()
    local player = game.Players.LocalPlayer
    local char = player.Character or Player.CharacterAdded:wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(-2623, 7.36, -409)
	end)

local statsTab = window:AddTab("Stats")

local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local strengthStat = leaderstats:WaitForChild("Strength")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")
local durabilityStat = player:WaitForChild("Durability")

local function formatNumber(number)
    local isNegative = number < 0
    number = math.abs(number)

    if number >= 1e15 then
        return (isNegative and "-" or "") .. string.format("%.2fQa", number / 1e15)
    elseif number >= 1e12 then
        return (isNegative and "-" or "") .. string.format("%.2fT", number / 1e12)
    elseif number >= 1e9 then
        return (isNegative and "-" or "") .. string.format("%.2fB", number / 1e9)
    elseif number >= 1e6 then
        return (isNegative and "-" or "") .. string.format("%.2fM", number / 1e6)
    elseif number >= 1e3 then
        return (isNegative and "-" or "") .. string.format("%.2fK", number / 1e3)
    else
        return (isNegative and "-" or "") .. string.format("%.2f", number)
    end
end

local timeLabel = statsTab:AddLabel("Time:")
timeLabel.TextSize = 24
timeLabel.Font = Enum.Font.PatrickHand

local stopwatchLabel = statsTab:AddLabel("0d 0h 0m 0s")
stopwatchLabel.TextSize = 20
stopwatchLabel.Font = Enum.Font.PatrickHand

local projectedRebirthsLabel = statsTab:AddLabel("Projected Rebirths: 0 /Hour | 0 /Day")
projectedRebirthsLabel.TextSize = 20
projectedRebirthsLabel.Font = Enum.Font.PatrickHand

local projectedStrengthLabel = statsTab:AddLabel("Projected Strength: 0 /Hour | 0 /Day")
projectedStrengthLabel.TextSize = 20
projectedStrengthLabel.Font = Enum.Font.PatrickHand

local projectedDurabilityLabel = statsTab:AddLabel("Projected Durability: 0 /Hour | 0 /Day")
projectedDurabilityLabel.TextSize = 20
projectedDurabilityLabel.Font = Enum.Font.PatrickHand

statsTab:AddLabel("").TextSize = 10

local statsLabel = statsTab:AddLabel("Stats:")
statsLabel.TextSize = 24
statsLabel.Font = Enum.Font.PatrickHand

local strengthLabel = statsTab:AddLabel("Strength: 0 | Gained: 0")
strengthLabel.TextSize = 20
strengthLabel.Font = Enum.Font.PatrickHand

local durabilityLabel = statsTab:AddLabel("Durability: 0 | Gained: 0")
durabilityLabel.TextSize = 20
durabilityLabel.Font = Enum.Font.PatrickHand

local rebirthsLabel = statsTab:AddLabel("Rebirths: 0 | Gained: 0")
rebirthsLabel.TextSize = 20
rebirthsLabel.Font = Enum.Font.PatrickHand

local startTime = tick()
local initialStrength = strengthStat.Value
local initialDurability = durabilityStat.Value
local initialRebirths = rebirthsStat.Value

task.spawn(function()
    local lastUpdate = 0

    while true do
        local currentTime = tick()
        local elapsedTime = currentTime - startTime
        local days = math.floor(elapsedTime / (24 * 3600))
        local hours = math.floor((elapsedTime % (24 * 3600)) / 3600)
        local minutes = math.floor((elapsedTime % 3600) / 60)
        local seconds = math.floor(elapsedTime % 60)

        stopwatchLabel.Text = string.format("%dd %dh %dm %ds", days, hours, minutes, seconds)

        local currentStrength = strengthStat.Value
        local currentRebirths = rebirthsStat.Value
        local currentDurability = durabilityStat.Value

        local sessionStrengthDelta = currentStrength - initialStrength
        local sessionDurabilityDelta = currentDurability - initialDurability
        local sessionRebirthsDelta = currentRebirths - initialRebirths

        strengthLabel.Text = "Strength: " .. formatNumber(currentStrength) .. " | Gained: " .. formatNumber(sessionStrengthDelta)
        durabilityLabel.Text = "Durability: " .. formatNumber(currentDurability) .. " | Gained: " .. formatNumber(sessionDurabilityDelta)
        rebirthsLabel.Text = "Rebirths: " .. formatNumber(currentRebirths) .. " | Gained: " .. formatNumber(sessionRebirthsDelta)

        if currentTime - lastUpdate >= 6 then
            lastUpdate = currentTime

            local rebirthsPerSecond = sessionRebirthsDelta / elapsedTime
            local strengthPerSecond = sessionStrengthDelta / elapsedTime
            local durabilityPerSecond = sessionDurabilityDelta / elapsedTime

            local secondsPerHour = 3600
            local secondsPerDay = 86400

            local rebirthsPerHour = math.floor(rebirthsPerSecond * secondsPerHour)
            local strengthPerHour = math.floor(strengthPerSecond * secondsPerHour)
            local durabilityPerHour = math.floor(durabilityPerSecond * secondsPerHour)

            local projectedRebirths = math.floor(rebirthsPerSecond * secondsPerDay)
            local projectedStrength = math.floor(strengthPerSecond * secondsPerDay)
            local projectedDurability = math.floor(durabilityPerSecond * secondsPerDay)

            projectedRebirthsLabel.Text = "Rebirth Pace: " .. formatNumber(rebirthsPerHour) .. "/Hour | " .. formatNumber(projectedRebirths) .. "/Day"
            projectedStrengthLabel.Text = "Strength Pace: " .. formatNumber(strengthPerHour) .. "/Hour | " .. formatNumber(projectedStrength) .. "/Day"
            projectedDurabilityLabel.Text = "Durability Pace: " .. formatNumber(durabilityPerHour) .. "/Hour | " .. formatNumber(projectedDurability) .. "/Day"
        end

        task.wait(0.05)
    end
end)

local infoTab = window:AddTab("Info")
infoTab:Show()
infoTab:AddLabel("Script is made by Henne").TextSize = 20
infoTab:AddLabel("Any Problems/Questions? -> imhenne on Discord").TextSize = 20
infoTab:AddLabel("")
local wLabel = infoTab:AddLabel("VERSION//1.3")
wLabel.TextSize = 40
wLabel.Font = Enum.Font.Arcade

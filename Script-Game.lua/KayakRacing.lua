-- โหลด Library Fluent
local Library = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Library:CreateWindow({
    Title = "🚣‍♂️Kayak Racing " .. Library.Version,
    SubTitle = "BY TURK X SRCIPTS",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- RemoteEvent Reliable
local Reliable = ReplicatedStorage.Warp.Index.Event.Reliable

-- ตัวแปร Auto Reliable
local AutoReliable = false
local SpeedReliable = 0.0 -- ความเร็วส่ง RemoteEvent
local Buffers = {
    "\254\2\0\6\5Power\1\1",
    "\254\2\0\6\5Power\1\2",
    "\254\2\0\6\5Power\1\3",
    "\254\2\0\6\5Power\1\4",
    "\254\2\0\6\5Power\1\5",
    "\254\2\0\6\5Power\1\6",
    "\254\2\0\6\5Power\1\7",
    "\254\2\0\6\5Power\1\8",
    "\254\2\0\6\5Power\1\9",
    "\254\2\0\6\5Power\1\10",
    "\254\2\0\6\5Power\1\11",
    "\254\2\0\6\5Power\1\12",
}

-- ตัวแปร Auto Win
local AutoWin = false
local SpeedWarp = 0.0
local CurrentStage = 1
local MaxStage = 18
local TargetPosition = Vector3.new(119.26000213623047, 5.636999607086182, -18.369998931884766)

-- ฟังก์ชันวาปไป Stage
local function WarpToSign(stageNum)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    local trackFolder = Workspace:WaitForChild("Track", 5)
    if hrp and trackFolder then
        local stageName = "Stage" .. string.format("%02d", stageNum)
        local stageFolder = trackFolder:FindFirstChild(stageName)
        if stageFolder then
            local sign = stageFolder:FindFirstChild("Sign")
            if sign then
                hrp.CFrame = sign.CFrame + Vector3.new(0,3,0)
            end
        end
    end
end

-- ฟังก์ชันวาปไปพิกัดเฉพาะ
local function WarpToPosition(pos)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    if hrp then
        hrp.CFrame = CFrame.new(pos)
    end
end

-- สร้าง Tab
local MainTab = Window:AddTab({ Title = "Menu", Icon = "" })

-- Toggle Auto Reliable
MainTab:AddToggle("AutoReliable", {
    Title = "AutoReliable",
    Description = "off/on AutoReliable",
    Default = false,
    Callback = function(state)
        AutoReliable = state
        print("Auto Reliable:", state)
    end
})

-- Toggle Auto Win
MainTab:AddToggle("AutoWin", {
    Title = "Auto Win ",
    Description = "off/on Auto Win",
    Default = false,
    Callback = function(state)
        AutoWin = state
        print("Auto Win:", state)
    end
})


-- Loop Auto Reliable
spawn(function()
    while true do
        wait(SpeedReliable)
        if AutoReliable then
            pcall(function()
                for _, buf in ipairs(Buffers) do
                    Reliable:FireServer(buffer.fromstring("\27"), buffer.fromstring(buf))
                end
            end)
        end
    end
end)

-- Loop Auto Win + ตรวจสอบ SignStatus
spawn(function()
    while true do
        wait(SpeedWarp)
        if AutoWin then
            pcall(function()
                local doorFolder = Workspace:FindFirstChild("WorldMain") and Workspace.WorldMain:FindFirstChild("Door")
                local signStatus = doorFolder and doorFolder:FindFirstChild("SignStatus")
                if signStatus then
                    -- เจอ SignStatus → หยุด Auto Win Stage ปกติ, วาปไปพิกัด Target
                    WarpToPosition(TargetPosition)
                else
                    -- ไม่เจอ SignStatus → Auto Win Stage ปกติ
                    WarpToSign(CurrentStage)
                    CurrentStage = CurrentStage + 1
                    if CurrentStage > MaxStage then
                        CurrentStage = 1
                    end
                end
            end)
        end
    end
end)
-- SaveManager & InterfaceManager
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- โหลด config อัตโนมัติ
SaveManager:LoadAutoloadConfig()

-- เลือก Tab เริ่มต้น
Window:SelectTab(1)

-- ตัวอย่างแจ้งเตือนเปิดสคริปต์
Fluent:Notify({
    Title = "My Hub",
    Content = "โหลดสคริปต์เสร็จแล้ว!",
    Duration = 5
})

-- โหลด Library Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- สร้างหน้าต่าง
local Window = Fluent:CreateWindow({
    Title = "🚣‍♂️ Kayak Racing / การแข่งขันเรือคายัค " .. Fluent.Version,
    SubTitle = "BY TURK X SCRIPTS / โดย TURK X SCRIPTS",
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
local Reliable = ReplicatedStorage:WaitForChild("Warp"):WaitForChild("Index"):WaitForChild("Event"):WaitForChild("Reliable")

-- ตัวแปร Auto
local AutoReliable = false
local SpeedReliable = 1 -- หน่วยวินาที
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
    "\254\2\0\6\5Power\1\12"
}

local AutoWin = false
local SpeedWarp = 1
local CurrentStage = 1
local MaxStage = 18
local TargetPosition = Vector3.new(119.26, 5.63, -18.36)

-- สร้างแท็บ
local Tabs = {
    Main = Window:AddTab({ Title = "Main / เมนูหลัก", Icon = "package" }),
    Settings = Window:AddTab({ Title = "Settings / ตั้งค่า", Icon = "settings" })
}

-- ================================
-- Main Tab Toggles
-- ================================
Tabs.Main:AddToggle("AutoReliable", {
    Title = "AutoReliable / ออโต้เรียลายเบิล",
    Description = "ON/OFF AutoReliable / เปิด/ปิด AutoReliable",
    Default = false,
    Callback = function(state)
        AutoReliable = state
        print("Auto Reliable:", state)
    end
})

Tabs.Main:AddToggle("AutoWin", {
    Title = "AutoWin / ออโต้ชนะ",
    Description = "ON/OFF Auto Win / เปิด/ปิด Auto Win",
    Default = false,
    Callback = function(state)
        AutoWin = state
        print("Auto Win:", state)
    end
})

-- ================================
-- Settings Tab UI
-- ================================
local UISettings = Tabs.Settings:AddSection("UI Settings / การตั้งค่า UI")

UISettings:AddToggle("AcrylicToggle", {
    Title = "Blur (Acrylic) / เบลอ (Acrylic)",
    Description = "ON/OFF Acrylic Blur / เปิด/ปิด Blur",
    Default = true,
    Callback = function(state)
        Window:SetAcrylic(state)
    end
})

-- ================================
-- Loop AutoReliable
-- ================================
local AutoReliableCoroutine
AutoReliableCoroutine = coroutine.create(function()
    while true do
        task.wait(SpeedReliable)
        if Fluent.Unloaded then break end
        if AutoReliable then
            pcall(function()
                for _, buf in ipairs(Buffers) do
                    Reliable:FireServer(buf)
                end
            end)
        end
    end
end)
coroutine.resume(AutoReliableCoroutine)

-- ================================
-- ฟังก์ชันวาป
-- ================================
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

local function WarpToPosition(pos)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    if hrp then
        hrp.CFrame = CFrame.new(pos)
    end
end

-- ================================
-- Loop AutoWin
-- ================================
local AutoWinCoroutine
AutoWinCoroutine = coroutine.create(function()
    while true do
        task.wait(SpeedWarp)
        if Fluent.Unloaded then break end
        if AutoWin then
            pcall(function()
                local doorFolder = Workspace:FindFirstChild("WorldMain") and Workspace.WorldMain:FindFirstChild("Door")
                local signStatus = doorFolder and doorFolder:FindFirstChild("SignStatus")
                if signStatus then
                    WarpToPosition(TargetPosition)
                else
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
coroutine.resume(AutoWinCoroutine)

-- ================================
-- SaveManager & InterfaceManager
-- ================================
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

-- แจ้งเตือนโหลดสคริปต์เสร็จ
Fluent:Notify({
    Title = "My Hub / ฮับของฉัน",
    Content = "Script loaded successfully! / โหลดสคริปต์เสร็จแล้ว!",
    Duration = 5
})

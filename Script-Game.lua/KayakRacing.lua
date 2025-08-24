-- โหลด Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- สร้างหน้าต่าง
local Window = Fluent:CreateWindow({
    Title = "Block Spawner " .. Fluent.Version,
    SubTitle = "by You",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- สร้างแท็บ
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "package" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- ================================
-- Main Tab (Block Spawner)
-- ================================
local Section = Tabs.Main:AddSection("Spawn Blocks")

-- Multi Dropdown เลือก Block
local BlockDropdown = Section:AddDropdown("BlockDropdown", {
    Title = "เลือก Block (สูงสุด 3)",
    Values = {"Lucky", "Super", "Diamond", "Rainbow", "Galaxy"},
    Multi = true,
    Default = {}
})

-- ปุ่มกด Spawn
Section:AddButton({
    Title = "Spawn Selected Blocks",
    Description = "กดเพื่อ Spawn Block ที่เลือก",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local selected = {}
        for name, state in pairs(BlockDropdown.Value) do
            if state then table.insert(selected, name) end
        end

        -- จำกัดไม่เกิน 3 Block
        if #selected > 3 then
            Fluent:Notify({
                Title = "Error",
                Content = "เลือกได้สูงสุด 3 Block เท่านั้น!",
                Duration = 5
            })
            return
        end

        -- Spawn Block ตามที่เลือก
        for _, block in ipairs(selected) do
            if block == "Lucky" then
                ReplicatedStorage.SpawnLuckyBlock:FireServer()
            elseif block == "Super" then
                ReplicatedStorage.SpawnSuperBlock:FireServer()
            elseif block == "Diamond" then
                ReplicatedStorage.SpawnDiamondBlock:FireServer()
            elseif block == "Rainbow" then
                ReplicatedStorage.SpawnRainbowBlock:FireServer()
            elseif block == "Galaxy" then
                ReplicatedStorage.SpawnGalaxyBlock:FireServer()
            end
        end
    end
})

-- ================================
-- Settings Tab (UI Controls)
-- ================================
local UISettings = Tabs.Settings:AddSection("UI Settings")

-- Toggle Acrylic Blur
local AcrylicToggle = UISettings:AddToggle("AcrylicToggle", {
    Title = "เปิด/ปิด Blur (Acrylic)",
    Default = true
})
AcrylicToggle:OnChanged(function()
    Window:SetAcrylic(AcrylicToggle.Value)
end)

-- Dropdown เปลี่ยน Theme
local ThemeDropdown = UISettings:AddDropdown("ThemeDropdown", {
    Title = "Theme",
    Values = {"Dark", "Light"},
    Default = "Dark"
})
ThemeDropdown:OnChanged(function(Value)
    Window:SetTheme(Value)
end)

-- ปุ่มซ่อน/แสดง UI
UISettings:AddButton({
    Title = "Minimize UI",
    Description = "ซ่อน/แสดง Fluent UI",
    Callback = function()
        Window:Minimize()
    end
})

-- เลือกแท็บเริ่มต้น
Window:SelectTab(1)

-- แจ้งเตือนโหลดเสร็จ
Fluent:Notify({
    Title = "Block Spawner Loaded",
    Content = "เลือก Block ได้สูงสุด 3 ชิ้นแล้วกด Spawn",
    Duration = 5
})
-- Addons:
-- SaveManager (อนุญาตให้คุณมีระบบบันทึกการตั้งค่า)
-- InterfaceManager (อนุญาตให้คุณมีระบบจัดการ Interface ของ UI)

-- ส่ง library ให้กับตัวจัดการ (Managers)
SaveManager:SetLibrary(Fluent)       -- บอก SaveManager ให้ใช้งาน Fluent UI
InterfaceManager:SetLibrary(Fluent)  -- บอก InterfaceManager ให้ใช้งาน Fluent UI

-- ข้ามการบันทึกคีย์ที่ใช้โดย ThemeManager
-- (เราไม่ต้องการให้ configs บันทึก Theme)
SaveManager:IgnoreThemeSettings()

-- คุณสามารถเพิ่ม index ของ element ที่ SaveManager จะไม่บันทึกได้
SaveManager:SetIgnoreIndexes({})

-- ตัวอย่างการใช้งานแบบนี้:
-- script hub อาจมี theme อยู่ในโฟลเดอร์รวม
-- และ config ของเกมแต่ละเกมแยกเก็บในโฟลเดอร์เฉพาะ
InterfaceManager:SetFolder("FluentScriptHub")           -- ตั้งโฟลเดอร์สำหรับ InterfaceManager
SaveManager:SetFolder("FluentScriptHub/specific-game")   -- ตั้งโฟลเดอร์สำหรับ SaveManager

-- สร้าง Section ของ Interface และ Config ในแท็บ Settings
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- เลือกแท็บเริ่มต้นเป็นแท็บแรก
Window:SelectTab(1)

-- แจ้งเตือนว่า script โหลดเสร็จ
Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.", -- แปล: "สคริปต์โหลดเสร็จแล้ว"
    Duration = 8
})

-- คุณสามารถใช้ SaveManager:LoadAutoloadConfig() เพื่อโหลด config
-- ที่ถูกตั้งให้โหลดอัตโนมัติ
SaveManager:LoadAutoloadConfig()

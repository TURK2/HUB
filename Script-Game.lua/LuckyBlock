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
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Section
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

-- เลือกแท็บเริ่มต้น
Window:SelectTab(1)

-- แจ้งเตือนโหลดเสร็จ
Fluent:Notify({
    Title = "Block Spawner Loaded",
    Content = "เลือก Block ได้สูงสุด 3 ชิ้นแล้วกด Spawn",
    Duration = 5
})

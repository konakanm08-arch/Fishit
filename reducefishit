-- VOID TOTAL DELAY 5 MENIT
-- Aktif setelah 300 detik (5 menit)

getgenv().VoidDelay = true

task.spawn(function()
    local plr = game.Players.LocalPlayer
    local delayMenit = 5 -- ganti kalo mau 10 menit dll
    
    print("⏳ VOID DELAY AKTIF - Bakal hajar semua dalam "..delayMenit.." menit")
    
    -- hitung mundur
    for i = delayMenit*60, 1, -1 do
        if not getgenv().VoidDelay then return end
        if i % 60 == 0 then
            print("⏳ Sisa "..(i/60).." menit lagi...")
        end
        task.wait(1)
    end

    print("💥 WAKTU HABIS - MENGHAPUS SEMUA MAP TERMASUK SPAWN!")

    -- SET LOW
    pcall(function()
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 999999
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        settings().Rendering.QualityLevel = 1
    end)

    -- PLATFORM ANTI VOID
    if workspace:FindFirstChild("AntiVoid") then workspace.AntiVoid:Destroy() end
    local plat = Instance.new("Part")
    plat.Name = "AntiVoid"
    plat.Size = Vector3.new(500, 2, 500)
    plat.Anchored = true
    plat.CanCollide = true
    plat.Color = Color3.fromRGB(20,20,20)
    plat.Parent = workspace
    
    task.spawn(function()
        while getgenv().VoidDelay do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plat.Position = plr.Character.HumanoidRootPart.Position - Vector3.new(0,6,0)
            end
            task.wait(0.05)
        end
    end)

    local function hajar(obj)
        if obj.Name == "AntiVoid" or obj.Name == "Terrain" or obj.Name == "Camera" then return end
        if game.Players:FindFirstChild(obj.Name) then return end
        if obj.Parent ~= workspace then return end
        if obj:IsA("Model") or obj:IsA("Folder") then
            pcall(function() obj:Destroy() end)
        end
    end

    -- HAJAR SEKARANG
    for _, v in pairs(workspace:GetChildren()) do hajar(v) end

    -- AUTO HAJAR TERUS
    workspace.ChildAdded:Connect(function(child)
        if not getgenv().VoidDelay then return end
        task.wait(0.3)
        hajar(child)
    end)

    while getgenv().VoidDelay do
        task.wait(2)
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name ~= "AntiVoid" and v.Name ~= "Terrain" and v.Name ~= "Camera" and not game.Players:FindFirstChild(v.Name) then
                if v:IsA("Model") or v:IsA("Folder") then pcall(function() v:Destroy() end) end
            end
        end
    end
end)

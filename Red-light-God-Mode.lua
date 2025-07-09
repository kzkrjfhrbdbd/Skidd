do
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local Client = Players.LocalPlayer
    local TrafficLightImage = Client.PlayerGui:WaitForChild("ImpactFrames"):WaitForChild("TrafficLightEmpty")

    local IsGreenLight = TrafficLightImage.Image == ReplicatedStorage.Effects.Images.TrafficLights.GreenLight.Image
    local LastRootPartCFrame = nil

    ReplicatedStorage.Remotes.Effects.OnClientEvent:Connect(function(EffectsData)
        if EffectsData.EffectName == "TrafficLight" then
            IsGreenLight = EffectsData.GreenLight == true
            local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
            LastRootPartCFrame = RootPart and RootPart.CFrame
        end
    end)

    local OldNamecall
    OldNamecall = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = { ... }

        if method == "FireServer" and self.ClassName == "RemoteEvent" and self.Name == "rootCFrame" then
            if GetToggleValue("RedLightGodMode") and not IsGreenLight and LastRootPartCFrame then
                args[1] = LastRootPartCFrame
                return OldNamecall(self, unpack(args))
            end
        end

        return OldNamecall(self, ...)
    end))
end

local debris=game:GetService("Debris")
local replicatedStorage=game:GetService("ReplicatedStorage")

local remotes=replicatedStorage:WaitForChild("Remotes")
local shared=replicatedStorage:WaitForChild("Shared")

remotes.Attack.OnServerEvent:Connect(function(player: Player, argumentData)
    local character=player.Character

    if character then
        local humanoid: Humanoid=character:FindFirstChild("Humanoid")
        if humanoid then
            if character:FindFirstChild("Attacking") then
                return
            end

            local attacking=Instance.new("BoolValue")
            attacking.Name="Attacking"
            attacking.Parent=character
            attacking.Value=true

            debris:AddItem(attacking, .5)

            print("Fierce attack from ".. player.Name.. "!")
        end
    end
end)

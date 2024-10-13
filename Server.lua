local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteInstaller = require(ReplicatedStorage.RemoteInstaller)

local InstallRequest = ReplicatedStorage.RemoteInstaller.Install
local EventRequest = ReplicatedStorage.RemoteInstaller.Request
local DisconnectEvent = ReplicatedStorage.RemoteInstaller.Disconnect

InstallRequest.OnServerEvent:Connect(function(player)
	if not ReplicatedStorage:FindFirstChild("RemotePackages") then
		local RemotePackages = Instance.new("Folder", ReplicatedStorage)
		RemotePackages.Name = "RemotePackages"
	end
end)

EventRequest.OnServerEvent:Connect(function(player, Name, Type)
	local foundPackage = script.ServerPackages:FindFirstChild(Name)
	if foundPackage then
		foundPackage.Parent = ReplicatedStorage:WaitForChild("RemotePackages")
	else
		local remotePackages = ReplicatedStorage:WaitForChild("RemotePackages") or Instance.new("Folder", ReplicatedStorage)
		remotePackages.Name = "RemotePackages"
		local newPackage = Instance.new(Type, remotePackages)
		newPackage.Name = Name
	end
end)

DisconnectEvent.OnServerEvent:Connect(function(player, Name, Type)
	if ReplicatedStorage:WaitForChild("RemotePackages"):FindFirstChild(Name) then
		if typeof(ReplicatedStorage:WaitForChild("RemotePackages")[Name] == Type) then
			ReplicatedStorage:WaitForChild("RemotePackages")[Name].Parent = script.ServerPackages
		end
	end
end)

ReplicatedStorage:WaitForChild("RemotePackages"):WaitForChild("Bomba").OnServerEvent:Connect(function(player, message)
	print(message)
end)

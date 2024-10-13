local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local install = {}

function install:Instantiate(Name: string, Type: "RemoteEvent" | "RemoteFunction" | "BindableEvent")
	local isClient = RunService:IsClient()
	local RemotePackages : Folder
	if isClient then
		script.Install:FireServer()
		script.Request:FireServer(Name, Type)
	else
		RemotePackages = ReplicatedStorage:WaitForChild("RemotePackages") or Instance.new("Folder", ReplicatedStorage)
	end
end

function install:Disconnect(Name: string, Type: "RemoteEvent" | "RemoteFunction" | "BindableEvent")
	local isClient = RunService:IsClient()
	local RemotePackages = ReplicatedStorage:WaitForChild("RemotePackages") or Instance.new("Folder", ReplicatedStorage)
	RemotePackages.Name = "RemotePackages"
	if isClient then
		script.Disconnect:FireServer(Name, Type)
	else
		RemotePackages[Name].Parent = game.ServerScriptService.RecieveClientPackage.ServerPackages
	end
end

return install

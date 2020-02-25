Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Event")

local Event = {}
Event.__index = Event

Console.log("Assembling script...")
Console.log("Initializing locals...")

function Event.new()
	local self = setmetatable({}, Event)
	self.listeners = {}
	self.Registrar = {}
	self.Registrar.listeners = self.listeners
	self.Registrar.Connect = self.Connect
	self.Registrar.Disconnect = self.Disconnect
	self.Activator = {}
	self.Activator.listeners = self.listeners
	self.Activator.Fire = self.Fire
	return self
end

function Event:Connect(fn)
	table.insert(self.listeners, fn)
	return #self.listeners
end

function Event:Disconnect(id)
	table.remove(self.listeners, id)
end

function Event:Fire(...)
	for _, fn in ipairs(self.listeners) do
		fn(...)
	end
end

Console.log("Initialized.")
Console.log("Assembled.")

return Event

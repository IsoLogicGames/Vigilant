Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Event")

local Event = {}
Event.__index = Event

Console.log("Assembling script...")
Console.log("Initializing locals...")

function Event.new()
	local self = setmetatable({}, Event)
	return self
end

Console.log("Initialized.")
Console.log("Assembled.")

return Event

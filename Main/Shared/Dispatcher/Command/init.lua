Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Command")

local Command = {}
Command.__index = Command

Console.log("Assembling script...")
Console.log("Initializing locals...")

function Command.new()
	local self = setmetatable({}, Command)
	self.Name = ""
	return self
end

function Command:Update()
	Console.warn("Update must be overridden and should not be called from Command.")
	return {}
end

function Command:Listener()
	Console.warn("Listener must be overridden and should not be called from Command.")
end

Console.log("Initialized.")
Console.log("Assembled.")

return Command

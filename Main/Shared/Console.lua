local Logger = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Logger"))

local MessageType = {
	["Log"] = 1,
	["Warning"] = 2,
	["Error"] = 3
}

local function formatMessage(message, source)
	source = source or "Console"
	return string.format("%s: %s", source, message)
end

local Console = {}
local ConsoleLogger = Logger.new()
local defaultOutput = true

Console.__index = Console

function Console.setDefaultOutput(value)
	value = value or false and true
	defaultOutput = value
end

function Console.getDefaultOutput()
	return defaultOutput
end

function Console.entries()
	return ConsoleLogger:Entries()
end

function Console.log(message, source)
	ConsoleLogger:Log(message, source, MessageType.Log)
	if defaultOutput then
		print(formatMessage(message, source))
	end
end

function Console.warn(message, source)
	ConsoleLogger:Log(message, source, MessageType.Warning)
	if defaultOutput then
		warn(formatMessage(message, source))
	end
end

function Console.error(message, source)
	ConsoleLogger:Log(message, source, MessageType.Error)
	if defaultOutput then
		error(formatMessage(message, source))
	end
end

function Console.sourced(source)
	local sourcedConsole = setmetatable({}, Console)
	
	function sourcedConsole.log(message)
		Console.log(message, source)
	end
	
	function sourcedConsole.warn(message)
		Console.warn(message, source)
	end
	
	function sourcedConsole.error(message)
		Console.error(message, source)
	end
	
	return sourcedConsole
end

return Console

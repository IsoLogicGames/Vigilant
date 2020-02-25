MessageType = {
	["Standard"] = 1,
	["Warning"] = 2,
	["Error"] = 3
}

local Console = {}
local log = {}
local Message = {}
Message.__index = Message

function Message.new(message, type, source, time)
	local self = setmetatable({}, Message)
	self.Message = message
	self.Type = type or MessageType.Standard
	self.Source = source or "Log"
	self.Time = time or os.time()
	return self
end

function Message:ToString()
	local date = os.date("*t", self.Time)
	local type = "Unknown"
	if self.Type == MessageType.Standard then
		type = "Console"
	elseif self.Type == MessageType.Warning then
		type = "Warning"
	elseif self.Type == MessageType.Error then
		type = "Error"
	end
	return string.format("%02d:%02d:%02d - %s %s: %s", date.hour, date.min, date.sec, self.Source, type, self.Message)
end

function Message:Output()
	print(self:ToString())
end

function Console.log(string, type, source)
	local message = Message.new(string, type, source)
	table.insert(log, message)
	message:Output()
end

function Console.warn(string, source)
	Console.log(string, MessageType.Warning, source)
end

function Console.error(string, source)
	Console.log(string, MessageType.Error, source)
end

function Console.sourced(source)
	local sourcedConsole = {}
	
	function sourcedConsole.log(string, type)
		Console.log(string, type, source)
	end
	
	function sourcedConsole.warn(string)
		Console.warn(string, source)
	end
	
	function sourcedConsole.error(string)
		Console.error(string, source)
	end
	
	return sourcedConsole
end

return Console

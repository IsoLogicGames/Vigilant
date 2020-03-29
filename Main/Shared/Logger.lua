print("Logger: Initializing variables...")

local Logger = {}

print("Logger: Constructing objects...")

Logger.__index = Logger

function Logger.new()
	local self = setmetatable({}, Logger)
	self.log = {}
	return self
end

function Logger:Log(...)
	table.insert(log, {os.time(), ...})
end

function Logger:Entries()
	return ipairs(self.log)
end

print("Logger: Done.")

return Logger

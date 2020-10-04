--- A tool to record entries.
-- Creates a simple log, logs entries, and allows iteration over entries.
--
-- @author LastTalon
-- @version 0.1.0, 2020-03-29
-- @since 0.1
--
-- @module Logger

-- Variables --
print("Logger: Initializing variables...")

local Logger = {}

-- Local Objects --
print("Logger: Constructing objects...")

Logger.__index = Logger

--- The default Logger constructor.
-- Creates a new Logger with an empty log.
--
-- @return the new Logger
function Logger.new()
	local self = setmetatable({}, Logger)
	self.log = {}
	return self
end

--- Logs a new entry.
-- Inserts a new entry into the log. The entry includes the time it was logged
-- along with whatever paramters are passed.
--
-- @param ... parameters to log with the entry
function Logger:Log(...)
	table.insert(log, {os.time(), ...})
end

--- An iterator factory for the log.
-- Iterates over the log in the order that entries were added.
--
-- @return the iterator, its invariant, and its control variable
function Logger:Entries()
	return ipairs(self.log)
end

-- End --
print("Logger: Done.")

return Logger

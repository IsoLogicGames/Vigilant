--- A console that logs entries and prints to the standard output.
-- Creates a log of entries and allows logging of standard messages, warnings,
-- and errors. Allows recording a source and creating a custom sourced console
-- that automatically records source.
--
-- @author LastTalon
-- @version 0.1.0, 2020-03-29
-- @since 0.1
--
-- @module Console
-- @throws Error when attempting to log an error
-- @throws Warning when attempting to log a warning

-- Dependencies --
print("Console: Loading dependencies...")

local Logger = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Logger"))

-- Constants --
print("Console: Initializing constants...")

--- An enum for the type of message being logged.
-- Determines the type of log entry being made and whether its an error,
-- warning, or standard log message.
--
-- @field Log a standard message
-- @field Warning a warning message
-- @field Error an error message
local MessageType = {
	["Log"] = 1,
	["Warning"] = 2,
	["Error"] = 3
}

-- Functions --
print("Console: Constructing functions...")

--- Formats a message to print.
--
-- @param message the message to format
-- @param source the source of the message to format
-- @return the formatted message
local function formatMessage(message, source)
	source = source or "Log"
	return string.format("%s: %s", source, message)
end

-- Variables --
print("Console: Initializing variables...")

local Console = {}
local ConsoleLogger = Logger.new()
local defaultOutput = true

-- Local Objects --
print("Console: Constructing objects...")

Console.__index = Console

--- Sets whether the console prints to the standard output.
-- Also affects whether errors are called through error and warnings are called
-- through warn. This means that when logging errors it will cause execution to
-- halt.
--
-- @param value true to set. True prints, false will not.
--
-- @see print
-- @see warn
-- @see error
function Console.setDefaultOutput(value)
	value = value or false and true
	defaultOutput = value
end

--- Gets whether the console prints to the standard output.
-- This gets the value set by setDefaultOutput.
--
-- @return true if the console is printing, false otherwise
--
-- @see setDefaultOutput
function Console.getDefaultOutput()
	return defaultOutput
end

--- An iterator factory for the log.
-- Iterates over the log in the order that entries were added.
--
-- @return the iterator, its invariant, and its control variable
function Console.entries()
	return ConsoleLogger:Entries()
end

--- Logs a standard message.
-- Adds a log entry for a standard message from the source provided. Also
-- prints a formatted message to the standard output if the Console is
-- printing.
--
-- @param message the message to log
-- @param source the source of the message
function Console.log(message, source)
	ConsoleLogger:Log(message, source, MessageType.Log)
	if defaultOutput then
		print(formatMessage(message, source))
	end
end

--- Logs a warning message.
-- Adds a log entry for a warning message from the source provided. Also prints
-- a formatted message to the standard output using warn if the Console is
-- printing.
--
-- @param message the message to log
-- @param source the source of the message
-- @throws Warning when the message is printed to the standard output
--
-- @see warn
function Console.warn(message, source)
	ConsoleLogger:Log(message, source, MessageType.Warning)
	if defaultOutput then
		warn(formatMessage(message, source))
	end
end

--- Logs an error message.
-- Adds a log entry for an error message from the source provided. Also prints
-- a formatted message to the standard output using error if the Console is
-- printing. This will cause execution to halt.
--
-- @param message the message to log
-- @param source the source of the message
-- @throws Error when the message is printed to the standard output
--
-- @see error
function Console.error(message, source)
	ConsoleLogger:Log(message, source, MessageType.Error)
	if defaultOutput then
		error(formatMessage(message, source))
	end
end

--- Creates a sourced Console that automatically logs the source provided.
-- Creates a new custom Console that logs in the same way as a normal Console,
-- but additionally logs the source without having to pass any additional
-- source parameters to functions that need it.
--
-- @param source the source of this Console
-- @return the new sourced Console
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

-- End --
print("Console: Done.")

return Console

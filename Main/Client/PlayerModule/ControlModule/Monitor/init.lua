--- The base class for all monitors.
-- This is meant to be an abstract class and should be used to inherit from in
-- other monitors.
-- @module Monitor
-- @author LastTalon

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Monitor")

Console.log("Loading dependencies...")

Method = require(script.Parent:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local Monitor = {}
Monitor.__index = Monitor

--- The constructor for a monitor.
-- @return the new monitor
function Monitor.new()
	local self = setmetatable({}, Monitor)
	self.bound = false
	self.updated = false
	return self
end

function Monitor.inputName(schemeName, controlName, inputType, inputCode, methodName)
	local name = "Control"
	local delimeter = " "
	if methodName ~= nil then
		name = methodName .. delimeter .. name
	end
	if inputCode ~= nil then
		name = inputCode .. delimeter .. name
		delimeter = ":"
	end
	if inputType ~= nil then
		name = inputType .. delimeter .. name
	end
	delimeter = " "
	if controlName ~= nil then
		name = controlName .. delimeter .. name
		delimeter = ":"
	end
	if schemeName ~= nil then
		name = schemeName .. delimeter .. name
	end
	return name
end

--- A method that tells if this monitor is currently bound.
-- @return true if bound, false otherwise
function Monitor:Bound()
	return self.bound
end

--- A method that accesses this monitor's value.
-- @return the value
function Monitor:GetValue()
	return self.value
end

function Monitor:Updated()
	local value = self.updated
	self.updated = false
	return value
end

--- An abstract method for binding the control.
-- This method should not be called from Monitor and must be overridden.
function Monitor:BindControl()
	warn("BindControls must be overridden and should not be called from Monitor.")
end

--- An abstract method for unbinding the control.
-- This method should not be called from Monitor and must be overridden.
function Monitor:UnbindControl()
	warn("UnbindControls must be overridden and should not be called from Monitor.")
end

Console.log("Initialized.")
Console.log("Assembled.")

return Monitor.new()

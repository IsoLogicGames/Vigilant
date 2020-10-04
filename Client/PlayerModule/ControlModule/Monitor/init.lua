--- An abstract Monitor for tracking inputs.
-- A monitor is used to keep track of the inputs of a single Control. This is an
-- abstract class and should be used to inherit from in other monitors. It
-- should not be instantiated directly.
--
-- @author LastTalon
-- @version 0.1.1, 2020-10-01
-- @since 0.1
--
-- @module Monitor

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Monitor")

-- Dependencies --
Console.log("Loading dependencies...")

local UserInputService = game:GetService("UserInputService")

local InputType = require(script.Parent:WaitForChild("InputType"))
local DirectionMethod = require(script.Parent:WaitForChild("DirectionMethod"))

-- Functions --
Console.log("Constructing functions...")

local function getDeviceInput(code, device)
	local inputs = UserInputService:GetGamepadState(device)
	for _, input in ipairs(inputs) do
		if input.KeyCode == code then
			return input
		end
	end
end

-- Variables --
Console.log("Initializing variables...")

local Monitor = {}

-- Local Objects --
Console.log("Constructing objects...")

Monitor.__index = Monitor

--- The default constructor.
-- Creates a new, unbound Monitor.
--
-- @return the new Monitor
function Monitor.new()
	local self = setmetatable({}, Monitor)
	self.bound = false
	self.inputs = {}
	return self
end

--- Tells if this Monitor is currently bound.
--
-- @return true if bound, false otherwise
function Monitor:Bound()
	return self.bound
end

--- Gets this Monitor's value.
--
-- @return the value
function Monitor:GetValue()
	return self.value
end

--- Updates the value of this Monitor.
-- Gathers all Inputs and updates the value of this Monitor's input based on
-- the scaling of this Monitor. This method should not typically be called
-- directly and should be called by the ControlModule.
--
-- @return the value
-- @throws error when an input has an invalid enum
--
-- @see Input
-- @see ControlModule
function Monitor:Update()
	local value = self:nullValue()
	local scale = 0
	for _, input in ipairs(self.inputs) do
		local inputValue
		local inputScale
		local valid = true
		
		-- Get specific input
		if input.Type == InputType.None then
			inputValue = false
		elseif input.Type == InputType.Keyboard then
			inputValue = UserInputService:IsKeyDown(input.Code)
		elseif input.Type == InputType.MouseButton then
			inputValue = UserInputService:IsMouseButtonPressed(input.Code)
		elseif input.Type == InputType.MouseMovement then
			if input.Code == DirectionMethod.None then
				inputValue = false
			elseif input.Code == DirectionMethod.Absolute then
				inputValue = UserInputService:GetMouseLocation()
			elseif input.Code == DirectionMethod.Relative then
				inputValue = UserInputService:GetMouseDelta()
			else
				Console.error("Input has invalid direction method.")
				valid = false
			end
		elseif input.Type == InputType.GamepadButton then
			inputValue = UserInputService:IsGamepadButtonDown(input.Code, input.Device)
		elseif input.Type == InputType.GamepadDirection then
			if input.Code == DirectionMethod.None then
				inputValue = false
			elseif input.Code == DirectionMethod.Absolute then
				inputValue = getDeviceInput(input.Code, input.Device).Position
			elseif input.Code == DirectionMethod.Relative then
				inputValue = getDeviceInput(input.Code, input.Device).Delta
			else
				Console.error("Input has invalid direction method.")
				valid = false
			end
		elseif input.Type == InputType.Scheme then
			inputValue = input.Code
		else
			Console.error("Input has invalid type.")
			valid = false
		end
		
		if valid then
			inputValue, inputScale = self:transformValue(input, inputValue)
			value = self:addValue(value, inputValue)
			scale = scale + inputScale
		end
	end
	
	self.value = self:scaleValue(value, scale)
	return self:GetValue()
end

--- Binds a Control to this Monitor. 
-- Only one Control can be bound at a time. At the time of binding all Inputs
-- of the Control are processed and added to the Monitor. Any changes to the
-- Control after its bound will not be reflected in the Monitor's operation.
--
-- @param control the Control to bind
function Monitor:Bind(control)
	if not self:Bound() then
		for _, input in ipairs(control.inputs) do
			local entry = {}
			entry.Type = input.Type
			entry.Code = input.Code
			entry.Offset = input.Offset
			entry.Devices = input.Devices
			self:processEntry(entry)
			table.insert(self.inputs, entry)
		end
		self.bound = true
	end
end

--- Unbinds this Monitor from any Control it may be bound to.
-- Automatically resets this Monitor.
function Monitor:Unbind()
	if self:Bound() then
		self.inputs = {}
		self:clean()
		self.bound = false
	end
end

--- Transforms an Input's value for this Monitor based on its InputType.
-- The Monitor, InputType, and offset of the Input are used to transform the
-- value accordingly during the transform step of this Monitor's update.
-- Typically this means converting the value to the appropriate type and'
-- applying the offset accordingly. During this process a scaling factor may be
-- produced. This should not be called from the abstract class Monitor and
-- should be overridden. This should typically not be called directly and
-- should be called by the associated Monitor's update.
--
-- @param input the input that produced the value being transformed
-- @param value the value being transformed
-- @return the transformed value
-- @return the scaling factor
function Monitor:transformValue()
	Console.warn("updateInput must be overridden and should not be called from Monitor.")
end

--- Adds two Inputs' values together based on this Monitor type.
-- Occurs during the accumulation step of this Monitor's update. This should
-- not be called from the abstract class Monitor and should be overridden. This
-- should typically not be called directly and should be called by the
-- associated Monitor's update.
--
-- @param lhs the left hand side operand of the add operation
-- @param rhs the right hand side operand of the add operation
-- @return the added value
function Monitor:addValue()
	Console.warn("addValue must be overridden and should not be called from Monitor.")
end

--- Scales an Input's value by a scaling factor.
-- Occurs during the scaling step of this Monitor's update. The scaling factor
-- is the same type of scaling factor returned by transformValue. This should
-- not be called from the abstract class Monitor and should be overridden. This
-- should typically not be called directly and should be called by the
-- associated Monitor's update.
--
-- @param value the value to be scaled
-- @param scale the scaling factor
-- @return the scaled value
function Monitor:scaleValue()
	Console.warn("scaleValue must be overridden and should not be called from Monitor.")
end

--- Gets the default value for this Monitor.
-- Occurs during the initialization step of this Monitor's update.
--
-- @return the default value
function Monitor:defaultValue()
	Console.warn("defaultValue must be overridden and should not be called from Monitor.")
end

--- Performs any necessary post-processing of an entry for this Monitor.
-- Occurs when new entries are added to this Monitor during the binding step.
-- The monitor may modify or add any values to the entry. An entry has fields
-- Type, Code, Offset, and, Devices, from its associated Input.
--
-- @param entry the entry to process
function Monitor:processEntry()
	Console.warn("processEntry must be overridden and should not be called from Monitor.")
end

--- Cleans up any additional data or state created by this Monitor.
-- Occurs during this Monitor's unbind step. Leaves this Monitor in a state
-- ready to be bound again.
function Monitor:clean()
	Console.warn("clean must be overridden and should not be called from Monitor.")
end

-- End --
Console.log("Done.")

return Monitor.new()

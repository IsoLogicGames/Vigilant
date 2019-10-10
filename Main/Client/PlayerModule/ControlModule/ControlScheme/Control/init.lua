--- A control mapping.
-- A control object with a name, description, and set of inputs. This is used to
-- represent a particular action the character can perform when some input is
-- given.
-- @module Control
-- @field Inputs the set of inputs that triggers this control
-- @field Name the name of this control
-- @field Description the description of this control
-- @field Method the @{ControlMethod} of this control
-- @author LastTalon
-- @see Input
-- @see Method

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control")

Console.log("Loading dependencies...")

Input = require(script:WaitForChild("Input"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local Control = {}
Control.__index = Control

--- Constructor for a new control object.
-- Creates a new empty control object with a name and description.
-- @param name the name of the new control object
-- @param description the description of the new control object
-- @param method the input method of the new control object
-- @return the new control object
function Control.new(name, description, method)
	local self = setmetatable({}, Control)
	self.Inputs = {}
	self.Name = name
	self.Description = description
	self.Method = method
	return self
end

--- Adds a new input for this control.
-- Adds the specified input. If no input is specified it creates a new input. It
-- then returns the input that was added.
-- @param input the input to add
-- @return the input added
function Control:Add(input)
	input = input or Input.new()
	table.insert(self.Inputs, input)
	return input
end

--- Removes an input from this control.
-- Removes the input at the specified index. If no index is specified the last
-- input is removed.
-- @param index the index of the input to remove
function Control:Remove(index)
	table.remove(self.Inputs, index)
end

Console.log("Initialized.")
Console.log("Assembled.")

return Control

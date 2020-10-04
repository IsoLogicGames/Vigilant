--- A control mapping of user inputs.
-- Keeps several Inputs that represent a single control action. Includes the
-- name, description, and set of Inputs. This is used to represent a particular
-- action in a game a user can perform when some combination of user input is
-- given.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-16
-- @since 0.1
--
-- @module Control
-- @field Inputs the set of Inputs that triggers this Control
-- @field Name the name of this Control
-- @field Description the description of this Control
-- @field Method the ControlMethod for this Control
--
-- @see Input
-- @see ControlMethod

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control")

-- Dependencies --
Console.log("Loading dependencies...")

local Input = require(script:WaitForChild("Input"))

-- Variables --
Console.log("Initializing variables...")

local Control = {}

-- Local Objects --
Console.log("Constructing objects...")

Control.__index = Control

--- The parameterized constructor.
-- Creates a new empty control object with all parameters set.
--
-- @param name the name of the Control
-- @param description the description of the Control
-- @param method the ControlMethod of the Control
-- @return the new Control
function Control.new(name, description, method)
	local self = setmetatable({}, Control)
	self.Inputs = {}
	self.Name = name
	self.Description = description
	self.Method = method
	return self
end

--- Adds a new Input to this control.
-- Adds the specified Input. If none is specified it creates a new Input. It
-- then returns the Input that was added.
--
-- @param input the Input to add
-- @return the Input added
function Control:Add(input)
	input = input or Input.new()
	table.insert(self.Inputs, input)
	return input
end

--- Removes an Input from this control.
-- Removes the Input at the specified index. If no index is specified the last
-- Input is removed.
--
-- @param index the index of the Input to remove
function Control:Remove(index)
	table.remove(self.Inputs, index)
end

-- End --
Console.log("Done.")

return Control

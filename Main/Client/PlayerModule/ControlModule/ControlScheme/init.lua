--- Set of Controls that are used together.
-- Contains control mappings that are bound and unbound together. These are
-- equivalent to control contexts e.g. menus, game modes, and different
-- character, vehicle, etc. control modes.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-14
-- @since 0.1
--
-- @module ControlScheme
-- @field ControlSet the set of Controls in this ControlScheme
--
-- @see Control

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Scheme")

-- Dependencies --
Console.log("Loading dependencies...")

Control = require(script:WaitForChild("Control"))

-- Variables --
Console.log("Initializing variables...")

local ControlScheme = {}

-- Local Objects --
Console.log("Constructing objects...")

ControlScheme.__index = ControlScheme

--- The default constructor.
-- Creates a new ControlScheme with an empty set of Controls.
--
-- @return the new ControlScheme
function ControlScheme.new()
	local self = setmetatable({}, ControlScheme)
	self.ControlSet = {}
	self.Name = "ControlScheme"
	return self
end

--- Adds a new Control.
-- Adds the new Control the ControlScheme. If a Control is not specified it
-- creates a new one. It then returns the Control added.
--
-- @param control the Control to add
-- @return the Control added
function ControlScheme:Add(control)
	if type(control) == "string" then
		control = Control.new(control)
	end
	self.ControlSet[control.Name] = control
	return control
end

--- Removes a Control.
-- Removes the Control at the specified id.
--
-- @param id the id of the Control to remove
function ControlScheme:Remove(id)
	self.ControlSet[id] = nil
end

-- End --
Console.log("Done.")

return ControlScheme

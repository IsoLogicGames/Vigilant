--- A control scheme to control a character.
-- Contains many control mappings as a set of actions a character can peform.
-- @module ControlScheme
-- @field ControlSet the set of controls in this control scheme
-- @author LastTalon
-- @see Control
Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Scheme")

Console.log("Loading dependencies...")

Control = require(script:WaitForChild("Control"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing locals...")

local ControlScheme = {}
ControlScheme.__index = ControlScheme

--- A constructor for a new control sheme.
-- Creates a new control scheme with an empty set of controls.
-- @return the new control scheme
function ControlScheme.new()
	local self = setmetatable({}, ControlScheme)
	self.ControlSet = {}
	self.Name = "ControlScheme"
	return self
end

--- Adds a new control.
-- Adds the new control giving it an id in the control scheme. If a control is
-- not specified it creates a new one. It then returns the control added.
-- @param control the control to add
-- @return the control added
function ControlScheme:Add(control)
	if type(control) == "string" then
		control = Control.new(control)
	end
	self.ControlSet[control.Name] = control
	return control
end

--- Removes a control.
-- Removes the control at the specified id.
-- @param id the id of the control to remove
function ControlScheme:Remove(id)
	self.ControlSet[id] = nil
end

Console.log("Initialized.")
Console.log("Assembled.")

return ControlScheme

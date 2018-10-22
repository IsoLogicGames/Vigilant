--- The control method enum
-- The control methods are None, Binary, Axis, and Vector. These are used with a
-- Control to tell which methods of control it supports and how to interpret its
-- Inputs.
-- @module Method
-- @author LastTalon
-- @see Control
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Method")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local method = {
	["None"] = 0, -- Control does nothing and has and no input. Any inputs are ignored.
	["Binary"] = 1, -- A togglable control. The control is either on or off, inputs either trigger this control or they don't.
	["Axis"] = 2, -- A linear, scaled control. The control is scaled based on input if able between -1 and 1 based on inputs such as a joystick movement or combination of two binary inputs if able.
	["Vector"] = 3 -- A directional, scaled control. The control has direction and magnitude, this can be viewed as two orthogonal axis controls as one control. Each direction scales between -1 and 1 using methods such as joystick movement or a combination of four binary inputs.
}

Console.log("Initialized.")
Console.log("Assembled.")

return method

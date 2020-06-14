--- An enum that determines the method a Control activates in.
-- The ControlMethod values are None, Binary, Axis, and Vector. These are used
-- with a Control to tell which methods of control it supports and how to
-- interpret its Inputs.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-15
-- @since 0.1
--
-- @module ControlMethod
--
-- @see Control
-- @see Input

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("ControlMethod")

-- Constants --
Console.log("Initializing constants...")

--- The ControlMethod enum.
--
-- @field None this Control does nothing and has and no input. Any inputs are
-- ignored.
-- @field Binary a togglable control. The Control is either on or off, inputs
-- either trigger this Control or they don't.
-- @field Axis a linear, scaled control. The Control is scaled based on input
-- if able between -1 and 1 based on inputs such as a joystick movement or a
-- combination of two binary inputs if able.
-- @field Vector a directional, scaled Control. The Control has direction and
-- magnitude, this can be viewed as two orthogonal axis Controls as one
-- Control. Each direction scales between -1 and 1 using methods such as
-- joystick movement or a combination of two axis inputs.
local Method = {
	["None"] = 1,
	["Binary"] = 2,
	["Axis"] = 3,
	["Vector"] = 4
}

-- End --
Console.log("Done.")

return Method

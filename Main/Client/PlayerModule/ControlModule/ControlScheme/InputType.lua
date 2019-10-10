--- The input type enum
-- The input types are None, Keyboard, MouseButton, MouseMovement,
-- GamepadButton, GamepadDirection, and Scheme. These are used with an Input to
-- tell which types of input it describes and roughly how it will be used by the
-- UserInputService.
-- @module InputType
-- @author LastTalon
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("InputType")

Console.log("Assembling script...")
Console.log("Initializing locals...")

local type = {
	["None"] = 1, -- The input intentionally does nothing.
	["Keyboard"] = 2, -- A keyboard button press.
	["MouseButton"] = 3, -- A mouse button press.
	["MouseMovement"] = 4, -- A directional mouse movement.
	["GamepadButton"] = 5, -- A gamepad button press.
	["GamepadDirection"] = 6, -- A direction gamepad control like a thumbstick.
	["Scheme"] = 7 -- A sub-scheme to be executed by another monitor.
}

Console.log("Initialized.")
Console.log("Assembled.")

return type

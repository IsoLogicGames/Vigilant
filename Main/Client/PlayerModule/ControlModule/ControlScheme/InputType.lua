--- A type for determining the type user input type.
-- The InputTypes are None, Keyboard, MouseButton, MouseMovement,
-- GamepadButton, GamepadDirection, and Scheme. These are used with an Input
-- for which types of input it describes and roughly how it will be used by the
-- UserInputService.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-16
-- @since 0.1
--
-- @module InputType
--
-- @see Input

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("InputType")

-- Constants --
Console.log("Initializing constants...")

--- The InputType enum.
--
-- @field None the input intentionally does nothing
-- @field Keyboard a keyboard button press
-- @field MouseButton a mouse button press
-- @field MouseMovement a directional mouse movement
-- @field GamepadButton a gamepad button press
-- @field GamepadDirection a direction gamepad control like a thumbstick
-- @field Scheme a sub-scheme to be executed by another monitor
local Type = {
	["None"] = 1,
	["Keyboard"] = 2,
	["MouseButton"] = 3,
	["MouseMovement"] = 4,
	["GamepadButton"] = 5,
	["GamepadDirection"] = 6,
	["Scheme"] = 7
}

-- End --
Console.log("Done.")

return Type

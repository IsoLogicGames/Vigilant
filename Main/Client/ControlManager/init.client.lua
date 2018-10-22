Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Manager")

Console.log("Loading dependencies...")

Player = game:GetService("Players").LocalPlayer
PlayerScripts = Player:WaitForChild("PlayerScripts")
Controls = require(PlayerScripts:WaitForChild("PlayerModule")).Controls
ControlScheme = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("ControlScheme"))
ControlMethod = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

--- Creates a control scheme of binary controls to use as a vector control.
function vectorScheme()
	local scheme = ControlScheme.new()
	local control
	local input
	
	control = scheme:Add("Up")
		control.Name = "Up"
		control.Method = ControlMethod.Binary
	control = scheme:Add("Down")
		control.Name = "Down"
		control.Method = ControlMethod.Binary
	control = scheme:Add("Left")
		control.Name = "Left"
		control.Method = ControlMethod.Binary
	control = scheme:Add("Right")
		control.Name = "Right"
		control.Method = ControlMethod.Binary
	
	return scheme
end

--- Creates the main control scheme without inputs.
function controlScheme()
	local scheme = ControlScheme.new()
	local control
	
	control = scheme:Add("Move")
		control.Name = "Move"
		control.Description = "Moves the character."
		control.Method = ControlMethod.Vector
	control = scheme:Add("Direction")
		control.Name = "Direction"
		control.Description = "Turns the character's facing direction."
		control.Method = ControlMethod.Vector
	control = scheme:Add("Ability1")
		control.Name = "Ability 1"
		control.Description = "Activates the character's first ability."
		control.Method = ControlMethod.Binary
	control = scheme:Add("Ability2")
		control.Name = "Ability 2"
		control.Description = "Activates the character's second ability."
		control.Method = ControlMethod.Binary
	control = scheme:Add("Ability3")
		control.Name = "Ability 3"
		control.Description = "Activates the character's third ability."
		control.Method = ControlMethod.Binary
	control = scheme:Add("Ability4")
		control.Name = "Ability 4"
		control.Description = "Activates the character's fourth ability."
		control.Method = ControlMethod.Binary
	control = scheme:Add("Menu")
		control.Name = "Game Menu"
		control.Description = "Displays the in-game menu."
		control.Method = ControlMethod.Binary
	
	return scheme
end

--- Creates the control scheme with default inputs.
function defaultControlScheme()
	local default = controlScheme()
	local input
	local subInput
	
	default.Name = "Default Scheme"
	input = default.ControlSet.Move:Add()
		input.Scheme = vectorScheme()
		subInput = input.Scheme.ControlSet.Up:Add()
			subInput.Type = Enum.UserInputType.Keyboard
			subInput.Code = Enum.KeyCode.W
		subInput = input.Scheme.ControlSet.Down:Add()
			subInput.Type = Enum.UserInputType.Keyboard
			subInput.Code = Enum.KeyCode.S
		subInput = input.Scheme.ControlSet.Left:Add()
			subInput.Type = Enum.UserInputType.Keyboard
			subInput.Code = Enum.KeyCode.A
		subInput = input.Scheme.ControlSet.Right:Add()
			subInput.Type = Enum.UserInputType.Keyboard
			subInput.Code = Enum.KeyCode.D
	input = default.ControlSet.Direction:Add()
		input.Type = Enum.UserInputType.MouseMovement
		input.Code = Enum.UserInputType.MouseMovement
		input.Offset = UDim2.new(0.5, 0, 0.5, 0)
	input = default.ControlSet.Ability1:Add()
		input.Type = Enum.UserInputType.MouseButton1
		input.Code = Enum.UserInputType.MouseButton1
	input = default.ControlSet.Ability2:Add()
		input.Type = Enum.UserInputType.MouseButton2
		input.Code = Enum.UserInputType.MouseButton2
	input = default.ControlSet.Ability3:Add()
		input.Type = Enum.UserInputType.Keyboard
		input.Code = Enum.KeyCode.E
	input = default.ControlSet.Ability4:Add()
		input.Type = Enum.UserInputType.Keyboard
		input.Code = Enum.KeyCode.Q
	input = default.ControlSet.Menu:Add()
		input.Type = Enum.UserInputType.Keyboard
		input.Code = Enum.KeyCode.Tab
	
	return default
end

Console.log("Initialized.")
Console.log("Assembled.")
Console.log("Running...")

Controls.ControlScheme = defaultControlScheme()
Controls:BindControls()
Controls:SetMove("Move")

Console.log("Done.")

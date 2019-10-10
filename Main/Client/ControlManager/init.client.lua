Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Manager")

Console.log("Loading dependencies...")

Player = game:GetService("Players").LocalPlayer
PlayerScripts = Player:WaitForChild("PlayerScripts")
Controls = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
ControlScheme = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("ControlScheme"))
ControlMethod = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("ControlScheme"):WaitForChild("ControlMethod"))
DirectionMethod = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("ControlScheme"):WaitForChild("DirectionMethod"))
InputType = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("ControlScheme"):WaitForChild("InputType"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

--- Creates a control scheme of axis controls to use as a vector control.
function vectorScheme()
	local scheme = ControlScheme.new()
	local control
	
	control = scheme:Add("Vertical")
		control.Name = "Vertical"
		control.Method = ControlMethod.Axis
	control = scheme:Add("Horizontal")
		control.Name = "Horizontal"
		control.Method = ControlMethod.Axis
	
	return scheme
end

--- Creates a control scheme of binary controls to use as a axis control.
function axisScheme()
	local scheme = ControlScheme.new()
	local control
	
	control = scheme:Add("Up")
		control.Name = "Up"
		control.Method = ControlMethod.Binary
	control = scheme:Add("Down")
		control.Name = "Down"
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
	local vectorInput
	local axisInput
	
	default.Name = "Default Scheme"
	input = default.ControlSet.Move:Add()
		input.Type = InputType.Scheme
		input.Code = vectorScheme()
		vectorInput = input.Code.ControlSet.Vertical:Add()
			vectorInput.Type = InputType.Scheme
			vectorInput.Code = axisScheme()
			axisInput = vectorInput.Code.ControlSet.Up:Add()
				axisInput.Type = InputType.Keyboard
				axisInput.Code = Enum.KeyCode.W
			axisInput = vectorInput.Code.ControlSet.Down:Add()
				axisInput.Type = InputType.Keyboard
				axisInput.Code = Enum.KeyCode.S
		vectorInput = input.Scheme.ControlSet.Horizontal:Add()
			vectorInput.Type = InputType.Scheme
			vectorInput.Code = axisScheme()
			axisInput = vectorInput.Code.ControlSet.Up:Add()
				axisInput.Type = InputType.Keyboard
				axisInput.Code = Enum.KeyCode.A
			axisInput = vectorInput.Code.ControlSet.Down:Add()
				axisInput.Type = InputType.Keyboard
				axisInput.Code = Enum.KeyCode.D
	input = default.ControlSet.Direction:Add()
		input.Type = InputType.MouseMovement
		input.Code = DirectionMethod.Absolute
		input.Offset = UDim2.new(0.5, 0, 0.5, 0)
	input = default.ControlSet.Ability1:Add()
		input.Type = InputType.MouseButton
		input.Code = Enum.UserInputType.MouseButton1
	input = default.ControlSet.Ability2:Add()
		input.Type = InputType.MouseButton
		input.Code = Enum.UserInputType.MouseButton2
	input = default.ControlSet.Ability3:Add()
		input.Type = InputType.Keybaord
		input.Code = Enum.KeyCode.E
	input = default.ControlSet.Ability4:Add()
		input.Type = InputType.Keybaord
		input.Code = Enum.KeyCode.Q
	input = default.ControlSet.Menu:Add()
		input.Type = InputType.Keybaord
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

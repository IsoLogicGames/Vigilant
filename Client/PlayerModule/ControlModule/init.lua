--- The main control module.
-- A singleton object responsible for accepting all inputs from the player and
-- interpretting controls. It recieves input from the user and fires
-- corresponding events. Recieves input based on provided ControlSchemes.
--
-- @author LastTalon
-- @version 0.1.1, 2020-10-01
-- @since 0.1
--
-- @module ControlModule

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Module")

-- Dependencies --
Console.log("Loading dependencies...")

local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer
local SharedScripts = game:GetService("ReplicatedStorage"):WaitForChild("Scripts")

local SpawnMonitor = require(script:WaitForChild("ControlScheme"):WaitForChild("Monitor"):WaitForChild("Spawn"))
local Event = require(SharedScripts:WaitForChild("Event"))

-- Constants --
Console.log("Initializing constants...")

local RenderStepName = "Controls"

-- Functions --
Console.log("Constructing functions...")

-- The default move listener.
local function onMove(value)
	Player:Move(value)
end

-- The default direction listener.
local function onDirection(value)
	-- TODO: Add default direction listener.
end

-- The default camera listener.
local function onCamera(value)
	-- TODO: Add default camera listener.
end

-- Variables --
Console.log("Initializing variables...")

local ControlModule = {}
local instance

-- Local Objects --
Console.log("Constructing objects...")

ControlModule.__index = ControlModule

--- The constructor for the singleton.
-- Creates a new singleton if none exists. This always returns same object
-- initially created.
--
-- @return the singleton
function ControlModule.new()
	if instance == nil then
		local self = setmetatable({}, ControlModule)
		self.controlsBound = false
		self.monitors = {}
		-- self.listeners = {}
		self.event = Event.new()
		self.OnCommand = self.event.Registrar
		instance = self
	end
	return instance
end

--- A generic listener function that activates another listener on a specific
-- command.
function ControlModule.ListenForCommand(command, fn)
	local listener = function(trigger, value)
		if trigger == command then
			fn(value)
		end
	end
	return listener
end

--- Sets the command name for the move action.
-- Sets the default move action to be active and activate on the provided
-- command name.
--
-- @param command the name of the command to activate on
function ControlModule:SetMove(command)
	if self.moveListener == nil then
		self.moveListener = self.OnCommand:Connect(self.ListenForCommand(command, onMove))
	end
end

--- Deactivates the default move action.
function ControlModule:UnsetMove()
	if self.moveListener ~= nil then
		self.OnCommand:Disconnect(self.moveListener)
		self.moveListener = nil
	end
end

--- Sets the command name for the direction action.
-- Sets the default direction action to be active and activate on the provided
-- command name.
--
-- @param command the name of the command to activate on
function ControlModule:SetDirection(command)
	if self.directionListener == nil then
		self.directionListener = self.OnCommand:Connect(self.ListenForCommand(command, onDirection))
	end
end

--- Deactivates the default direction action.
function ControlModule:UnsetDirection()
	if self.directionListener ~= nil then
		self.OnCommand:Disconnect(self.directionListener)
		self.directionListener = nil
	end
end

--- Sets the command name for the camera action.
-- Sets the default camera action to be active and activate on the provided
-- command name.
--
-- @param command the name of the command to activate on
function ControlModule:SetCamera(command)
	if self.cameraListener == nil then
		self.cameraListener = self.OnCommand:Connect(self.ListenForCommand(command, onCamera))
	end
end

--- Deactivates the default camera action.
function ControlModule:UnsetCamera()
	if self.cameraListener ~= nil then
		self.OnCommand:Disonnect(self.cameraListener)
		self.cameraListener = nil
	end
end

--- Tells if the controls are currently bound to the render step.
--
-- @return true if the controls are bound, false otherwise
function ControlModule:Bound()
	return self.controlsBound
end

--- Binds the controls and starts the control step.
function ControlModule:BindControls()
	if not self.controlsBound then
		local schemeName = self.ControlScheme.Name
		for command, control in pairs(self.ControlScheme.ControlSet) do
			if self.monitors[command] == nil then
				local monitor = SpawnMonitor(control)
				monitor.SchemeName = schemeName
				monitor:BindControl()
				self.monitors[command] = monitor
			end
		end

		-- The control step that is added to the render step.
		local function onControlStep()
			for command, monitor in pairs(self.monitors) do
				if monitor:Updated() then
					self.event:Fire(command, monitor:GetValue())
				end
			end
		end

		RunService:BindToRenderStep(RenderStepName, Enum.RenderPriority.Input.Value, onControlStep)
		self.controlsBound = true
	end
end

--- Unbinds the controls and stops the control step.
function ControlModule:UnbindControls()
	if self.controlsBound then
		RunService:UnbindFromRenderStep(RenderStepName)

		for _, monitor in pairs(self.monitors) do
			monitor:UnbindControl()
		end

		self.monitors = {}
		self.controlsBound = false
	end
end

-- End --
Console.log("Done.")

return ControlModule.new()

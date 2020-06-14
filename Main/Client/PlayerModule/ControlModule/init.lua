--- The main control module.
-- A singleton object responsible for accepting all inputs from the player and
-- interpretting controls. It recieves input from the user and fires
-- corresponding events. Recieves input based on provided ControlSchemes.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-28
-- @since 0.1
--
-- @module ControlModule

local Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Module")

-- Dependencies --
Console.log("Loading dependencies...")

local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer

local CameraModule = require(script.Parent:WaitForChild("CameraModule"))
local ControlMethod = require(script:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))
local SpawnMonitor = require(script:WaitForChild("Monitor"):WaitForChild("Spawn"))

-- Functions --
Console.log("Constructing functions...")

-- A generic listener function that activates another listener on a specific
-- command.
local function onCommand(command, fn)
	local listener = function(trigger, value)
		if trigger == command then
			fn(value)
		end
	end
	return listener
end

-- The default move listener.
local function onMove(value)
	Player:Move(value)
end

-- The default direction listener.
local function onDirection(value)
	
end

-- The default camera listener.
local function onCamera(value)
	
end

-- The control step that is added to the render step in the input priority.
local function onControlStep()
	local value
	for command, monitor in pairs(instance.monitors) do
		if monitor:Updated() then
			value = monitor:GetValue()
			for _, fn in ipairs(instance.listeners) do
				fn(command, value)
			end
		end
	end
end

-- Variables --
Console.log("Initializing variables...")

local ControlModule = {}

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
		self.listeners = {}
		instance = self
	end
	return instance
end

--- Sets the command name for the move action.
-- Sets the default move action to be active and activate on the provided
-- command name.
--
-- @param command the name of the command to activate on
function ControlModule:SetMove(command)
	if self.moveListener == nil then
		self.moveListener = self:RegisterOnCommand(command, onMove)
	end
end

--- Deactivates the default move action.
function ControlModule:UnsetMove()
	if self.moveListener ~= nil then
		self:Deregister(self.moveListener)
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
		self.directionListener = self:RegisterOnCommand(command, onDirection)
	end
end

--- Deactivates the default direction action.
function ControlModule:UnsetDirection()
	if self.directionListener ~= nil then
		self:Deregister(self.directionListener)
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
		self.cameraListener = self:RegisterOnCommand(command, onCamera)
	end
end

--- Deactivates the default camera action.
function ControlModule:UnsetCamera()
	if self.cameraListener ~= nil then
		self:Deregister(self.cameraListener)
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
		local monitor
		local schemeName = self.ControlScheme.Name
		for command, control in pairs(self.ControlScheme.ControlSet) do
			if self.monitors[command] == nil then
				monitor = SpawnMonitor(control)
				monitor.SchemeName = schemeName
				monitor:BindControl()
				self.monitors[command] = monitor
			end
		end
		
		RunService:BindToRenderStep("Controls", Enum.RenderPriority.Input.Value, onControlStep)
		self.controlsBound = true
	end
end

--- Unbinds the controls and stops the control step.
function ControlModule:UnbindControls()
	if self.controlsBound then
		RunService:UnbindFromRenderStep("Controls")
		
		for _, monitor in pairs(self.monitors) do
			monitor:UnbindControl()
		end
		
		self.monitors = {}
		self.controlsBound = false
	end
end

--- Registers a listener for input events.
-- This will fire on all input events and pass the parameter list
-- (command, value) where command is the command name and value is the value of
-- the event activation.
--
-- @param fn the function to register as a listener
-- @return the id of the newly registered listener
function ControlModule:Register(fn)
	table.insert(self.listeners, fn)
	return #self.listeners
end

--- Registers a listener for a specific input event.
-- This will fire only on the specified command's activation. It will pass
-- the parameter list (value) where value is the value of the event activation.
--
-- @param command the command to listen for
-- @param fn the function to register as a listener
-- @return the id of the newly registered listener
function ControlModule:RegisterOnCommand(command, fn)
	return self:Register(onCommand(command, fn))
end

--- Deregisters a listener for input events.
-- Deregeisters the listener associated with the id provided.
--
-- @param id the id of the listener to deregister
function ControlModule:Deregister(id)
	table.remove(self.listeners, id)
end

-- End --
Console.log("Done.")

return ControlModule.new()

--- The main control module.
-- A singleton object responsible for accepting all inputs from the player, and
-- interpretting controls. It recieves input, converts it to control commands,
-- and processes them, taking actions on the client side and sending events to
-- the server.
-- @module ControlModule
-- @author LastTalon

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Control Module")

Console.log("Loading dependencies...")

RunService = game:GetService("RunService")
Player = game:GetService("Players").LocalPlayer
CameraModule = require(script.Parent:WaitForChild("CameraModule"))
ControlMethod = require(script:WaitForChild("ControlScheme"):WaitForChild("Control"):WaitForChild("Method"))
SpawnMonitor = require(script:WaitForChild("Monitor"):WaitForChild("Spawn"))

Console.log("Loaded.")
Console.log("Assembling script...")
Console.log("Initializing globals...")

function onCommand(command, fn)
	local listener = function(trigger, value)
		if trigger == command then
			fn(value)
		end
	end
	return listener
end

function onMove(value)
	Player:Move(value)
end

function onDirection(value)
	
end

function onCamera(value)
	
end

-- The control step that is added to the renderstep in the input priority.
function onControlStep()
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

Console.log("Initialized.")
Console.log("Initializing locals...")

local ControlModule = {}
ControlModule.__index = ControlModule

--- The contructor for the control module singleton.
-- Creates a new reference copy of the singleton. This is the same object you
-- get when you require the control module. The only use this has is for
-- inheritance or as a quick copy to pass around.
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

function ControlModule:SetMove(command)
	if self.moveListener == nil then
		self.moveListener = self:RegisterOnCommand(command, onMove)
	end
end

function ControlModule:UnsetMove()
	if self.moveListener ~= nil then
		self:Deregister(self.moveListener)
		self.moveListener = nil
	end
end

function ControlModule:SetDirection(command)
	if self.directionListener == nil then
		self.directionListener = self:RegisterOnCommand(command, onDirection)
	end
end

function ControlModule:UnsetDirection()
	if self.directionListener ~= nil then
		self:Deregister(self.directionListener)
		self.directionListener = nil
	end
end

function ControlModule:SetCamera(command)
	if self.cameraListener == nil then
		self.cameraListener = self:RegisterOnCommand(command, onCamera)
	end
end

function ControlModule:UnsetCamera()
	if self.cameraListener ~= nil then
		self:Deregister(self.cameraListener)
		self.cameraListener = nil
	end
end

--- Tells if the controls are currently bound to the render step.
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
function ControlModule:Register(fn)
	table.insert(self.listeners, fn)
	return #self.listeners
end

function ControlModule:RegisterOnCommand(command, fn)
	return self:Register(onCommand(command, fn))
end

--- Deregisters a listener for input events.
function ControlModule:Deregister(id)
	table.remove(self.listeners, id)
end

Console.log("Initialized.")
Console.log("Assembled.")

return ControlModule.new()

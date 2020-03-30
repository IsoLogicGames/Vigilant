--- Dispatches events between client and server
-- Sends events between the client and the server and automatically triggers
-- any Commands that are registered. Allows creation of a network of Commands
-- for communication between client and server, forming the backbone of a
-- communication protocol.
--
-- @author LastTalon
-- @version 0.1.0, 2020-04-03
-- @since 0.1
--
-- @module Dispatcher
-- @field OnCommand the Event registrar
--
-- @see Command
-- @see Event

Console = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Console")).sourced("Dispatcher")

-- Dependencies --
Console.log("Loading dependencies...")

RunService = game:GetService("RunService")
Event = require(game:GetService("ReplicatedStorage"):WaitForChild("Scripts"):WaitForChild("Event"))

-- Variables --
Console.log("Initializing variables...")

local Dispatcher = {}

-- Local Objects --
Console.log("Constructing objects...")

Dispatcher.__index = Dispatcher

--- The Dispatcher constructor.
-- Creates a new Dispatcher attached to the provided RemoteEvent. Optionally
-- binds the dispatcher.
--
-- @param event the RemoteEvent this Dispatcher binds to
-- @param bind binds this Dispatcher if true
-- @return the new Dispatcher
function Dispatcher.new(event, bind)
	local self = setmetatable({}, Dispatcher)
	bind = bind or false
	self.remoteEvent = event
	self.localEvent = Event.New()
	self.commands = {}
	self.currentTick = 0
	self.OnCommand = self.localEvent.Registrar
	for _, commandModule in ipairs(script:WaitForChild("Command"):GetChildren()) do
		self:Add(require(commandModule))
	end
	if bind then
		self:Bind()
	end
	return self
end

--- Updates the Dispatcher.
-- Updates the Dispatcher wtih a new tick as well as all attached Commands and
-- any listening functions. This is automatically called by the RunService.
-- This should not normally be called directly.
--
-- @param time time passed by RunService
-- @param step step passed by RunService
--
-- @see RunService
function Dispatcher:update(time, step)
	local tick = math.floor(time * 30)
	if tick > self.currentTick then
		self.currentTick = tick
		for _, command in pairs(self.commands) do
			local activations = command:Update(tick)
			for _, arguments in ipairs(activations) do
				if self.remoteEvent ~= nil then
					if RunService:IsClient() then
						self.remoteEvent:FireServer(command.Name, tick, arguments)
					elseif RunService:IsServer() then
						self.remoteEvent:FireAllClients(command.Name, tick, arguments)
					end
				end
				self.localEvent:Fire(command.Name, tick, 0, nil, true, arguments)
			end
		end
		for _, command in ipairs(self.commandQueue) do
			self.localEvent:Fire(command.name, tick, tick - command.tick, command.player, false, command.arguments)
		end
		self.commandQueue = {}
	end
end

--- Updates the Command queue.
-- Updates the Command queue with any additional commands sent by the
-- RemoteEvent. The Commands are not processed until the next tick. This is
-- automatically called by the RemoteEvent. This should not normally be called
-- directly.
--
-- @param ... all parameters passed by the RemoteEvent
function Dispatcher:updateRemoteEvent(...)
	local args = {...}
	local command = {}
	if RunService:IsClient() then
		command.name = args[1]
		command.tick = args[2]
		command.arguments = args[3]
	elseif RunService:IsServer() then
		command.player = args[1]
		command.name = args[2]
		command.tick = args[3]
		command.arguments = args[4]
	end
	table.insert(self.commandQueue, command)
end

--- Binds the Dispatcher.
-- Connects the RemoteEvent and RunService to updateRemoteEvent and update
-- respectively.
function Dispatcher:Bind()
	if self.remoteConnection == nil and self.remoteEvent ~= nil then
		self.commandQueue = {}
		if RunService:IsClient() then
			self.remoteConnection = self.remoteEvent.OnClientEvent:Connect(function(...) self:updateRemoteEvent(...) end)
		elseif RunService:IsServer() then
			self.remoteConnection = self.remoteEvent.OnServerEvent:Connect(function(...) self:updateRemoteEvent(...) end)
		end
	end
	if self.binding == nil then
		self.binding = RunService.Stepped:Connect(function(...) self:update(...) end)
	end
end

--- Unbinds the Dispatcher.
-- Disconnects the RemoteEvent and RunService listeners.
function Dispatcher:Unbind()
	if self.remoteConnection == nil then
		self.commandQueue = nil
		self.remoteConnection:Disconnect()
		self.remoteConnection = nil
	end
	if self.binding ~= nil then
		self.binding:Disconnect()
		self.binding = nil
	end
end

--- Adds a Command to this Dispatcher.
-- Automatically registers the Command's listener and fires the Command during
-- the tick update.
--
-- @param command the Command to add
function Dispatcher:Add(command)
	self.commands[command.name] = command
	self.OnCommand:Connect(function(...) command:Listener(...) end)
end

--- Removes a Command from this Dispatcher.
--
-- @param command the Command to remove
function Dispatcher:Remove(command)
	self.commands[command.name] = nil
end

-- End --
Console.log("Done.")

return Dispatcher

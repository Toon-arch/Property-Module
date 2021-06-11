--[[

Module
	PropertiesModule.new()
		returns a PropertiesModule class
Class
	Method Set(PropertyName, NewValue)
		Set a property without firing the associated event.
	Method End()
		All events are disconnected. You can still access and set properties.
	Method GetPropertyChangedEvent(PropertyName)
		Returns an event that passes the new, and old value.

]]--

local Event = {}
Event.__index = Event

function Event.new()
	local self = setmetatable({
		_connections = {};
		_destroyed = false;
		_firing = false;
		_bindable = Instance.new("BindableEvent");
	}, Event)
	return self
end

function Event:Fire(...)
	self._args = {...}
	self._numArgs = select("#", ...)
	self._bindable:Fire()
end

function Event:Wait()
	self._bindable.Event:Wait()
	return unpack(self._args, 1, self._numArgs)
end

function Event:Connect(func)
	assert(not self._destroyed, "Cannot connect to destroyed event")
	assert(type(func) == "function", "Argument must be function")
	return self._bindable.Event:Connect(function()
		func(unpack(self._args, 1, self._numArgs))
	end)
end

function Event:DisconnectAll()
	self._bindable:Destroy()
	self._bindable = Instance.new("BindableEvent")
end

function Event:Destroy()
	if (self._destroyed) then return end
	self._destroyed = true
	self._bindable:Destroy()
end

local API = {}
API.__index = API

function API.new()
	local mt = {}
	
	mt._properties = {}
	mt._events = {}
	
	mt._ended = false
	
	mt.__newindex = function(t, k, v)
		if mt._properties[k] == nil then
			if v == nil then v = false end
			if not mt[k] then
				rawset(mt._properties, k, v)
				if mt._events[k] == nil then
					if not mt._ended then
						mt._events[k] = Event.new()
					end
				else
					local property = mt._properties[k]
					if not mt._ended then
						mt._events[k]:Fire(v, property)
					end
				end
			end
		else
			if v == nil then v = false end
			local property = rawget(mt._properties, k)
			rawset(mt._properties, k, v)
			if not mt._ended then
				mt._events[k]:Fire(v, property)
			end
		end
	end
	
	mt.__index = function(t, k)
		if mt[k] ~= nil then return mt[k] end
		local property = rawget(mt._properties, k)
		return property
	end
	
	local self = setmetatable(API, mt)
	
	return self
end

function API:Set(PropertyName, Value)
	rawset(self._properties, PropertyName, Value)
end

function API:GetPropertyChangedEvent(PropertyName)
	local newEvent = Event.new()
	self._events[PropertyName] = newEvent
	return newEvent
end

function API:End()
	self._ended = true
	for i,v in pairs(self._events) do
		v:Destroy()
	end
end

return API

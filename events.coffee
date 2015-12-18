class Events
	constructor: () ->
		@_listeners = {}

	on: (event, listener) ->
		list = @_listeners[event]
		if list is undefined
			list = @_listeners[event] = []
		list.push listener
		return

	once: (event, listener) ->
		list = @_listeners[event]
		if list is undefined
			list = @_listeners[event] = []
		list.push {
			listener: listener,
			once: true
		}
		return

	emit: (event, args...) ->
		listeners = @_listeners[event]
		return if listeners is undefined

		remove = []
		for l in listeners
			once = l.once || false
			listener = if typeof l is 'function' then l else l.listener
			listener(args...)
			remove.push listener

		# remove once listeners
		for listener in remove
			@removeListener event, listener

		return

	listeners: (event) -> 
		listeners = @_listeners[event]
		return if listeners is undefined then [] else listeners.slice()
		
	removeListener: (event, listener) ->
		listeners = @_listeners[event]
		return if listeners is undefined

		for l, index in listeners
			_listener = if typeof l is 'function' then l else l.listener
			if _listener == listener
				listeners.splice index, 1
				@_listeners[event] = listeners
				return

		return

	removeAllListeners: (event) ->
		@_listeners[event] = undefined

module.exports = Events
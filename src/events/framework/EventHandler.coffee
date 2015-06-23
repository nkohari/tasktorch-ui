class EventHandler

  constructor: (@eventQueue) ->
    if @listensFor?
      for type in @listensFor
        func = "on#{type}"
        throw new Error("Missing event handler definition #{func}() on #{@constructor.name}") unless this[func]?
        @eventQueue.addListener(type, @handle.bind(this))

  handle: (event) ->
    debug.log("#{@displayName}: Received %O", event)
    this["on#{event.type}"].call(this, event)
    return

module.exports = EventHandler

EventEmitter = require 'eventemitter3'

class EventQueue extends EventEmitter

  constructor: ->
    @pendingEvents = []
    @isFlushing = false

  publish: (event) ->
    unless event.type?
      throw new Error("EventQueue: Bogus event #{event.constructor.name} was queued without a type name")
    @pendingEvents.push(event)
    debug.log("EventQueue: (#{@pendingEvents.length}) Queued %O", event)
    unless @isFlushing
      @isFlushing = true
      setTimeout(@_flush, 0)

  _flush: =>
    try
      debug.log("EventQueue: (#{@pendingEvents.length}) Flushing events")
      while event = @pendingEvents.shift()
        debug.group('[EVENT] %O', event)
        unless @listeners(event.type).length > 0
          debug.warn("EventQueue: No listeners registered for #{event.type}")
        @emit(event.type, event)
        debug.groupEnd()
    catch err
      debug.error('Error while handling event: %O', err.stack)
      throw err
    finally
      @isFlushing = false
      @emit('flushed')

module.exports = EventQueue

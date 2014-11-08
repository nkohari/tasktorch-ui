{EventEmitter} = require 'events'

class Listener extends EventEmitter

  bind: (channel) ->
    channel.bind(@listensFor, @handle.bind(this))

  handle: (message) ->
    @emit('event', @createEvent(message))

  createEvent: (message) ->
    throw new Error("You must implement handle() on #{@constructor.name}")

module.exports = Listener

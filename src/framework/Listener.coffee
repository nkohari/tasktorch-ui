{EventEmitter} = require 'events'

class Listener extends EventEmitter

  constructor: ->
    @type = @constructor.name.replace(/Listener$/, '')

  bind: (channel) ->
    channel.bind(@type, @handle.bind(this))

  handle: (message) ->
    @emit('event', @createEvent(message))

  createEvent: (message) ->
    throw new Error("You must implement handle() on #{@constructor.name}")

module.exports = Listener

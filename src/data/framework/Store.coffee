EventHandler = require 'events/framework/EventHandler'

class Store extends EventHandler

  constructor: (eventQueue, @processor, @cache) ->
    super(eventQueue)

  announce: ->
    debug.log("#{@displayName}: Announcing changes")
    @cache.announce(this)

  load: (id) ->
    throw new Error("You must implement load() on #{@constructor.name}")

  execute: (request) ->
    @processor.execute(request)

module.exports = Store

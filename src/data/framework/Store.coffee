EventHandler = require 'events/framework/EventHandler'

class Store extends EventHandler

  constructor: (eventQueue, @cache) ->
    super(eventQueue)

  announce: ->
    console.debug("#{@displayName}: Announcing changes")
    @cache.announce(this)

  load: (id) ->
    throw new Error("You must implement load() on #{@constructor.name}")

  execute: (request) ->
    request.execute(@eventQueue)

module.exports = Store

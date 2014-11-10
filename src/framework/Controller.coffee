_ = require 'lodash'

class Controller

  constructor: (@eventBus, @stores) ->
    @attached = false
    console.log "Created #{@constructor.name}"

  attachToEventBus: ->
    return if @attached
    @eventBus.attach(this)
    @attached = true
    console.log("Attached #{@constructor.name}")

  detachFromEventBus: ->
    return unless @attached
    @eventBus.detach(this)
    @attached = false
    console.log("Detached #{@constructor.name}")

  publish: (event) ->
    @eventBus.publish(event)

  getStore: (name) ->
    store = @stores[name]
    throw new Error("No store named '#{name}' has been defined in #{@constructor.name}") unless store?
    return store

  getStores: (names...) ->
    _.object _.map _.flatten(names), (name) => [name, @getStore(name)]

  _dispatch: (event) ->
    func = "on#{event.type}"
    _.each @stores, (store) ->
      store[func].apply(store, [event]) if store[func]?

module.exports = Controller

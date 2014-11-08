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

  getStores: (names...) ->
    _.pick @stores, _.flatten(names)

  _dispatch: (event) ->
    func = "on#{event.type}"
    _.each @stores, (store) ->
      store[func].apply(store, [event]) if store[func]?

module.exports = Controller

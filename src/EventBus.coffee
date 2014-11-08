_ = require 'lodash'

class EventBus

  constructor: (@listeners) ->
    @controllers = []
    @pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: '/api/_auth/presence'
      encrypted: true
    _.each @listeners, (listener) =>
      listener.on 'event', @publish.bind(this)

  getSocketId: ->
    @pusher.connection.socket_id

  subscribe: (name) ->
    channel = @pusher.subscribe(name)
    _.each @listeners, (listener) =>
      listener.bind(channel)
    console.log "Subscribed to #{name} with listeners: #{_.map @listeners, (l) -> l.constructor.name}"

  attach: (controller) ->
    @controllers.push(controller) unless _.contains(@controllers, controller)

  detach: (controller) ->
    @controllers = _.without(@controllers, controller)

  publish: (event) ->
    console.log("Dispatching #{event.type} to #{_.map @controllers, (c) -> c.constructor.name}")
    _.each @controllers, (controller) ->
      controller._dispatch(event)

module.exports = EventBus

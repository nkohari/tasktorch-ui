_ = require 'lodash'

class EventBus

  constructor: (@stores, @listeners) ->
    @pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: '/api/_auth/presence'
      encrypted: true
    _.each @listeners, (listener) =>
      listener.on 'event', @publish.bind(this)

  getSocketId: ->
    @pusher.connection.socket_id

  getStore: (name) ->
    store = @stores[name]
    throw new Error("No store named '#{name}' has been registered") unless store?
    return store

  getStores: (names...) ->
    _.object _.map _.flatten(names), (name) => [name, @getStore(name)]

  subscribe: (name) ->
    channel = @pusher.subscribe(name)
    _.each @listeners, (listener) =>
      listener.bind(channel)

  publish: (event) ->
    console.log(event)
    func = "on#{event.type}"
    _.each @stores, (store) ->
      store[func].apply(store, [event]) if store[func]?

module.exports = EventBus

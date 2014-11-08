class EventBus

  constructor: (@listeners) ->
    @stores = []
    @pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: '/api/_auth/presence'
      encrypted: true
    _.each @listeners, (listener) =>
      listener.on 'event', @dispatch.bind(this)

  registerStores: (stores...) ->
    @stores = @stores.concat _.flatten(stores)

  dispatch: (event) ->
    func = "on#{event.type}"
    _.each @stores, (store) ->
      store[func].apply(store, [event]) if store[func]?

module.exports = EventBus

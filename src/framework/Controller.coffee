_ = require 'lodash'

class Controller

  constructor: (@stores, @listeners) ->
    _.each @listeners, (listener) =>
      listener.on 'event', @dispatch.bind(this)

  dispatch: (event) ->
    func = "on#{event.type}"
    _.each @stores, (store) ->
      store[func].apply(store, [event]) if store[func]?

  bindListeners: (channel) ->
    _.each @listeners, (listener) =>
      listener.bind(channel)

module.exports = Controller

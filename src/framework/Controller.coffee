_ = require 'lodash'

class Controller

  constructor: (@stores) ->

  dispatch: (event, payload) ->
    func = "on#{event}"
    _.each @stores, (store) ->
      store[func].apply(store, [payload]) if store[func]?

module.exports = Controller

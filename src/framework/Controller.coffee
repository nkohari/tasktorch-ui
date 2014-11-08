_ = require 'lodash'

class Controller

  constructor: (@eventBus, @stores) ->
    @eventBus.registerStores(@stores)

  publish: (event) ->
    @eventBus.publish(event)

  getStores: (names...) ->
    _.pick @stores, _.flatten(names)

module.exports = Controller

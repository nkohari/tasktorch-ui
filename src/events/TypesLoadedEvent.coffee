Event = require 'framework/Event'

class TypesLoadedEvent extends Event

  constructor: (@types) ->
    super()

module.exports = TypesLoadedEvent

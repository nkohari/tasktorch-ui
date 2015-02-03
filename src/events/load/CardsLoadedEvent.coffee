Event = require 'framework/Event'

class CardsLoadedEvent extends Event

  type: 'CardsLoaded'

  constructor: (@cards) ->
    super()

module.exports = CardsLoadedEvent

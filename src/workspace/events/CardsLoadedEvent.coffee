Event = require '../../framework/Event'

class CardsLoadedEvent extends Event

  constructor: (@cards) ->
    super()

module.exports = CardsLoadedEvent

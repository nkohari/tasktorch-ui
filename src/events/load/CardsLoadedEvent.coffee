Event = require 'events/framework/Event'

class CardsLoadedEvent extends Event

  type: 'CardsLoaded'

  constructor: (@cards) ->

module.exports = CardsLoadedEvent

DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class CardsLoadedEvent extends DataLoadedEvent

  type: 'CardsLoaded'

  constructor: (@cards) ->

module.exports = CardsLoadedEvent

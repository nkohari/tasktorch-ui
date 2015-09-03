DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class CardsByStageLoadedEvent extends DataLoadedEvent

  type: 'CardsByStageLoaded'

  constructor: (@stageid, @cards) ->

module.exports = CardsByStageLoadedEvent

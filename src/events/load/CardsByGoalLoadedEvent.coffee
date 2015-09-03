DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class CardsByGoalLoadedEvent extends DataLoadedEvent

  type: 'CardsByGoalLoaded'

  constructor: (@goalid, @cards) ->

module.exports = CardsByGoalLoadedEvent

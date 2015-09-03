DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class MyFollowedCardsLoadedEvent extends DataLoadedEvent

  type: 'MyFollowedCardsLoaded'

  constructor: (@cards) ->

module.exports = MyFollowedCardsLoadedEvent

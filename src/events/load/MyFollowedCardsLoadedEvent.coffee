Event = require 'events/framework/Event'

class MyFollowedCardsLoadedEvent extends Event

  type: 'MyFollowedCardsLoaded'

  constructor: (@cards) ->

module.exports = MyFollowedCardsLoadedEvent

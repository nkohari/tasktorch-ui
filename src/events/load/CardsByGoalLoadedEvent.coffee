Event = require 'events/framework/Event'

class CardsByGoalLoadedEvent extends Event

  type: 'CardsByGoalLoaded'

  constructor: (@goalid, @cards) ->

module.exports = CardsByGoalLoadedEvent

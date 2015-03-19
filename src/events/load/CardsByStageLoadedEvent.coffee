Event = require 'events/framework/Event'

class CardsByStageLoadedEvent extends Event

  type: 'CardsByStageLoaded'

  constructor: (@stageid, @cards) ->

module.exports = CardsByStageLoadedEvent

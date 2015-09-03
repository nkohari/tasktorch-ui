DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class CardsByStackLoadedEvent extends DataLoadedEvent

  type: 'CardsByStackLoaded'

  constructor: (@stackid, @cards) ->

module.exports = CardsByStackLoadedEvent

Event = require 'events/framework/Event'

class CardsByStackLoadedEvent extends Event

  type: 'CardsByStackLoaded'

  constructor: (@stackid, @cards) ->

module.exports = CardsByStackLoadedEvent

Event = require 'events/framework/Event'

class UserMovedCardEvent extends Event

  type: 'UserMovedCard'

  constructor: (@cardid, @stackid, @position) ->

module.exports = UserMovedCardEvent

Event = require 'events/framework/Event'

class UserPassedCardEvent extends Event

  type: 'UserPassedCard'

  constructor: (@cardid, @recipient, @message) ->

module.exports = UserPassedCardEvent

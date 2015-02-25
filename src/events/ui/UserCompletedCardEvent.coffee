Event = require 'events/framework/Event'

class UserCompletedCardEvent extends Event

  type: 'UserCompletedCard'

  constructor: (@cardid) ->

module.exports = UserCompletedCardEvent

Event = require 'events/framework/Event'

class UserAcceptedCardEvent extends Event
  
  type: 'UserAcceptedCard'

  constructor: (@cardid, @preempt) ->

module.exports = UserAcceptedCardEvent

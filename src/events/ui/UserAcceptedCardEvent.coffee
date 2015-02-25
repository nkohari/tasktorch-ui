Event = require 'events/framework/Event'

class UserAcceptedCardEvent extends Event
  
  type: 'UserAcceptedCard'

  constructor: (@cardid) ->

module.exports = UserAcceptedCardEvent

UiEvent = require 'events/framework/UiEvent'

class UserAcceptedCardEvent extends UiEvent
  
  type: 'UserAcceptedCard'

  constructor: (@cardid, @preempt) ->

module.exports = UserAcceptedCardEvent

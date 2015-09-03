UiEvent = require 'events/framework/UiEvent'

class UserPassedCardEvent extends UiEvent

  type: 'UserPassedCard'

  constructor: (@cardid, @recipient, @message) ->

module.exports = UserPassedCardEvent

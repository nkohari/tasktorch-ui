UiEvent = require 'events/framework/UiEvent'

class UserCompletedCardEvent extends UiEvent

  type: 'UserCompletedCard'

  constructor: (@cardid) ->

module.exports = UserCompletedCardEvent

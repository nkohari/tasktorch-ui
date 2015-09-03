UiEvent = require 'events/framework/UiEvent'

class UserMovedCardEvent extends UiEvent

  type: 'UserMovedCard'

  constructor: (@cardid, @stackid, @position) ->

module.exports = UserMovedCardEvent

UiEvent = require 'events/framework/UiEvent'

class UserChangedCardTitleEvent extends UiEvent

  type: 'UserChangedCardTitle'

  constructor: (@cardid, @title) ->

module.exports = UserChangedCardTitleEvent

UiEvent = require 'events/framework/UiEvent'

class UserChangedCardDueDateEvent extends UiEvent

  type: 'UserChangedCardDueDate'

  constructor: (@cardid, @due) ->

module.exports = UserChangedCardDueDateEvent

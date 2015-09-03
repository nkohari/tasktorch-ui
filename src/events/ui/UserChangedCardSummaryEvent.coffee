UiEvent = require 'events/framework/UiEvent'

class UserChangedCardSummaryEvent extends UiEvent

  type: 'UserChangedCardSummary'

  constructor: (@cardid, @summary) ->

module.exports = UserChangedCardSummaryEvent

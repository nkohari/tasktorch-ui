Event = require 'events/framework/Event'

class UserChangedCardSummaryEvent extends Event

  type: 'UserChangedCardSummary'

  constructor: (@cardid, @summary) ->

module.exports = UserChangedCardSummaryEvent

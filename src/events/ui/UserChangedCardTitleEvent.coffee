Event = require 'events/framework/Event'

class UserChangedCardTitleEvent extends Event

  type: 'UserChangedCardTitle'

  constructor: (@cardid, @title) ->

module.exports = UserChangedCardTitleEvent

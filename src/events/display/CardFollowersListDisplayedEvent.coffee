Event = require 'framework/Event'

class CardFollowersListDisplayedEvent extends Event

  type: 'CardFollowersListDisplayed'

  constructor: (@cardId, @userIds) ->
    super()

module.exports = CardFollowersListDisplayedEvent

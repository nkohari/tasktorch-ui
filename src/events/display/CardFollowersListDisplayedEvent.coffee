Event = require 'framework/Event'

class CardFollowersListDisplayedEvent extends Event

  constructor: (@cardId, @userIds) ->
    super()

module.exports = CardFollowersListDisplayedEvent

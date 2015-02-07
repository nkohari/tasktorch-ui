Event = require 'framework/Event'

class CardFollowersListDisplayedEvent extends Event

  type: 'CardFollowersListDisplayed'

  constructor: (@cardid, @userids) ->
    super()

module.exports = CardFollowersListDisplayedEvent

Event = require 'framework/Event'

class UserDisplayedEvent extends Event

  type: 'UserDisplayed'

  constructor: (@userid) ->
    super()

module.exports = UserDisplayedEvent

Event = require 'framework/Event'

class UserDisplayedEvent extends Event

  type: 'UserDisplayed'

  constructor: (@userId) ->
    super()

module.exports = UserDisplayedEvent

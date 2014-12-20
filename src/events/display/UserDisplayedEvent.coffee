Event = require 'framework/Event'

class UserDisplayedEvent extends Event

  constructor: (@userId) ->
    super()

module.exports = UserDisplayedEvent

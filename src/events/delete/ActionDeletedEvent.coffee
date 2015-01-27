Event = require 'framework/Event'

class ActionDeletedEvent extends Event

  constructor: (@action) ->
    super()

module.exports = ActionDeletedEvent

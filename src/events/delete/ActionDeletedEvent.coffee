Event = require 'framework/Event'

class ActionDeletedEvent extends Event

  type: 'ActionDeleted'

  constructor: (@action) ->
    super()

module.exports = ActionDeletedEvent

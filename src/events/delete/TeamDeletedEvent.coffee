DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class TeamDeletedEvent extends DocumentDeletedEvent

  type: 'TeamDeleted'

  constructor: (@team, origin) ->
    super(origin)

module.exports = TeamDeletedEvent

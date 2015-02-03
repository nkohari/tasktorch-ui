Event = require 'framework/Event'

class TeamDeletedEvent extends Event

  type: 'TeamDeleted'

  constructor: (@team) ->
    super()

module.exports = TeamDeletedEvent

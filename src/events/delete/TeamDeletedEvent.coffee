Event = require 'framework/Event'

class TeamDeletedEvent extends Event

  constructor: (@team) ->
    super()

module.exports = TeamDeletedEvent

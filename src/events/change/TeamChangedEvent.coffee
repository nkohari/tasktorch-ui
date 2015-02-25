DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class TeamChangedEvent extends DocumentChangedEvent

  type: 'TeamChanged'

  constructor: (@team, origin) ->
    super(origin)

module.exports = TeamChangedEvent

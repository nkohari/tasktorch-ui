DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class OrgDeletedEvent extends DocumentDeletedEvent

  type: 'OrgDeleted'

  constructor: (@org, origin) ->
    super(origin)

module.exports = OrgDeletedEvent

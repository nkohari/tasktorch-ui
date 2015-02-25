DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class OrgCreatedEvent extends DocumentCreatedEvent

  type: 'OrgCreated'

  constructor: (@org, origin) ->
    super(origin)

module.exports = OrgCreatedEvent

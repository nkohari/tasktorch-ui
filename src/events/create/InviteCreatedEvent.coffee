DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class InviteCreatedEvent extends DocumentCreatedEvent

  type: 'InviteCreated'

  constructor: (@invite, origin) ->
    super(origin)

module.exports = InviteCreatedEvent

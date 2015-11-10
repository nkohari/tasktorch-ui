DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class MembershipCreatedEvent extends DocumentCreatedEvent

  type: 'MembershipCreated'

  constructor: (@membership, origin) ->
    super(origin)

module.exports = MembershipCreatedEvent

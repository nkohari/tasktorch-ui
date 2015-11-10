DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class MembershipChangedEvent extends DocumentChangedEvent

  type: 'MembershipChanged'

  constructor: (@membership, origin) ->
    super(origin)

module.exports = MembershipChangedEvent

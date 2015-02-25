DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class OrgChangedEvent extends DocumentChangedEvent

  type: 'OrgChanged'

  constructor: (@org, origin) ->
    super(origin)

module.exports = OrgChangedEvent

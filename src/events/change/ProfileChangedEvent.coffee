DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class ProfileChangedEvent extends DocumentChangedEvent

  type: 'ProfileChanged'

  constructor: (@profile, origin) ->
    super(origin)

module.exports = ProfileChangedEvent

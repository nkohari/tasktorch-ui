DocumentChangedEvent = require 'events/framework/DocumentChangedEvent'

class UserChangedEvent extends DocumentChangedEvent

  type: 'UserChanged'

  constructor: (@user, origin) ->
    super(origin)

module.exports = UserChangedEvent

DocumentCreatedEvent = require 'events/framework/DocumentCreatedEvent'

class UserCreatedEvent extends DocumentCreatedEvent

  type: 'UserCreated'

  constructor: (@user, origin) ->
    super(origin)

module.exports = UserCreatedEvent

DocumentDeletedEvent = require 'events/framework/DocumentDeletedEvent'

class UserDeletedEvent extends DocumentDeletedEvent

  type: 'UserDeleted'

  constructor: (@user, origin) ->
    super(origin)

module.exports = UserDeletedEvent

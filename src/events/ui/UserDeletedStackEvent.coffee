Event = require 'events/framework/Event'

class UserDeletedStackEvent extends Event

  type: 'UserDeletedStack'

  constructor: (@stackid) ->

module.exports = UserDeletedStackEvent

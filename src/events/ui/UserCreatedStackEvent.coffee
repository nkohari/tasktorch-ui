Event = require 'events/framework/Event'

class UserCreatedStackEvent extends Event

  type: 'UserCreatedStack'

  constructor: (@name) ->

module.exports = UserCreatedStackEvent

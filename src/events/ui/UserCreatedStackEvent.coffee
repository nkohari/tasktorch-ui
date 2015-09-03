UiEvent = require 'events/framework/UiEvent'

class UserCreatedStackEvent extends UiEvent

  type: 'UserCreatedStack'

  constructor: (@name) ->

module.exports = UserCreatedStackEvent

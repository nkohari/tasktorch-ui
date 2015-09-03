UiEvent = require 'events/framework/UiEvent'

class UserDeletedStackEvent extends UiEvent

  type: 'UserDeletedStack'

  constructor: (@stackid) ->

module.exports = UserDeletedStackEvent

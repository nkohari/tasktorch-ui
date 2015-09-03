UiEvent = require 'events/framework/UiEvent'

class UserCreatedCardEvent extends UiEvent

  type: 'UserCreatedCard'

  constructor: (@orgid, @kindid) ->

module.exports = UserCreatedCardEvent

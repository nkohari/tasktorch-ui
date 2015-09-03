UiEvent = require 'events/framework/UiEvent'

class UserCreatedKindEvent extends UiEvent

  type: 'UserCreatedKind'

  constructor: (@orgid, @name, @description, @color, @stages) ->

module.exports = UserCreatedKindEvent

UiEvent = require 'events/framework/UiEvent'

class UserRenamedKindEvent extends UiEvent

  type: 'UserRenamedKind'

  constructor: (@kindid, @name) ->

module.exports = UserRenamedKindEvent

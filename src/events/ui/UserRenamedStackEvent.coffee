UiEvent = require 'events/framework/UiEvent'

class UserRenamedStackEvent extends UiEvent

  type: 'UserRenamedStack'

  constructor: (@stackid, @name) ->

module.exports = UserRenamedStackEvent

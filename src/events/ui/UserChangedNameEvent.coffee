UiEvent = require 'events/framework/UiEvent'

class UserChangedNameEvent extends UiEvent

  type: 'UserChangedName'

  constructor: (@name) ->

module.exports = UserChangedNameEvent

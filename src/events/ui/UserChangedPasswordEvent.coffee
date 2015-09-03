UiEvent = require 'events/framework/UiEvent'

class UserChangedPasswordEvent extends UiEvent

  type: 'UserChangedPassword'

  constructor: (@password) ->

module.exports = UserChangedPasswordEvent

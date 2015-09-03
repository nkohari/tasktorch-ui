UiEvent = require 'events/framework/UiEvent'

class UserChangedEmailEvent extends UiEvent

  type: 'UserChangedEmail'

  constructor: (@email) ->

module.exports = UserChangedEmailEvent

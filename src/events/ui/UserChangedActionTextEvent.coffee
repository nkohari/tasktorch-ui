UiEvent = require 'events/framework/UiEvent'

class UserChangedActionTextEvent extends UiEvent

  type: 'UserChangedActionText'

  constructor: (@actionid, @text) ->

module.exports = UserChangedActionTextEvent

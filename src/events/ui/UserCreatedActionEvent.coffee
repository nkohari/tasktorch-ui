UiEvent = require 'events/framework/UiEvent'

class UserCreatedActionEvent extends UiEvent

  type: 'UserCreatedAction'

  constructor: (@checklistid, @text) ->

module.exports = UserCreatedActionEvent

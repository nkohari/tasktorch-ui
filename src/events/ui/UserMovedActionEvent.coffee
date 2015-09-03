UiEvent = require 'events/framework/UiEvent'

class UserMovedActionEvent extends UiEvent

  type: 'UserMovedAction'

  constructor: (@actionid, @checklistid, @position) ->

module.exports = UserMovedActionEvent

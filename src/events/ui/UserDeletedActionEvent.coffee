UiEvent = require 'events/framework/UiEvent'

class UserDeletedActionEvent extends UiEvent

  type: 'UserDeletedAction'

  constructor: (@actionid) ->

module.exports = UserDeletedActionEvent

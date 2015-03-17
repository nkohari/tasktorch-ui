Event = require 'events/framework/Event'

class UserCreatedActionEvent extends Event

  type: 'UserCreatedAction'

  constructor: (@checklistid, @text) ->

module.exports = UserCreatedActionEvent

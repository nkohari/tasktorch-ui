Event = require 'events/framework/Event'

class UserMovedActionEvent extends Event

  type: 'UserMovedAction'

  constructor: (@actionid, @checklistid, @position) ->

module.exports = UserMovedActionEvent

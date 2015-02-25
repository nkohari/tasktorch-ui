Event = require 'events/framework/Event'

class UserDeletedActionEvent extends Event

  type: 'UserDeletedAction'

  constructor: (@actionid) ->

module.exports = UserDeletedActionEvent

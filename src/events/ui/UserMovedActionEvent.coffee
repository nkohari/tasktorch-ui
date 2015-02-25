Event = require 'events/framework/Event'

class UserMovedActionEvent extends Event

  type: 'UserMovedAction'

  constructor: (@actionid, @cardid, @stageid, @position) ->

module.exports = UserMovedActionEvent

Event = require 'events/framework/Event'

class UserCreatedActionEvent extends Event

  type: 'UserCreatedAction'

  constructor: (@cardid, @stageid, @text) ->

module.exports = UserCreatedActionEvent

Event = require 'events/framework/Event'

class UserChangedActionStatusEvent extends Event

  type: 'UserChangedActionStatus'

  constructor: (@actionid, @status) ->

module.exports = UserChangedActionStatusEvent

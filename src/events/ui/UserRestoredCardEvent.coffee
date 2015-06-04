Event = require 'events/framework/Event'

class UserRestoredCardEvent extends Event
  
  type: 'UserRestoredCard'

  constructor: (@cardid) ->

module.exports = UserRestoredCardEvent

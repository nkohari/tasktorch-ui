Event = require 'events/framework/Event'

class UserChangedEmailEvent extends Event

  type: 'UserChangedEmail'

  constructor: (@email) ->

module.exports = UserChangedEmailEvent

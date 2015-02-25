Event = require 'events/framework/Event'

class UserChangedActionTextEvent extends Event

  type: 'UserChangedActionText'

  constructor: (@actionid, @text) ->

module.exports = UserChangedActionTextEvent

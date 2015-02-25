Event = require 'events/framework/Event'

class UserCreatedCardEvent extends Event

  type: 'UserCreatedCard'

  constructor: (@orgid, @kindid) ->

module.exports = UserCreatedCardEvent

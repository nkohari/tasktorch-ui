Event = require 'events/framework/Event'

class UserCreatedKindEvent extends Event

  type: 'UserCreatedKind'

  constructor: (@orgid, @name, @description, @color, @stages) ->

module.exports = UserCreatedKindEvent

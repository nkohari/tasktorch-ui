Event = require 'events/framework/Event'

class UserRenamedKindEvent extends Event

  type: 'UserRenamedKind'

  constructor: (@kindid, @name) ->

module.exports = UserRenamedKindEvent

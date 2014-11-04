Event = require '../../framework/Event'

class UsersLoadedEvent extends Event

  constructor: (@users) ->
    super()

module.exports = UsersLoadedEvent

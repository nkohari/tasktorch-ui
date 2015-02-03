Event = require 'framework/Event'

class UsersLoadedEvent extends Event

  type: 'UsersLoaded'

  constructor: (@users) ->
    super()

module.exports = UsersLoadedEvent

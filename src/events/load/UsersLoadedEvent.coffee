Event = require 'events/framework/Event'

class UsersLoadedEvent extends Event

  type: 'UsersLoaded'

  constructor: (@users) ->

module.exports = UsersLoadedEvent

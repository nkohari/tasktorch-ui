DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class UsersLoadedEvent extends DataLoadedEvent

  type: 'UsersLoaded'

  constructor: (@users) ->

module.exports = UsersLoadedEvent

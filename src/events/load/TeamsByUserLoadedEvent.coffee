DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class TeamsByUserLoadedEvent extends DataLoadedEvent

  type: 'TeamsByUserLoaded'

  constructor: (@userid, @teams) ->

module.exports = TeamsByUserLoadedEvent

DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class TeamsByOrgLoadedEvent extends DataLoadedEvent

  type: 'TeamsByOrgLoaded'

  constructor: (@orgid, @teams) ->

module.exports = TeamsByOrgLoadedEvent

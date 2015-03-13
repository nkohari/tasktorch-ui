Event = require 'events/framework/Event'

class TeamsByOrgLoadedEvent extends Event

  type: 'TeamsByOrgLoaded'

  constructor: (@orgid, @teams) ->

module.exports = TeamsByOrgLoadedEvent

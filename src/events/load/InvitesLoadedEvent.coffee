DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class InvitesLoadedEvent extends DataLoadedEvent

  type: 'InvitesLoaded'

  constructor: (@invites) ->

module.exports = InvitesLoadedEvent

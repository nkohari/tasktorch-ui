Event = require 'events/framework/Event'

class InvitesLoadedEvent extends Event

  type: 'InvitesLoaded'

  constructor: (@invites) ->

module.exports = InvitesLoadedEvent

Event = require 'events/framework/Event'

class UserCreatedInvitesEvent extends Event

  type: 'UserCreatedInvites'

  constructor: (@orgid, @invites) ->

module.exports = UserCreatedInvitesEvent

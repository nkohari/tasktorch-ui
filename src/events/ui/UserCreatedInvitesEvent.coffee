UiEvent = require 'events/framework/UiEvent'

class UserCreatedInvitesEvent extends UiEvent

  type: 'UserCreatedInvites'

  constructor: (@orgid, @invites) ->

module.exports = UserCreatedInvitesEvent

UiEvent = require 'events/framework/UiEvent'

class UserChangedMembershipStatusEvent extends UiEvent

  type: 'UserChangedMembershipStatus'

  constructor: (@membershipid, @status) ->

module.exports = UserChangedMembershipStatusEvent

UiEvent = require 'events/framework/UiEvent'

class UserChangedMembershipLevelEvent extends UiEvent

  type: 'UserChangedMembershipLevel'

  constructor: (@membershipid, @level) ->

module.exports = UserChangedMembershipLevelEvent

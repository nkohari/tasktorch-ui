UiEvent = require 'events/framework/UiEvent'

class UserChangedOrgEmailEvent extends UiEvent

  type: 'UserChangedOrgEmail'

  constructor: (@orgid, @email) ->

module.exports = UserChangedOrgEmailEvent

UiEvent = require 'events/framework/UiEvent'

class UserChangedKindStatusEvent extends UiEvent

  type: 'UserChangedKindStatus'

  constructor: (@kindid, @status) ->

module.exports = UserChangedKindStatusEvent

UiEvent = require 'events/framework/UiEvent'

class UserChangedActionStatusEvent extends UiEvent

  type: 'UserChangedActionStatus'

  constructor: (@actionid, @status) ->

module.exports = UserChangedActionStatusEvent

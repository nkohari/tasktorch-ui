UiEvent = require 'events/framework/UiEvent'

class UserCancelledAccountEvent extends UiEvent
  
  type: 'UserCancelledAccount'

  constructor: (@orgid, @reason) ->

module.exports = UserCancelledAccountEvent

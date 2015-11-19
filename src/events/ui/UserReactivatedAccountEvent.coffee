UiEvent = require 'events/framework/UiEvent'

class UserReactivatedAccountEvent extends UiEvent
  
  type: 'UserReactivatedAccount'

  constructor: (@orgid) ->

module.exports = UserReactivatedAccountEvent

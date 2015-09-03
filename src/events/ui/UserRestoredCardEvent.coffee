UiEvent = require 'events/framework/UiEvent'

class UserRestoredCardEvent extends UiEvent
  
  type: 'UserRestoredCard'

  constructor: (@cardid) ->

module.exports = UserRestoredCardEvent

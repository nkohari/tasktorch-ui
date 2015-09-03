UiEvent = require 'events/framework/UiEvent'

class UserCreatedTokensEvent extends UiEvent

  type: 'UserCreatedTokens'

  constructor: (@tokens) ->

module.exports = UserCreatedTokensEvent

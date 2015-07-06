Event = require 'events/framework/Event'

class UserCreatedTokensEvent extends Event

  type: 'UserCreatedTokens'

  constructor: (@tokens) ->

module.exports = UserCreatedTokensEvent

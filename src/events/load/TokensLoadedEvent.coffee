Event = require 'events/framework/Event'

class TokensLoadedEvent extends Event

  type: 'TokensLoaded'

  constructor: (@tokens) ->

module.exports = TokensLoadedEvent

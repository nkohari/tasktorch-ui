DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class TokensLoadedEvent extends DataLoadedEvent

  type: 'TokensLoaded'

  constructor: (@tokens) ->

module.exports = TokensLoadedEvent

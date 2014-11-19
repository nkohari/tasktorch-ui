Event = require 'framework/Event'

class SuggestionsLoadedEvent extends Event

  constructor: (@phrase, @suggestions) ->
    super()

module.exports = SuggestionsLoadedEvent

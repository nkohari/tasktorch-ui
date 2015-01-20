Event = require 'framework/Event'

class SuggestionsLoadedEvent extends Event

  constructor: (@phrase, @itemType, @items) ->
    super()

module.exports = SuggestionsLoadedEvent

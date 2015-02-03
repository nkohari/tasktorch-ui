Event = require 'framework/Event'

class SuggestionsLoadedEvent extends Event

  type: 'SuggestionsLoaded'

  constructor: (@phrase, @itemType, @items) ->
    super()

module.exports = SuggestionsLoadedEvent

_     = require 'lodash'
Store = require 'framework/Store'

class SuggestionStore extends Store

  constructor: ->
    @suggestions = {}

  getSuggestions: (phrase) ->
    @suggestions[phrase]

  onSuggestionsLoaded: (event) ->
    @suggestions[event.phrase] = event.suggestions
    @announce()

module.exports = SuggestionStore

_     = require 'lodash'
Store = require 'framework/Store'

class SuggestionStore extends Store

  constructor: ->
    @suggestions = {}

  get: (phrase) ->
    @suggestions[phrase]

  onSuggestionsLoaded: (event) ->
    @suggestions[event.phrase] = event.suggestions
    @announce()

module.exports = SuggestionStore

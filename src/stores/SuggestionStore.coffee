_     = require 'lodash'
Store = require 'framework/Store'

# TODO: This really shouldn't extend Store, since it doesn't use the typical
# @items/@add/@remove stuff.
class SuggestionStore extends Store

  constructor: ->
    @items = {}

  get: (types, phrase) ->
    items = @items[phrase]
    if not items?
      return undefined
    else
      return _.pick(items, types)

  onSuggestionsLoaded: (event) ->
    items = @items[event.phrase] ?= {}
    items[event.itemType] = event.items
    @announce()

module.exports = SuggestionStore

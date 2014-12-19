_     = require 'lodash'
Store = require 'framework/Store'

class CardStore extends Store

  onCardsLoaded: (event) ->
    @add(event.cards)

  onCardCreated: (event) ->
    @add(event.card)

  onCardChanged: (event) ->
    @add(event.card)

module.exports = CardStore

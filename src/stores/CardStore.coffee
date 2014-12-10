_     = require 'lodash'
Store = require 'framework/Store'

class CardStore extends Store

  constructor: ->
    @cards = {}

  getCard: (id) ->
    @cards[id]

  getCards: (ids...) ->
    cards = []
    for id in _.flatten(ids)
      card = @cards[id]
      return undefined unless card?
      cards.push(card)
    return cards

  onCardsLoaded: (event) ->
    @cards = _.extend @cards, _.indexBy(event.cards, 'id')
    @announce()

  onCardBodyChanged: (event) ->
    card = @cards[event.id]
    if card?
      card.body = event.body
      card.version = event.version
      @announce()

  onCardTitleChanged: (event) ->
    card = @cards[event.id]
    if card?
      card.title = event.title
      card.version = event.version
      @announce()

  onCardHandedOff: (event) ->
    @cards[event.card.id] = event.card
    @announce()

module.exports = CardStore

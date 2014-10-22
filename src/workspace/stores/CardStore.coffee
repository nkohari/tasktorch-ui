_     = require 'lodash'
Store = require '../../framework/Store'

class CardStore extends Store

  constructor: ->
    @cards = {}

  getCard: (cardId) ->
    @cards[cardId]

  getCardsInStack: (stackId) ->
    _.filter @cards, (card) -> card.stack.id == stackId

  onWorkspaceLoaded: (event) ->
    @cards = _.indexBy(event.cards, 'id')
    @announce()

  onCardsLoaded: (event) ->
    @cards = _.extend @cards, _.indexBy(event.cards, 'id')
    @announce()

  onCardBodyChanged: (event) ->
    card = @cards[event.cardId]
    if card?
      card.body = event.body
      @announce()

  onCardTitleChanged: (event) ->
    card = @cards[event.cardId]
    if card?
      card.title = event.title
      @announce()

module.exports = CardStore

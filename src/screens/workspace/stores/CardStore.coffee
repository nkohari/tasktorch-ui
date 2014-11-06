_     = require 'lodash'
Store = require 'framework/Store'

class CardStore extends Store

  constructor: ->
    @cards = {}

  getCard: (id) ->
    @cards[id]

  getCardsInStack: (stackId) ->
    cards = _.filter(@cards, (card) -> card.stack.id == stackId)
    _.sortBy(cards, 'rank')

  onWorkspaceLoaded: (event) ->
    @cards = _.indexBy(event.cards, 'id')
    @announce()

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

module.exports = CardStore

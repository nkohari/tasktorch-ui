_     = require 'lodash'
Store = require '../../framework/Store'

class CardStore extends Store

  constructor: ->
    @cards = {}

  # TODO: Sort by rank
  getCardsInStack: (stackId) ->
    _.filter @cards, (card) -> card.stack == stackId

  onCardsLoaded: (event) ->
    @cards = _.extend @cards, _.indexBy(event.cards, 'id')
    @announce()

module.exports = CardStore

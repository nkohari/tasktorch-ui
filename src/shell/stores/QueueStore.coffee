_     = require 'lodash'
Store = require '../../framework/Store'

class QueueStore extends Store

  constructor: ->
    @queue = undefined
    @cards = {}

  getQueue: ->
    @queue

  getFocusedCard: ->
    _.first _.sortBy(@cards, 'rank')

  onQueueLoaded: (event) ->
    @queue = event.queue
    @cards = _.indexBy(event.cards, 'id')
    @announce()

  onCardBodyChanged: (event) ->
    card = @cards[id]
    if card?
      card.body = event.body
      card.version = event.version
      @announce()

  onCardTitleChanged: (event) ->
    card = @cards[id]
    if card?
      card.title = event.title
      card.version = event.version
      @announce()

module.exports = QueueStore

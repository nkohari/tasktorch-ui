_     = require 'lodash'
Store = require 'framework/Store'

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

  onCardSummaryChanged: (event) ->
    card = @cards[event.id]
    if card?
      card.summary = event.summary
      card.version = event.version
      @announce()

  onCardTitleChanged: (event) ->
    card = @cards[event.id]
    if card?
      card.title = event.title
      card.version = event.version
      @announce()

module.exports = QueueStore

_                       = require 'lodash'
Store                   = require 'framework/Store'
LoadCardRequest         = require 'requests/LoadCardRequest'
LoadCardsInStackRequest = require 'requests/LoadCardsInStackRequest'

class CardStore extends Store

  displayName: 'CardStore'

  onCardDisplayed: (event) ->
    if @get(event.cardId)?
      @announce()
    else
      @execute new LoadCardRequest(event.cardId)

  onCardListDisplayed: (event) ->
    if @getMany(event.cardIds)?
      @announce()
    else
      @execute new LoadCardsInStackRequest(event.stackId)

  onCardsLoaded: (event) ->
    @add(event.cards)

  onCardCreated: (event) ->
    @add(event.card)

  onCardChanged: (event) ->
    @add(event.card)

module.exports = CardStore

_                       = require 'lodash'
Store                   = require 'framework/Store'
LoadCardRequest         = require 'requests/LoadCardRequest'
LoadCardsInStackRequest = require 'requests/LoadCardsInStackRequest'

class CardStore extends Store

  displayName: 'CardStore'

  onCardDisplayed: (event) ->
    if @get(event.cardid)?
      @announce()
    else
      @execute new LoadCardRequest(event.cardid)

  onCardListDisplayed: (event) ->
    if @getMany(event.cardids)?
      @announce()
    else
      @execute new LoadCardsInStackRequest(event.stackid)

  onCardsLoaded: (event) ->
    @add(event.cards)

  onCardCreated: (event) ->
    @add(event.card)

  onCardChanged: (event) ->
    @add(event.card)

module.exports = CardStore

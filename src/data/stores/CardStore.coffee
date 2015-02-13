_                          = require 'lodash'
Store                      = require 'framework/Store'
LoadCardRequest            = require 'requests/LoadCardRequest'
LoadCardsInStackRequest    = require 'requests/LoadCardsInStackRequest'
LoadMyFollowedCardsRequest = require 'requests/LoadMyFollowedCardsRequest'

class CardStore extends Store

  displayName: 'CardStore'

  getMyFollowedCards: (userid) ->
    _.filter @items, (card) -> _.contains(card.followers, userid)

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

  onMyFollowedCardsDisplayed: (event) ->
    @execute new LoadMyFollowedCardsRequest()

  onCardsLoaded: (event) ->
    @add(event.cards)

  onCardCreated: (event) ->
    @add(event.card)

  onCardChanged: (event) ->
    @add(event.card)

module.exports = CardStore

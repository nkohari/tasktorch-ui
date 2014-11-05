_     = require 'lodash'
Store = require '../../framework/Store'

class FocusedCardStore extends Store

  constructor: ->
    @focusedCard = undefined

  getFocusedCard: ->
    @focusedCard

  onFocusLoaded: (event) ->
    @focusedCard = event.card
    @announce()

  onCardBodyChanged: (event) ->
    if @focusedCard?.id == event.id
      @focusedCard.body = event.body
      @focusedCard.version = event.version
      @announce()

  onCardTitleChanged: (event) ->
    if @focusedCard?.id == event.id
      @focusedCard.title = event.title
      @focusedCard.version = event.version
      @announce()

module.exports = FocusedCardStore

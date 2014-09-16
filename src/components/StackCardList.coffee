_         = require 'lodash'
React     = require 'react'
StackCard = require './StackCard'
{div}     = React.DOM

StackCardList = React.createClass {

  getInitialState: ->
    {cards: []}

  componentWillReceiveProps: (newProps) ->
    @setState {cards: newProps.cards}

  componentWillMount: ->
    @setState {cards: @props.cards}

  render: ->
    dragDrop =
      start: @startDragging
      stop: @stopDragging
      hover: @hoveringOver
    cards = _.map @state.cards, (card) =>
      isOpen = _.any @props.openCards, (c) -> c.id == card.id
      isDragging = @props.draggingCard?.id == card.id
      StackCard {card, dragDrop, isOpen, isDragging}
    div {className: 'card-list'}, cards

  startDragging: (card) ->
    Screen.startDraggingCard(card)

  stopDragging: ->
    Screen.stopDraggingCard()

  hoveringOver: (hoverItem, isAppending) ->
    cards = _.clone(@state.cards)
    from = @state.cards.indexOf(@props.draggingCard)
    to   = @state.cards.indexOf(hoverItem)
    to++ if isAppending
    to-- if (from < to)
    cards.splice(to, 0, cards.splice(from, 1)[0])
    @setState {cards}

}

module.exports = StackCardList

React         = require 'react'
Bus           = require '../Bus'
Loader        = require '../Loader'
Panel         = require './Panel'
StackCardList = require './StackCardList'

StackColumn = React.createClass {

  getInitialState: ->
    {stack: {}, cards: []}

  componentWillReceiveProps: (newProps) ->
    @loadCards(newProps.stack)

  componentWillMount: ->
    @loadCards(@props.stack)
    Bus.stacks.subscribe(this)

  componentWillUnmount: ->
    Bus.stacks.unsubscribe(this)

  loadCards: (stack) ->
    @setState {stack}
    Loader.getCardsInStack stack.id, (err, cards) =>
      @setState {cards}

  render: ->
    style = {zIndex: 99 - @props.position}
    Panel {title: @state.stack.name, className: 'stack', style, icon: 'stack', onClose: @handlePanelClose}, [
      StackCardList {cards: @state.cards, openCards: @props.openCards, draggingCard: @props.draggingCard}
    ]

  dataDidChange: (stack) ->
    @setState {stack} if stack.id == @state.stack.id

  handlePanelClose: ->
    Screen.closeStack(@state.stack)

}

module.exports = StackColumn

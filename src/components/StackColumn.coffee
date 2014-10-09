React         = require 'react'
Router        = require 'react-router'
Bus           = require '../Bus'
Api           = require '../Api'
Panel         = require './Panel'
StackCardList = require './StackCardList'

StackColumn = React.createClass {

  mixins: [Router.ActiveState],

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
    {organizationId} = @getActiveParams()
    Api.getCardsInStack organizationId, stack.id, (err, cards) =>
      @setState {cards}

  render: ->
    style = {zIndex: 99 - @props.position}
    Panel {title: @state.stack.name, className: 'stack', style, icon: "stack-#{@state.stack.kind}", onClose: @handlePanelClose}, [
      StackCardList {stack: @state.stack, cards: @state.cards, openCards: @props.openCards, draggingCard: @props.draggingCard}
    ]

  dataDidChange: (stack) ->
    @setState {stack} if stack.id == @state.stack.id

  handlePanelClose: ->
    Screen.closeStack(@state.stack)

}

module.exports = StackColumn

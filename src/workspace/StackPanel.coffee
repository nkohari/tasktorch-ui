_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
Bus                = require '../Bus'
Api                = require '../Api'
Panel              = require '../common/Panel'
StackCardFrame     = require './StackCardFrame'
WorkspaceViewState = require './WorkspaceViewState'
{ul}               = React.DOM

StackPanel = React.createClass {

  mixins: [Router.ActiveState],

  getInitialState: ->
    {stack: {}, cards: []}

  componentWillReceiveProps: (newProps) ->
    @loadCards(newProps.stackId) if @props.stackId != newProps.stackId

  componentWillMount: ->
    @loadCards(@props.stackId)
    Bus.stacks.subscribe(this)

  componentWillUnmount: ->
    Bus.stacks.unsubscribe(this)

  loadCards: (stackId) ->
    {organizationId} = @getActiveParams()
    Api.getStack organizationId, stackId, (err, stack) =>
      @setState {stack: _.omit(stack, 'cards'), cards: stack.cards}

  render: ->

    cards = _.map @state.cards, (card, index) =>
      StackCardFrame {stack: @state.stack, cardId: card.id, card, index}

    Panel {
      panelTitle: @state.stack.name
      className:  'stack'
      style:      {zIndex: 99 - @props.position}
      icon:       "stack-#{@state.stack.kind}"
      close:      @makeCloseLinkProps()
      onDragStart:    @handleDragStart
      onDragEnd:      @handleDragEnd
      onDragOver:     @handleDragOver
    }, [
      ul {ref: 'cardList', className: 'card-list'}, cards
    ]

  makeCloseLinkProps: ->
    viewState = new WorkspaceViewState(this)
    viewState.removeStack(@state.stack.id)
    return viewState.makeLinkProps()

  dataDidChange: (stack) ->
    @setState {stack} if stack.id == @state.stack.id

  handleDragStart: (event) ->
    console.log("started dragging from stack #{@state.stack.id}")

  handleDragEnd: ->
    console.log("stopped dragging from stack #{@state.stack.id}")

  handleDragOver: (event) ->
    {draggingCard, draggingIndex, hoveringCard, hoveringIndex} = Screen.state
    return unless draggingCard? and hoveringCard?

    event.preventDefault()
    event.dataTransfer.dropEffect = 'move'

    rect = @refs.cardList.getDOMNode().getBoundingClientRect()
    console.log "pageY = #{event.pageY} top = #{rect.top} bottom = #{rect.bottom}"
    return if event.pageY < rect.top
    return if event.pageY > rect.bottom

    @moveCard(draggingIndex, hoveringIndex)

  moveCard: (fromIndex, toIndex) ->
    cards = _.clone(@state.cards)
    card = cards[toIndex]
    cards[toIndex] = cards[fromIndex]
    cards[fromIndex] = card
    @setState {cards}

}

module.exports = StackPanel

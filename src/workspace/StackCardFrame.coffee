React              = require 'react/addons'
Router             = require 'react-router'
Bus                = require '../Bus'
InboxCard          = require './cards/InboxCard'
QueueCard          = require './cards/QueueCard'
BacklogCard        = require './cards/BacklogCard'
WorkspaceViewState = require './WorkspaceViewState'
{div}              = React.DOM
{classSet}         = React.addons

CardTypes =
  backlog: BacklogCard
  inbox:   InboxCard
  queue:   QueueCard

StackCardFrame = React.createClass {

  mixins: [Router.ActiveState, Router.Navigation]

  getInitialState: ->
    {card: {}, dragging: false, hovering: false}

  componentWillReceiveProps: (newProps) ->
    @setState {card: newProps.card}

  componentWillMount: ->
    @setState {card: @props.card}
    Bus.cards.subscribe(this)

  componentWillUnmount: ->
    Bus.cards.unsubscribe(this)

  render: ->

    viewState = new WorkspaceViewState(this)

    classes = 
      'stack-card': true
      dragging:     @state.dragging
      hovering:     @state.hovering
      active:       viewState.isCardActive(@props.cardId)

    div {
      className:      classSet(classes)
      draggable:      true
      'aria-grabbed': @state.dragging
      onClick:        @handleClick
      onDragStart:    @handleDragStart
      onDragEnd:      @handleDragEnd
      onDragOver:     @handleDragOver
      onDragLeave:    @handleDragLeave
    }, [
      CardTypes[@props.stack.kind] {card: @state.card}
    ]

  dataDidChange: (card) ->
    @setState {card} if @state.card.id == card.id

  handleClick: ->
    viewState = new WorkspaceViewState(this)
    viewState.addCard(@state.card.id)
    props = viewState.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

  handleDragStart: (event) ->
    event.dataTransfer.effectAllowed = 'move'
    event.dataTransfer.setData('text', '')
    @setState {dragging: true}
    Screen.startDraggingCard(@state.card, @props.index)
    console.log("started dragging")

  handleDragEnd: ->
    @setState {dragging: false, hovering: false}
    Screen.stopDraggingCard()
    console.log("stopped dragging")

  handleDragOver: (event) ->
    if Screen.state.draggingCard.id == @state.card.id
      event.preventDefault()
      event.stopPropagation()
      return
    Screen.hoveringOver(@state.card, @props.index)

  handleDragLeave: (event) ->

}

module.exports = StackCardFrame

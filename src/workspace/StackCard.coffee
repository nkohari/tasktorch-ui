React       = require 'react/addons'
Bus         = require '../Bus'
InboxCard   = require './cards/InboxCard'
QueueCard   = require './cards/QueueCard'
BacklogCard = require './cards/BacklogCard'
{div}       = React.DOM
{classSet}  = React.addons

CardBodyTypes =
  backlog: BacklogCard
  inbox:   InboxCard
  queue:   QueueCard

StackCard = React.createClass {

  getInitialState: ->
    {card: {}}

  componentWillReceiveProps: (newProps) ->
    @setState {card: newProps.card}

  componentWillMount: ->
    @setState {card: @props.card}
    Bus.cards.subscribe(this)

  componentWillUnmount: ->
    Bus.cards.unsubscribe(this)

  render: ->

    classes = {'stack-card': true, dragging: @props.isDragging, active: @props.isOpen}
    classes[@state.card.type] = true

    div {
      className:   classSet(classes)
      draggable:   true
      onClick:     @handleClick
      onDragStart: @handleDragStart
      onDragEnd:   @handleDragEnd
      onDragOver:  @handleDragOver
    }, [
      CardBodyTypes[@props.stack.kind] {card: @state.card}
    ]

  dataDidChange: (card) ->
    @setState {card} if @state.card.id == card.id

  handleClick: ->
    Screen.openCard(@state.card)

  handleDragStart: (event) ->
    event.dataTransfer.effectAllowed = 'move'
    @props.dragDrop.start(@state.card)

  handleDragEnd: ->
    @props.dragDrop.stop()

  handleDragOver: (event) ->
    event.preventDefault()
    target = event.currentTarget
    rect = target.getBoundingClientRect()
    isAppending = event.clientY - rect.top > target.offsetHeight / 2
    @props.dragDrop.hover(@state.card, isAppending)

}

module.exports = StackCard

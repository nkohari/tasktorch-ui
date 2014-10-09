React              = require 'react/addons'
Router             = require 'react-router'
Bus                = require '../Bus'
InboxCard          = require './cards/InboxCard'
QueueCard          = require './cards/QueueCard'
BacklogCard        = require './cards/BacklogCard'
WorkspaceViewState = require './WorkspaceViewState'
{div}              = React.DOM
{classSet}         = React.addons

CardBodyTypes =
  backlog: BacklogCard
  inbox:   InboxCard
  queue:   QueueCard

StackCardFrame = React.createClass {

  mixins: [Router.ActiveState, Router.Navigation]

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

    classes = {'stack-card': true}
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
    viewState = new WorkspaceViewState(this)
    viewState.addCard(@state.card.id)
    props = viewState.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

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

module.exports = StackCardFrame

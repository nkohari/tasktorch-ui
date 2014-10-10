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
    {card: {}, dragging: false}

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
      active:       viewState.isCardActive(@props.cardId)

    div {
      className:   classSet(classes)
      draggable:   true
      onClick:     @handleClick
      onDragStart: @handleDragStart
      onDragEnd:   @handleDragEnd
      onDragOver:  @handleDragOver
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
    @setState {dragging: true}
    event.dataTransfer.effectAllowed = 'move'
    console.log("drag started #{@state.card.id}")

  handleDragEnd: ->
    @setState {dragging: false}
    console.log("drag stopped #{@state.card.id}")

  handleDragOver: (event) ->
    event.preventDefault()
    target = event.currentTarget
    rect = target.getBoundingClientRect()
    isAppending = event.clientY - rect.top > target.offsetHeight / 2
    console.log("drag over #{@state.card.id}, isAppending = #{isAppending}")

}

module.exports = StackCardFrame

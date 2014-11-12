React        = require 'react/addons'
Router       = require 'react-router'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../WorkspaceUrl'
InboxCard    = React.createFactory(require './cards/InboxCard')
QueueCard    = React.createFactory(require './cards/QueueCard')
BacklogCard  = React.createFactory(require './cards/BacklogCard')
{div}        = React.DOM
{classSet}   = React.addons

CardComponents =
  Backlog: BacklogCard
  Inbox:   InboxCard
  Queue:   QueueCard

StackCardFrame = React.createClass {

  displayName: 'StackCardFrame'

  mixins: [
    ActiveUrl(WorkspaceUrl)
    Router.Navigation
  ]

  propTypes:
    card:  React.PropTypes.object.isRequired
    stack: React.PropTypes.object.isRequired

  getInitialState: ->
    {dragging: false, hovering: false}

  render: ->

    classes = 
      'stack-card': true
      dragging:     @state.dragging
      hovering:     @state.hovering
      active:       @getActiveUrl().isCardActive(@props.card.id)

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
      CardComponents[@props.stack.type] {card: @props.card}
    ]

  handleClick: ->
    url = @getActiveUrl()
    url.addCard(@props.card.id)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

  handleDragStart: (event) ->
    event.dataTransfer.effectAllowed = 'move'
    event.dataTransfer.setData('text', '')
    @setState {dragging: true}
    Screen.startDraggingCard(@props.card, @props.index)
    console.log("started dragging")

  handleDragEnd: ->
    @setState {dragging: false, hovering: false}
    Screen.stopDraggingCard()
    console.log("stopped dragging")

  handleDragOver: (event) ->
    if Screen.state.draggingCard.id == @props.card.id
      event.preventDefault()
      event.stopPropagation()
      return
    Screen.hoveringOver(@props.card, @props.index)

  handleDragLeave: (event) ->

}

module.exports = StackCardFrame

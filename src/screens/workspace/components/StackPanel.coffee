_              = require 'lodash'
React          = require 'react'
Router         = require 'react-router'
Flux           = require 'mixins/Flux'
ActiveUrl      = require 'mixins/ActiveUrl'
WorkspaceUrl   = require '../WorkspaceUrl'
Panel          = React.createFactory(require 'common/Panel')
StackCardFrame = React.createFactory(require './StackCardFrame')
{ul}           = React.DOM

StackPanel = React.createClass {

  displayName: 'StackPanel'

  mixins: [
    Flux('stacks', 'cards')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    stackId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    return {
      stack: stores.stacks.getStack(@props.stackId)
      cards: stores.cards.getCardsInStack(@props.stackId)
    }

  componentWillReceiveProps: (newProps) ->
    @loadStack(newProps.stackId) if @props.stackId != newProps.stackId

  componentWillMount: ->
    @loadStack(@props.stackId)

  loadStack: (stackId) ->
    controller = @getController()
    controller.loadStack(stackId)
    controller.loadCardsInStack(stackId)

  render: ->

    cards = _.map @state.cards, (card, index) =>
      StackCardFrame {key: "card-frame-#{card.id}", stack: @state.stack, card, index}

    Panel {
      panelTitle:  @state.stack.name
      className:   'stack'
      style:       {zIndex: 99 - @props.position}
      icon:        "stack-#{@state.stack.kind.toLowerCase()}"
      close:       @makeCloseLinkProps()
      onDragStart: @handleDragStart
      onDragEnd:   @handleDragEnd
      onDragOver:  @handleDragOver
    }, [
      ul {key: 'card-list', ref: 'cardList', className: 'card-list'}, cards
    ]

  makeCloseLinkProps: ->
    url = @getActiveUrl()
    url.removeStack(@state.stack.id)
    return url.makeLinkProps()

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

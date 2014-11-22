_                       = require 'lodash'
React                   = require 'react'
Router                  = require 'react-router'
ActiveUrl               = require 'mixins/ActiveUrl'
Observe                 = require 'mixins/Observe'
WorkspaceUrl            = require '../../WorkspaceUrl'
LoadStackRequest        = require 'requests/LoadStackRequest'
LoadCardsInStackRequest = require 'requests/LoadCardsInStackRequest'
Icon                    = React.createFactory(require 'common/Icon')
StackHeader             = React.createFactory(require './StackHeader')
StackCardFrame          = React.createFactory(require './StackCardFrame')
StackFooter             = React.createFactory(require './StackFooter')
Link                    = React.createFactory(Router.Link)
{div, ul}               = React.DOM

StackPanel = React.createClass {

  displayName: 'StackPanel'

  mixins: [
    Observe('stacks', 'cards', 'teams', 'users')
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
    @execute new LoadStackRequest(stackId)
    @execute new LoadCardsInStackRequest(stackId)

  isReady: ->
    @state.stack? and @state.cards?

  render: ->

    children = if @isReady() then @renderChildren() else []

    div {
      style:       {zIndex: 99 - @props.position}
      className:   'stack panel'
      onDragStart: @handleDragStart
      onDragEnd:   @handleDragEnd
      onDragOver:  @handleDragOver
    }, children

  renderChildren: ->

    if @state.cards.length == 0
      emptyMessage = div {key: 'empty', className: 'empty-message'}, ['Nothing here']
      cards = []
    else
      emptyMessage = undefined
      cards = _.map @state.cards, (card, index) =>
        StackCardFrame {key: "card-frame-#{card.id}", stack: @state.stack, card, index}

    return _.compact [
      @makeCloseLink()
      StackHeader {key: 'header', className: 'header', stack: @state.stack}
      emptyMessage if emptyMessage?
      ul {key: 'cards', ref: 'cardList', className: 'cards'}, cards
      StackFooter {key: 'footer', className: 'footer', stack: @state.stack}
    ]

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeStack(@props.stackId)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

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

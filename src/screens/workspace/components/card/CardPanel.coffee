_               = require 'lodash'
React           = require 'react'
Router          = require 'react-router'
Constants       = require 'framework/Constants'
Observe         = require 'mixins/Observe'
ActiveUrl       = require 'mixins/ActiveUrl'
WorkspaceUrl    = require '../../WorkspaceUrl'
LoadCardRequest = require 'requests/LoadCardRequest'
Icon            = React.createFactory(require 'common/Icon')
CardHeader      = React.createFactory(require './CardHeader')
CardDetails     = React.createFactory(require './CardDetails')
CardFooter      = React.createFactory(require './CardFooter')
Link            = React.createFactory(Router.Link)
{div}           = React.DOM

CardPanel = React.createClass {

  displayName: 'CardPanel'

  mixins: [
    Observe('cards', 'kinds', 'stacks')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    cardId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    card = stores.cards.getCard(@props.cardId)
    if card?
      kind = stores.kinds.getKind(card.kind.id)
      stack = stores.stacks.getStack(card.stack.id)
    {card, kind, stack}

  componentWillReceiveProps: (newProps) ->
    @loadCard(newProps.cardId) if @props.cardId != newProps.cardId

  componentWillMount: ->
    @loadCard(@props.cardId)

  loadCard: (cardId) ->
    @execute new LoadCardRequest(cardId)

  isReady: ->
    @state.card? and @state.stack? and @state.kind?

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {
      style: {zIndex: 99 - @props.position}
      className: 'card-frame'
    }, [
      div {className: 'card'}, children
    ]

  renderChildren: ->
    return [
      @makeCloseLink()
      CardHeader {key: 'header', card: @state.card, stack: @state.stack, kind: @state.kind}
      CardDetails {key: 'details', card: @state.card, kind: @state.kind}
      CardFooter {key: 'footer', card: @state.card}
    ]

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeCard(@props.cardId)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

}

module.exports = CardPanel

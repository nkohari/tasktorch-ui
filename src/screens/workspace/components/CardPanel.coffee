_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
Constants          = require 'framework/Constants'
Observe            = require 'mixins/Observe'
ActiveUrl          = require 'mixins/ActiveUrl'
WorkspaceUrl       = require '../WorkspaceUrl'
LoadCardRequest    = require 'requests/LoadCardRequest'
Icon               = React.createFactory(require 'common/Icon')
CardHeader         = React.createFactory(require './CardHeader')
CardSubheader      = React.createFactory(require './CardSubheader')
CardDetails        = React.createFactory(require './CardDetails')
Link               = React.createFactory(Router.Link)
{div}              = React.DOM

CardPanel = React.createClass {

  displayName: 'CardPanel'

  mixins: [
    Observe('cards', 'stacks', 'types')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    cardId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    card = stores.cards.getCard(@props.cardId)
    if card?
      stack = stores.stacks.getStack(card.stack.id)
      type = stores.types.getType(card.type.id)
    {card, stack, type}

  componentWillReceiveProps: (newProps) ->
    @loadCard(newProps.cardId) if @props.cardId != newProps.cardId

  componentWillMount: ->
    @loadCard(@props.cardId)

  loadCard: (cardId) ->
    @execute new LoadCardRequest(cardId)

  render: ->

    children = []
    if @state.card? and @state.stack? and @state.type?
      children = [
        @makeCloseLink()
        CardHeader {key: 'header', card: @state.card, stack: @state.stack, type: @state.type}
        CardSubheader {key: 'subheader', card: @state.card, stack: @state.stack, type: @state.type}
        CardDetails {key: 'details', card: @state.card, type: @state.type}
      ]

    div {
      style: {zIndex: 99 - @props.position}
      className: 'card panel'
    }, children

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeCard(@props.cardId)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

}

module.exports = CardPanel

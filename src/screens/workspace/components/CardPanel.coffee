_             = require 'lodash'
React         = require 'react'
Router        = require 'react-router'
Constants     = require 'framework/Constants'
Flux          = require 'mixins/Flux'
ActiveUrl     = require 'mixins/ActiveUrl'
WorkspaceUrl  = require '../WorkspaceUrl'
Icon          = React.createFactory(require 'common/Icon')
CardHeader    = React.createFactory(require './CardHeader')
CardDetails      = React.createFactory(require './CardDetails')
Link          = React.createFactory(Router.Link)
{div}         = React.DOM

CardPanel = React.createClass {

  displayName: 'CardPanel'

  mixins: [
    Flux('cards', 'goals', 'types', 'stacks', 'users')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    cardId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    card = stores.cards.getCard(@props.cardId)
    if card?
      goal = stores.goals.getGoal(card.goal.id)
      stack = stores.stacks.getStack(card.stack.id)
      type = stores.types.getType(card.type.id)
      participants = stores.users.getUsers(_.pluck(card.participants, 'id'))
    {card, goal, participants, stack, type}

  componentWillMount: ->
    @getController().loadCard(@props.cardId)

  render: ->

    if @state.card?
      children = [
        @makeCloseLink()
        CardHeader {key: 'header', card: @state.card, goal: @state.goal, stack: @state.stack, type: @state.type}
        CardDetails {key: 'details', card: @state.card, participants: @state.participants}
      ]
    else 
      title = 'Loading'
      children = []

    div {
      style:      {zIndex: 99 - @props.position}
      className:  'card'
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

_             = require 'lodash'
React         = require 'react'
Router        = require 'react-router'
Constants     = require 'framework/Constants'
Flux          = require 'mixins/Flux'
ActiveUrl     = require 'mixins/ActiveUrl'
WorkspaceUrl  = require '../WorkspaceUrl'
Icon          = React.createFactory(require 'common/Icon')
CardHeader    = React.createFactory(require './CardHeader')
CardSubheader = React.createFactory(require './CardSubheader')
CardDetails   = React.createFactory(require './CardDetails')
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
    currentUser = stores.users.getCurrentUser()
    if card?
      goal = stores.goals.getGoal(card.goal.id)
      stack = stores.stacks.getStack(card.stack.id)
      type = stores.types.getType(card.type.id)
      participants = stores.users.getUsers(_.pluck(card.participants, 'id'))
    {card, goal, participants, stack, type, currentUser}

  componentWillMount: ->
    @getController().loadCard(@props.cardId)

  isReady: ->
    @state.card? and @state.stack? and @state.type? and
      _.compact(@state.participants).length == @state.card.participants.length

  render: ->

    style = {zIndex: 99 - @props.position}

    unless @isReady()
      return div {style, className: 'card loading'}, []

    div {
      style
      className:  'card'
    }, [
      @makeCloseLink()
      CardHeader {key: 'header', card: @state.card, stack: @state.stack, type: @state.type}
      CardSubheader {key: 'subheader', card: @state.card, goal: @state.goal, stack: @state.stack, participants: @state.participants, currentUser: @state.currentUser}
      CardDetails {key: 'details', card: @state.card, participants: @state.participants}
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

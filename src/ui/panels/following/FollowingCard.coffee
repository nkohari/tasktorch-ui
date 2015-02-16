_                   = require 'lodash'
React               = require 'react'
Router              = require 'react-router'
PropTypes           = require 'framework/PropTypes'
Url                 = require 'framework/Url'
Observe             = require 'framework/mixins/Observe'
StackDisplayedEvent = require 'events/display/StackDisplayedEvent'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
CardLocation        = React.createFactory(require 'ui/common/CardLocation')
CardOwner           = React.createFactory(require 'ui/common/CardOwner')
Link                = React.createFactory(require 'ui/common/Link')
Frame               = React.createFactory(require 'ui/common/Frame')
ListItem            = React.createFactory(require 'ui/common/ListItem')
StackName           = React.createFactory(require 'ui/common/StackName')
Time                = React.createFactory(require 'ui/common/Time')
CardProgressBar     = React.createFactory(require 'ui/panels/following/CardProgressBar')

FollowingCard = React.createClass {

  displayName: 'FollowingCard'

  propTypes:
    card: PropTypes.Card

  mixins: [
    Router.State
    Observe('kinds', 'notes', 'stacks', 'users')
  ]

  componentDidMount: ->
    @publish new UserDisplayedEvent(@props.card.owner) if @props.card.owner?
    @publish new StackDisplayedEvent(@props.card.stack) if @props.card.stack?

  componentWillReceiveProps: (newProps) ->
    if @props.card.owner? and @props.card.owner != newProps.card.owner
      @publish new UserDisplayedEvent(newProps.card.owner)
    if @props.card.stack? and @props.card.stack != newProps.card.stack
      @publish new StackDisplayedEvent(newProps.card.stack)

  sync: (stores) ->
    kind  = stores.kinds.get(@props.card.kind)
    notes = stores.notes.getAllByCard(@props.card.id)
    user  = stores.users.get(@props.card.owner) if @props.card.owner?
    stack = stores.stacks.get(@props.card.stack) if @props.card.stack?
    {kind, user, stack, notes}

  isReady: ->
    @state.kind? and @state.notes? and (@state.user? or not @props.card.owner?) and (@state.stack? or not @props.card.stack?)

  render: ->

    if @state.kind?
      style = {borderLeftColor: @state.kind.color}

    url = new Url(this)
    url.addCardAfterPanel(@props.card.id, 'f')
    props = url.makeLinkProps {style}

    ListItem {@isReady, @onClick, className: 'following-card'},
      Link props,
        CardOwner {user: @state.user}
        Frame {className: 'summary'},
          Frame {className: 'title'}, @props.card.title or 'Untitled Card'
          CardLocation {card: @props.card, stack: @state.stack}
          CardProgressBar {card: @props.card}

}

module.exports = FollowingCard

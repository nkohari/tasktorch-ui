_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
PropTypes          = require 'framework/PropTypes'
Url                = require 'framework/Url'
Observe            = require 'framework/mixins/Observe'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
CardOwner          = React.createFactory(require 'ui/common/CardOwner')
Link               = React.createFactory(require 'ui/common/Link')
Frame              = React.createFactory(require 'ui/common/Frame')
ListItem           = React.createFactory(require 'ui/common/ListItem')
Time               = React.createFactory(require 'ui/common/Time')

FollowingCard = React.createClass {

  displayName: 'FollowingCard'

  propTypes:
    card: PropTypes.Card

  mixins: [
    Router.State
    Observe('kinds', 'notes', 'users')
  ]

  componentDidMount: ->
    if @props.card.owner?
      @publish new UserDisplayedEvent(@props.card.owner)

  componentWillReceiveProps: (newProps) ->
    if @props.card.owner? and @props.card.owner != newProps.card.owner
      @publish new UserDisplayedEvent(newProps.card.owner)

  sync: (stores) ->
    kind  = stores.kinds.get(@props.card.kind)
    user  = stores.users.get(@props.card.owner) if @props.card.owner?
    notes = stores.notes.getAllByCard(@props.card.id)
    {kind, user, notes}

  isReady: ->
    @state.kind? and @state.notes? and (@state.user? or not @props.card.owner?)

  render: ->

    if @state.kind?
      style = {borderLeftColor: @state.kind.color}

    url = new Url(this)
    url.addCardAfterPanel(@props.card.id, 'f')
    props = url.makeLinkProps {style}

    ListItem {@isReady, @onClick, className: 'following-card'},
      Link props,
        CardOwner {user: @state.user}
        Frame {className: 'title'}, @props.card.title

}

module.exports = FollowingCard

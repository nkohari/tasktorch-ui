_                = require 'lodash'
React            = require 'react'
classSet         = require 'common/util/classSet'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
Navigator        = require 'ui/framework/mixins/Navigator'
CardPanelState   = require 'ui/screens/workspace/panels/card/CardPanelState'
Card             = React.createFactory(require 'ui/common/Card')
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
CardLocation     = React.createFactory(require 'ui/common/CardLocation')
CardLink         = React.createFactory(require 'ui/common/CardLink')
CardOwner        = React.createFactory(require 'ui/common/CardOwner')
{div}            = React.DOM

FollowingCard = React.createClass {

  displayName: 'FollowingCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    kind:  cache('kinds').get(@props.card.kind)
    user:  cache('users').get(@props.card.user)   if @props.card.user?
    team:  cache('teams').get(@props.card.team)   if @props.card.team?
    stack: cache('stacks').get(@props.card.stack) if @props.card.stack?
  }

  isReady: ->
    @state.kind? and (@state.user? or not @props.card.user?) and (@state.team? or not @props.card.team?) and (@state.stack? or not @props.card.stack?)

  render: ->

    Card {className: 'following-card', card: @props.card},
      CardOwner {user: @state.user, team: @state.team}
      div {className: 'card-info'},
        div {className: 'title'},
          @props.card.title or 'Untitled Card'
        div {className: 'widgets'},
          CardLocation {card: @props.card, stack: @state.stack, link: true}
      div {className: 'controls'},
        CardLink {card: @props.card, onClick: @showCard}

  showCard: ->
    @getScreen('workspace').addPanelAfter('following', new CardPanelState(@props.card.id))

}

module.exports = FollowingCard

#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
classSet             = require 'common/util/classSet'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
CardPanelSpec        = require 'ui/framework/panels/CardPanelSpec'
Card                 = React.createFactory(require 'ui/common/Card')
CardFollowToggle     = React.createFactory(require 'ui/common/CardFollowToggle')
CardLocation         = React.createFactory(require 'ui/common/CardLocation')
CardLink             = React.createFactory(require 'ui/common/CardLink')
CardOwner            = React.createFactory(require 'ui/common/CardOwner')
{div}                = React.DOM
#--------------------------------------------------------------------------------
require './FollowingCard.styl'
#--------------------------------------------------------------------------------

FollowingCard = React.createClass {

  displayName: 'FollowingCard'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    kind:  cache('kinds').get(@props.card.kind)
    stack: cache('stacks').get(@props.card.stack) if @props.card.stack?
  }

  isReady: ->
    @state.kind? and (@state.stack? or not @props.card.stack?)

  render: ->

    Card {className: 'following-card', card: @props.card},
      CardOwner {card: @props.card}
      div {className: 'card-info'},
        div {className: 'title'},
          @props.card.title or 'Untitled Card'
        div {className: 'widgets'},
          CardLocation {card: @props.card, stack: @state.stack, link: true}
      div {className: 'controls'},
        CardLink {card: @props.card, onClick: @showCard}

  showCard: ->
    @publish new UserOpenedPanelEvent(new CardPanelSpec(@props.card.id), {after: 'following'})

}

module.exports = FollowingCard

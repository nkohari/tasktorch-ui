#--------------------------------------------------------------------------------
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
#--------------------------------------------------------------------------------
require './FollowingCard.styl'
#--------------------------------------------------------------------------------

FollowingCard = React.createClass {

  displayName: 'FollowingCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

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
    @getScreen('workspace').addPanelAfter('following', new CardPanelState(@props.card.id))

}

module.exports = FollowingCard

_                = require 'lodash'
React            = require 'react'
ActionStatus     = require 'data/enums/ActionStatus'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
Navigator        = require 'ui/framework/mixins/Navigator'
CardPanelState   = require 'ui/screens/workspace/panels/card/CardPanelState'
Card             = React.createFactory(require 'ui/common/Card')
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
CardLink         = React.createFactory(require 'ui/common/CardLink')
CardLocation     = React.createFactory(require 'ui/common/CardLocation')
{div}            = React.DOM

GoalPanelCard = React.createClass {

  displayName: 'GoalPanelCard'

  propTypes:
    card: PropTypes.Card
    goal: PropTypes.Goal
    kind: PropTypes.Kind

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
  }

  render: ->

    Card {className: 'big-picture-card', card: @props.card},
      div {className: 'card-summary'},
        div {className: 'card-info'},
          div {className: 'title'}, @props.card.title or 'Untitled Card'
        div {className: 'controls'},
          CardFollowToggle {card: @props.card}
          CardLink {card: @props.card}

}

module.exports = GoalPanelCard

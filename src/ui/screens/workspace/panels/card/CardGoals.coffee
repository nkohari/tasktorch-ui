_                    = require 'lodash'
React                = require 'react'
classSet             = require 'common/util/classSet'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
Icon                 = React.createFactory(require 'ui/common/Icon')
OverlayTrigger       = React.createFactory(require 'ui/common/OverlayTrigger')
CardGoalsOverlay     = React.createFactory(require 'ui/screens/workspace/panels/card/CardGoalsOverlay')
{span}               = React.DOM

CardGoals = React.createClass {

  displayName: 'CardGoals'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) ->
    {goals: cache('goalsByCard').get(@props.card.id)}

  render: ->

    if @state.goals?.length > 0
      goals   = _.sortBy @state.goals, (goal) -> goal.name.toLowerCase()
      content = _.pluck(goals, 'name').join(', ')
    else
      content = 'Add to goal...'

    overlay = CardGoalsOverlay {card: @props.card, goals: @state.goals}

    classes = classSet [
      'goals'
      'card-widget'
      'empty' unless @state.goals?.length > 0
    ]

    OverlayTrigger {className: classes, overlay},
      span {},
        Icon {name: 'goal'}
        content

}

module.exports = CardGoals

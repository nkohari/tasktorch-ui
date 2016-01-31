#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
classSet             = require 'common/util/classSet'
PropTypes            = require 'ui/framework/PropTypes'
Icon                 = React.createFactory(require 'ui/common/Icon')
OverlayTrigger       = React.createFactory(require 'ui/common/OverlayTrigger')
CardGoalsOverlay     = React.createFactory(require 'ui/screens/workspace/panels/card/CardGoalsOverlay')
{span}               = React.DOM
#--------------------------------------------------------------------------------

CardGoals = React.createClass {

  displayName: 'CardGoals'

  propTypes:
    card:  PropTypes.Card
    goals: PropTypes.arrayOf(PropTypes.Goal)

  render: ->

    if @props.goals?.length > 0
      goals   = _.sortBy @props.goals, (goal) -> goal.name.toLowerCase()
      content = _.map(goals, 'name').join(', ')
    else
      content = 'Add to goal'

    overlay = CardGoalsOverlay {card: @props.card, goals: @props.goals}

    classes = classSet [
      'goals'
      'card-widget'
      'empty' unless @props.goals?.length > 0
    ]

    OverlayTrigger {className: classes, overlay},
      span {},
        Icon {name: 'goal'}
        content

}

module.exports = CardGoals

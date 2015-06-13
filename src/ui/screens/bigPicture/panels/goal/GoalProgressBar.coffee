_                  = require 'lodash'
React              = require 'react'
CardStatus         = require 'data/enums/CardStatus'
PropTypes          = require 'ui/framework/PropTypes'
ProgressBar        = React.createFactory(require 'ui/common/ProgressBar')
ProgressBarSegment = React.createFactory(require 'ui/common/ProgressBarSegment')
{div}              = React.DOM

GoalProgressBar = React.createClass {

  displayName: 'GoalProgressBar'

  propTypes:
    goal:  PropTypes.Goal
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    counts = _.extend {
      Complete:   0
      InProgress: 0
      Warning:    0
      NotStarted: 0
    }, _.countBy(@props.cards, 'status')

    if @props.cards?
      if @props.cards.length == 0
        pct = 0
      else
        pct = Math.floor(100 * (counts[CardStatus.Complete] / @props.cards.length))
      completion = "#{pct}% Complete"

    div {className: 'goal-progress'},
      div {className: 'completion'}, completion
      ProgressBar {},
        ProgressBarSegment {className: 'complete',   value: counts[CardStatus.Complete]}
        ProgressBarSegment {className: 'inprogress', value: counts[CardStatus.InProgress]}
        ProgressBarSegment {className: 'warning',    value: counts[CardStatus.Warning]}
        ProgressBarSegment {className: 'notstarted', value: counts[CardStatus.NotStarted]}

}

module.exports = GoalProgressBar

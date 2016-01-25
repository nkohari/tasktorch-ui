#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
CardStatus         = require 'data/enums/CardStatus'
PropTypes          = require 'ui/framework/PropTypes'
ProgressBar        = React.createFactory(require 'ui/common/ProgressBar')
ProgressBarSegment = React.createFactory(require 'ui/common/ProgressBarSegment')
{div, em}          = React.DOM
#--------------------------------------------------------------------------------
require './GoalProgressBar.styl'
#--------------------------------------------------------------------------------

GoalProgressBar = React.createClass {

  displayName: 'GoalProgressBar'

  propTypes:
    goal:  PropTypes.Goal
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    counts = _.extend {
      Complete:   0
      InProgress: 0
      Idle:       0
      Warning:    0
      NotStarted: 0
    }, _.countBy(@props.cards, 'status')

    if @props.cards?
      if @props.cards.length == 0
        pct = 0
      else
        pct = Math.floor(100 * (counts[CardStatus.Complete] / @props.cards.length))

    div {className: 'goal-progress-bar'},
      ProgressBar {total: @props.cards?.length or 0},
        ProgressBarSegment {className: 'complete',   value: counts[CardStatus.Complete]}   if counts[CardStatus.Complete] > 0
        ProgressBarSegment {className: 'inprogress', value: counts[CardStatus.InProgress]} if counts[CardStatus.InProgress] > 0
        ProgressBarSegment {className: 'idle',       value: counts[CardStatus.Idle]}       if counts[CardStatus.Idle] > 0
        ProgressBarSegment {className: 'warning',    value: counts[CardStatus.Warning]}    if counts[CardStatus.Warning] > 0
      div {className: 'completion'},
        em {}, "#{pct ? 0}%"
        " complete"

}

module.exports = GoalProgressBar

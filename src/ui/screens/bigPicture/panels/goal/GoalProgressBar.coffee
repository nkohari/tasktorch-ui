#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
CardStatus         = require 'data/enums/CardStatus'
PropTypes          = require 'ui/framework/PropTypes'
ProgressBar        = React.createFactory(require 'ui/common/ProgressBar')
ProgressBarSegment = React.createFactory(require 'ui/common/ProgressBarSegment')
{div}              = React.DOM
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
      Warning:    0
      NotStarted: 0
    }, _.countBy(@props.cards, 'status')

    if @props.cards?
      if @props.cards.length == 0
        pct = 0
      else
        pct = Math.floor(100 * (counts[CardStatus.Complete] / @props.cards.length))
      completion = "#{pct}% Complete"

    div {className: 'goal-progress-bar'},
      div {className: 'completion'}, completion
      ProgressBar {total: @props.cards?.length or 0},
        ProgressBarSegment {className: 'complete',   value: counts[CardStatus.Complete]}   if counts[CardStatus.Complete] > 0
        ProgressBarSegment {className: 'inprogress', value: counts[CardStatus.InProgress]} if counts[CardStatus.InProgress] > 0
        ProgressBarSegment {className: 'warning',    value: counts[CardStatus.Warning]}    if counts[CardStatus.Warning] > 0

}

module.exports = GoalProgressBar
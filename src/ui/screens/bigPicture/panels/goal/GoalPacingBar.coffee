#--------------------------------------------------------------------------------
_                  = require 'lodash'
moment             = require 'moment'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
ProgressBar        = React.createFactory(require 'ui/common/ProgressBar')
ProgressBarSegment = React.createFactory(require 'ui/common/ProgressBarSegment')
{div, em}          = React.DOM
#--------------------------------------------------------------------------------
require './GoalPacingBar.styl'
#--------------------------------------------------------------------------------

GoalPacingBar = React.createClass {

  displayName: 'GoalPacingBar'

  propTypes:
    goal: PropTypes.Goal

  render: ->

    {timeframe} = @props.goal

    today   = moment()
    start   = moment(timeframe.from)
    end     = moment(timeframe.to)
    total   = end.diff(start, 'days')
    left    = end.diff(today, 'days')
    elapsed = today.diff(start, 'days')

    div {className: 'goal-pacing-bar'},
      ProgressBar {total},
        ProgressBarSegment {className: 'elapsed', value: elapsed}
      div {className: 'completion'},
        em {}, left
        " days left"

}

module.exports = GoalPacingBar

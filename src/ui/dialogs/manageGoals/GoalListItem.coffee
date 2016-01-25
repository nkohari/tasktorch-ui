#--------------------------------------------------------------------------------
moment          = require 'moment'
React           = require 'react'
classSet        = require 'common/util/classSet'
dateTime        = require 'common/util/dateTime'
PropTypes       = require 'ui/framework/PropTypes'
DateRange       = React.createFactory(require 'ui/common/DateRange')
Icon            = React.createFactory(require 'ui/common/Icon')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
GoalContextMenu = React.createFactory(require 'ui/overlays/GoalContextMenu')
{li, div}       = React.DOM
#--------------------------------------------------------------------------------
require './GoalListItem.styl'
#--------------------------------------------------------------------------------

GoalListItem = React.createClass {

  displayEmail: 'GoalListItem'

  propTypes:
    goal: PropTypes.Goal

  render: ->

    if @props.goal.timeframe?
      from = dateTime.format(@props.goal.timeframe.from, "D MMM YYYY?")
      to   = dateTime.format(@props.goal.timeframe.to,   "D MMM YYYY?")
      timeframe = div {className: 'goal-timeframe'},
        "#{from} \u2013 #{to}"

    classes = classSet [
      'goal-list-item'
      @props.goal.status.toLowerCase()
    ]

    li {className: classes, onClick: @showContextMenu},
      div {className: 'goal-info'},
        div {className: 'goal-name'},
          Icon {name: 'goal'}
          @props.goal.name
        div {className: 'goal-description'},
          @props.goal.description
        timeframe

      OverlayTrigger {ref: 'trigger', overlay: GoalContextMenu {goalid: @props.goal.id}},
        Icon {name: 'trigger'}

  showContextMenu: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @refs.trigger.showOverlay()

}

module.exports = GoalListItem

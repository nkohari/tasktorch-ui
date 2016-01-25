#--------------------------------------------------------------------------------
moment                        = require 'moment'
React                         = require 'react'
compare                       = require 'common/util/compare'
UserChangedGoalTimeframeEvent = require 'events/ui/UserChangedGoalTimeframeEvent'
PropTypes                     = require 'ui/framework/PropTypes'
Actor                         = require 'ui/framework/mixins/Actor'
CachedState                   = require 'ui/framework/mixins/CachedState'
Button                        = React.createFactory(require 'ui/common/Button')
Dialog                        = React.createFactory(require 'ui/common/Dialog')
DialogFooter                  = React.createFactory(require 'ui/common/DialogFooter')
DateRangePicker               = React.createFactory(require 'ui/common/DateRangePicker')
{div}                         = React.DOM
#--------------------------------------------------------------------------------

ChangeGoalTimeframeDialog = React.createClass {

  displayName: 'ChangeGoalTimeframeDialog'

  props:
    goalid:      PropTypes.Goal
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    goal = cache('goals').get(@props.goalid)
    if goal? and not @state?
      if goal.timeframe?
        timeframe =
          from: new Date(goal.timeframe.from)
          to:   new Date(goal.timeframe.to)
      else
        timeframe =
          from: new Date()
          to:   moment().add(1, 'months').toDate()
    {timeframe, goal}

  componentDidMount: ->
    @refs.picker.focus()

  render: ->

    footer = DialogFooter {
      left: Button {text: 'Remove Timeframe', onClick: @removeTimeframe}
      right: [
        Button {text: 'Change Timeframe', onClick: @saveTimeframe}
        Button {text: 'Cancel',           onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'date', width: 630, title: "Change timeframe of #{@state.goal?.name}", footer, closeDialog: @props.closeDialog},
      DateRangePicker {ref: 'picker', from: @state.timeframe?.from, to: @state.timeframe?.to, onChange: @onTimeframeChanged}

  onTimeframeChanged: (timeframe) ->
    @setState {timeframe}

  saveTimeframe: ->
    unless compare.hashes(@state.timeframe, @state.goal.timeframe)
      @publish new UserChangedGoalTimeframeEvent(@props.goalid, @state.timeframe)
    @props.closeDialog()

  removeTimeframe: ->
    @publish new UserChangedGoalTimeframeEvent(@props.goalid, null)
    @props.closeDialog()

}

module.exports = ChangeGoalTimeframeDialog

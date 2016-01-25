#--------------------------------------------------------------------------------
React                      = require 'react'
GoalStatus                 = require 'data/enums/GoalStatus'
UserChangedGoalStatusEvent = require 'events/ui/UserChangedGoalStatusEvent'
PropTypes                  = require 'ui/framework/PropTypes'
Actor                      = require 'ui/framework/mixins/Actor'
CachedState                = require 'ui/framework/mixins/CachedState'
Button                     = React.createFactory(require 'ui/common/Button')
Dialog                     = React.createFactory(require 'ui/common/Dialog')
DialogFooter               = React.createFactory(require 'ui/common/DialogFooter')
Prompt                     = React.createFactory(require 'ui/common/Prompt')
#--------------------------------------------------------------------------------

ChangeGoalStatusDialog = React.createClass {

  displayName: 'ChangeGoalStatusDialog'

  propTypes:
    goalid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    goal: cache('goals').get(@props.goalid)
  }

  render: ->

    if @state.goal?.status == GoalStatus.Normal
      icon   = 'archive'
      prompt = Prompt {hint: 'archive-goal'}, 'Are you sure you want to archive this goal?'
      action = 'Archive'
    else
      icon   = 'restore'
      prompt = Prompt {hint: 'restore-goal'}, 'Are you sure you want to restore this goal?'
      action = 'Restore'

    footer = DialogFooter {
      right: [
        Button {text: "#{action} Goal", onClick: @changeGoalStatus}
        Button {text: 'Cancel',         onClick: @props.closeDialog}
      ]
    }

    Dialog {icon, title: "#{action} #{@state.goal?.name}", footer, closeDialog: @props.closeDialog},
      prompt

  changeGoalStatus: ->
    status = if @state.goal.status == GoalStatus.Normal then GoalStatus.Archived else GoalStatus.Normal
    @publish new UserChangedGoalStatusEvent(@props.goalid, status)
    @props.closeDialog()

}

module.exports = ChangeGoalStatusDialog

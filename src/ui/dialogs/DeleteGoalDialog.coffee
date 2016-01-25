#--------------------------------------------------------------------------------
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
UserDeletedGoalEvent = require 'events/ui/UserDeletedGoalEvent'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogFooter         = React.createFactory(require 'ui/common/DialogFooter')
Prompt               = React.createFactory(require 'ui/common/Prompt')
#--------------------------------------------------------------------------------

DeleteGoalDialog = React.createClass {

  displayName: 'DeleteGoalDialog'

  propTypes:
    goalid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    goal: cache('goals').get(@props.goalid)
  }

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Delete Goal', onClick: @deleteGoal, className: 'warning'}
        Button {text: 'Cancel',       onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'trash', title: "Delete #{@state.goal?.name}", footer, closeDialog: @props.closeDialog},
      Prompt {hint: 'delete-goal'},
        'Are you sure you want to delete this goal?'

  deleteGoal: ->
    @publish new UserDeletedGoalEvent(@props.goalid)
    @props.closeDialog()

}

module.exports = DeleteGoalDialog

#--------------------------------------------------------------------------------
React                 = require 'react'
GoalStatus            = require 'data/enums/GoalStatus'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
IdentityContext       = require 'ui/framework/mixins/IdentityContext'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogFooter          = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger         = React.createFactory(require 'ui/common/DialogTrigger')
OverlayTrigger        = React.createFactory(require 'ui/common/OverlayTrigger')
GoalListItem          = React.createFactory(require 'ui/dialogs/manageGoals/GoalListItem')
{ul, div}             = React.DOM
#--------------------------------------------------------------------------------
require './ManageGoalsDialog.styl'
#--------------------------------------------------------------------------------

ManageGoalsDialog = React.createClass {

  displayEmail: 'ManageGoalsDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState, IdentityContext]

  getCachedState: (cache) -> {
    goals: cache('goalsByOrg').get(@getCurrentOrg().id)
  }

  render: ->

    goals = _.groupBy @state.goals, (g) -> g.status

    footer = DialogFooter {
      left:  Button {text: 'Create new goal', onClick: @onCreateClicked}
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'goal', title: 'Manage Goals', className: 'manage-goals-dialog', width: 400, footer, closeDialog: @props.closeDialog},
      div {className: 'goal-list'},
        @renderGoalGroup(goals[GoalStatus.Normal], "Active")
        @renderGoalGroup(goals[GoalStatus.Archived], "Archived")

  renderGoalGroup: (goals, header) ->
    return unless goals?
    items = _.map goals, (goal) ->
      GoalListItem {key: goal.id, goal}      
    return div {className: 'group'},
      div {className: 'group-header'},
        "#{header} (#{goals.length})"
      ul {className: 'goal-group'}, items

  onCreateClicked: ->
    @publish new UserOpenedDialogEvent('CreateGoal')

}

module.exports = ManageGoalsDialog

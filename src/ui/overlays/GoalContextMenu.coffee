#--------------------------------------------------------------------------------
React                = require 'react'
GoalStatus           = require 'data/enums/GoalStatus'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
#--------------------------------------------------------------------------------

GoalContextMenu = React.createClass {

  displayName: 'GoalContextMenu'

  propTypes:
    goalid:      PropTypes.string
    hideOverlay: PropTypes.func

  mixins: [CachedState]

  getCachedState: (cache) -> {
    goal: cache('goals').get(@props.goalid)
  }

  render: ->

    if @state.goal?.status == GoalStatus.Normal
      toggle = [
        Icon {name: 'archive'}
        'Archive'
      ]
    else
      toggle = [
        Icon {name: 'restore'}
        'Restore'
      ]

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'RenameGoal', goalid: @props.goalid},
        Icon {name: 'edit'}
        'Rename'
      DialogTrigger {name: 'ChangeGoalDescription', goalid: @props.goalid},
        Icon {name: 'edit'}
        'Change description'
      DialogTrigger {name: 'ChangeGoalTimeframe', goalid: @props.goalid},
        Icon {name: 'date'}
        'Change timeframe'
      ContextMenuSeparator {}
      DialogTrigger {name: 'ChangeGoalStatus', goalid: @props.goalid},
        toggle
      DialogTrigger {name: 'DeleteGoal', goalid: @props.goalid},
        Icon {name: 'trash'}
        'Delete'

}

module.exports = GoalContextMenu

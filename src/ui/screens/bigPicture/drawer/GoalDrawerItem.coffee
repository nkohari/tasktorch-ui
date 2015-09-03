#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
GoalPanelState = require 'ui/screens/bigPicture/panels/goal/GoalPanelState'
DrawerItem     = React.createFactory(require 'ui/common/DrawerItem')
#--------------------------------------------------------------------------------

GoalDrawerItem = React.createClass {

  displayName: 'GoalDrawerItem'

  propTypes:
    goal: PropTypes.Goal

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'goal'
      'active' if @getScreen('bigpicture').isPanelVisible(@props.goal.id)
    ]

    DrawerItem {
      className: classes
      icon:      'goal'
      label:     @props.goal.name
      onClick:   @toggleGoal
    }    

  toggleGoal: ->
    @getScreen('bigpicture').togglePanel(new GoalPanelState(@props.goal.id))

}

module.exports = GoalDrawerItem

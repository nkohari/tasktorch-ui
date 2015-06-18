#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
GoalPanelState = require 'ui/screens/bigPicture/panels/goal/GoalPanelState'
Icon           = React.createFactory(require 'ui/common/Icon')
Link           = React.createFactory(require 'ui/common/Link')
ListItem       = React.createFactory(require 'ui/common/ListItem')
{span}         = React.DOM
#--------------------------------------------------------------------------------

GoalDrawerItem = React.createClass {

  displayName: 'GoalDrawerItem'

  propTypes:
    goal: PropTypes.Goal

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'drawer-item'
      'active' if @getScreen('bigpicture').isPanelVisible(@props.goal.id)
    ]

    Link {className: classes, onClick: @toggleGoal},
      Icon {name: 'goal'}
      span {className: 'name'}, @props.goal.name

  toggleGoal: ->
    @getScreen('bigpicture').togglePanel(new GoalPanelState(@props.goal.id))

}

module.exports = GoalDrawerItem

#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
DrawerSection  = React.createFactory(require 'ui/common/DrawerSection')
GoalDrawerItem = React.createFactory(require 'ui/screens/bigPicture/drawer/GoalDrawerItem')
#--------------------------------------------------------------------------------

GoalDrawerSection = React.createClass {

  displayName: 'GoalDrawerSection'

  propTypes:
    goals: PropTypes.arrayOf(PropTypes.Goal)

  render: ->

    items = _.map @props.goals, (goal) =>
      GoalDrawerItem {key: goal.id, goal}

    DrawerSection {className: 'goal-section', title: 'By Goal'},
      items

}

module.exports = GoalDrawerSection

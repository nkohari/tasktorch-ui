#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
GoalDrawerItem  = React.createFactory(require 'ui/screens/bigPicture/drawer/GoalDrawerItem')
{div, span, ul} = React.DOM
#--------------------------------------------------------------------------------

GoalList = React.createClass {

  displayName: 'GoalList'

  propTypes:
    goals: PropTypes.arrayOf(PropTypes.Goal)

  render: ->

    items = _.map @props.goals, (goal) =>
      GoalDrawerItem {key: goal.id, goal}

    div {className: 'drawer-group'},
      div {className: 'header'},
        span {className: 'title'}, 'By Goal'
      items

}

module.exports = GoalList

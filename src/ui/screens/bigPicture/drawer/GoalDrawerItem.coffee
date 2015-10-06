#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
classSet                = require 'common/util/classSet'
UserToggledPanelEvent   = require 'events/ui/UserToggledPanelEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ViewContext             = require 'ui/framework/mixins/ViewContext'
BigPictureGoalPanelSpec = require 'ui/framework/panels/BigPictureGoalPanelSpec'
DrawerItem              = React.createFactory(require 'ui/common/DrawerItem')
#--------------------------------------------------------------------------------

GoalDrawerItem = React.createClass {

  displayName: 'GoalDrawerItem'

  propTypes:
    goal: PropTypes.Goal

  mixins: [Actor, ViewContext]

  render: ->

    classes = classSet [
      'goal'
      'active' if @isPanelOpen(@props.goal.id)
    ]

    DrawerItem {
      className: classes
      icon:      'goal'
      label:     @props.goal.name
      onClick:   @toggleGoal
    }    

  toggleGoal: ->
    @publish new UserToggledPanelEvent(new BigPictureGoalPanelSpec(@props.goal.id))

}

module.exports = GoalDrawerItem

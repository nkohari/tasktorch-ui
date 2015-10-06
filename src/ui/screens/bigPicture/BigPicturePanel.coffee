#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
PropTypes               = require 'ui/framework/PropTypes'
BigPictureGoalPanelSpec = require 'ui/framework/panels/BigPictureGoalPanelSpec'
BigPictureKindPanelSpec = require 'ui/framework/panels/BigPictureKindPanelSpec'
BigPictureTeamPanelSpec = require 'ui/framework/panels/BigPictureTeamPanelSpec'
GoalPanel               = React.createFactory(require 'ui/screens/bigPicture/panels/goal/GoalPanel')
KindPanel               = React.createFactory(require 'ui/screens/bigPicture/panels/kind/KindPanel')
TeamPanel               = React.createFactory(require 'ui/screens/bigPicture/panels/team/TeamPanel')
#--------------------------------------------------------------------------------
require './BigPicturePanel.styl'
#--------------------------------------------------------------------------------

BigPicturePanel = React.createClass {

  displayName: 'BigPicturePanel'

  propTypes:
    spec: PropTypes.object

  render: ->

    if @props.spec instanceof BigPictureGoalPanelSpec
      GoalPanel(@props.spec)
    else if @props.spec instanceof BigPictureKindPanelSpec
      KindPanel(@props.spec)
    else if @props.spec instanceof BigPictureTeamPanelSpec
      TeamPanel(@props.spec)
    else
      throw new Error("Unknown panel spec #{@props.spec.constructor.name}")

}

module.exports = BigPicturePanel

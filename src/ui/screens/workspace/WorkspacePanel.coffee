#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CardPanelSpec      = require 'ui/framework/panels/CardPanelSpec'
FollowingPanelSpec = require 'ui/framework/panels/FollowingPanelSpec'
StackPanelSpec     = require 'ui/framework/panels/StackPanelSpec'
UserPanelSpec      = require 'ui/framework/panels/UserPanelSpec'
CardPanel          = React.createFactory(require 'ui/screens/workspace/panels/card/CardPanel')
FollowingPanel     = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingPanel')
StackPanel         = React.createFactory(require 'ui/screens/workspace/panels/stack/StackPanel')
UserPanel          = React.createFactory(require 'ui/screens/workspace/panels/user/UserPanel')
#--------------------------------------------------------------------------------

WorkspacePanel = React.createClass {

  displayName: 'WorkspacePanel'

  propTypes:
    spec: PropTypes.object

  childContextTypes:
    currentPanel: PropTypes.object

  getChildContext: ->
    {currentPanel: @props.spec}

  render: ->

    if @props.spec instanceof CardPanelSpec
      CardPanel(@props.spec)
    else if @props.spec instanceof FollowingPanelSpec
      FollowingPanel(@props.spec)
    else if @props.spec instanceof StackPanelSpec
      StackPanel(@props.spec)
    else if @props.spec instanceof UserPanelSpec
      UserPanel(@props.spec)
    else
      throw new Error("Unknown panel spec #{@props.spec.constructor.name}")

}

module.exports = WorkspacePanel

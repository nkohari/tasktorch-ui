#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
ViewContext        = require 'ui/framework/mixins/ViewContext'
IdentityContext    = require 'ui/framework/mixins/IdentityContext'
Screen             = React.createFactory(require 'ui/common/Screen')
WorkspacePanelList = React.createFactory(require 'ui/screens/workspace/WorkspacePanelList')
WorkspaceDrawer    = React.createFactory(require 'ui/screens/workspace/drawer/WorkspaceDrawer')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------
require './WorkspaceScreen.styl'
#--------------------------------------------------------------------------------

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  mixins: [ViewContext, IdentityContext]

  componentDidMount: ->
    document.title = "TaskTorch | Workspace | #{@getCurrentOrg().name}"

  render: ->

    Screen {className: 'workspace'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        WorkspaceDrawer {} if @isDrawerOpen()
      WorkspacePanelList {panels: @getOpenPanels()}

}

module.exports = WorkspaceScreen

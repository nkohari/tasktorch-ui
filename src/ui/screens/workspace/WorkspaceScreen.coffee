_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
Frame              = React.createFactory(require 'ui/common/Frame')
WorkspacePanelList = React.createFactory(require 'ui/screens/workspace/WorkspacePanelList')
WorkspaceDrawer    = React.createFactory(require 'ui/screens/workspace/drawer/WorkspaceDrawer')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User
    drawer:      PropTypes.bool
    panels:      PropTypes.array

  render: ->

    Frame {className: 'workspace screen'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        WorkspaceDrawer {currentOrg: @props.currentOrg, currentUser: @props.currentUser} if @props.drawer
      WorkspacePanelList {currentOrg: @props.currentOrg, currentUser: @props.currentUser, panels: @props.panels}

}

module.exports = WorkspaceScreen

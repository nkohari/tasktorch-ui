_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
Frame              = React.createFactory(require 'ui/common/Frame')
WorkspacePanelList = React.createFactory(require 'ui/screens/workspace/WorkspacePanelList')
WorkspaceSidebar   = React.createFactory(require 'ui/screens/workspace/sidebar/WorkspaceSidebar')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User
    sidebar:     PropTypes.bool
    panels:      PropTypes.array

  render: ->

    Frame {className: 'workspace screen'},
      CSSTransitionGroup {component: 'div', className: 'sidebar-container', transitionName: 'slide'},
        WorkspaceSidebar {currentOrg: @props.currentOrg, currentUser: @props.currentUser} if @props.sidebar
      WorkspacePanelList {currentOrg: @props.currentOrg, currentUser: @props.currentUser, panels: @props.panels}

}

module.exports = WorkspaceScreen

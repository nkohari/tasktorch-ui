_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
LoadAllKindsRequest = require 'requests/LoadAllKindsRequest'
Frame               = React.createFactory(require 'ui/common/Frame')
WorkspacePanelList  = React.createFactory(require 'ui/screens/workspace/WorkspacePanelList')
WorkspaceSidebar    = React.createFactory(require 'ui/screens/workspace/sidebar/WorkspaceSidebar')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User
    sidebar:     PropTypes.bool

  mixins: [Observe()]

  componentDidMount: ->
    @execute new LoadAllKindsRequest()

  isReady: ->
    @props.currentUser? and @props.currentOrg?

  render: ->

    Frame {@isReady, className: 'screen'},
      CSSTransitionGroup {component: 'div', className: 'sidebar-container', transitionName: 'slide'},
        WorkspaceSidebar {currentOrg: @props.currentOrg, currentUser: @props.currentUser} if @props.sidebar
      WorkspacePanelList {}

}

module.exports = WorkspaceScreen

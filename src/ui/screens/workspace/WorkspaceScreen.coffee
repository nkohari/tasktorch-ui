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
    sidebar: PropTypes.bool

  mixins: [Observe()]

  componentDidMount: ->
    @execute new LoadAllKindsRequest()

  render: ->

    Frame {className: 'workspace screen'},
      CSSTransitionGroup {component: 'div', transitionName: 'slide'},
        WorkspaceSidebar {} if @props.sidebar
      WorkspacePanelList {}

}

module.exports = WorkspaceScreen

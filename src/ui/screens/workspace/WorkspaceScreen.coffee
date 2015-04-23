_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
ShellContext       = require 'ui/framework/mixins/ShellContext'
Frame              = React.createFactory(require 'ui/common/Frame')
WorkspacePanelList = React.createFactory(require 'ui/screens/workspace/WorkspacePanelList')
WorkspaceDrawer    = React.createFactory(require 'ui/screens/workspace/drawer/WorkspaceDrawer')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  propTypes:
    drawer: PropTypes.bool
    panels: PropTypes.array

  mixins: [ShellContext]

  componentDidMount: ->
    org = @getCurrentOrg()
    document.title = "TaskTorch \u2014 #{org.name} \u2014 Workspace"

  render: ->

    Frame {className: 'workspace screen'},
      CSSTransitionGroup {component: 'div', className: 'drawer-container', transitionName: 'slide'},
        WorkspaceDrawer {} if @props.drawer
      WorkspacePanelList {panels: @props.panels}

}

module.exports = WorkspaceScreen

_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
LoadAllKindsRequest = require 'requests/LoadAllKindsRequest'
WorkspacePanelList  = React.createFactory(require './WorkspacePanelList')
WorkspaceSidebar    = React.createFactory(require 'ui/screens/workspace/sidebar/WorkspaceSidebar')
{div}               = React.DOM

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  propTypes:
    sidebarVisible: PropTypes.bool

  mixins: [Observe()]

  componentDidMount: ->
    @execute new LoadAllKindsRequest()

  render: ->
    div {className: 'workspace screen'}, [
      WorkspaceSidebar {key: 'sidebar'} if @props.sidebarVisible
      WorkspacePanelList {key: 'panels'}
    ]

}

module.exports = WorkspaceScreen

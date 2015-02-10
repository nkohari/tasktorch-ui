_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
Observe             = require 'mixins/Observe'
LoadAllKindsRequest = require 'requests/LoadAllKindsRequest'
WorkspacePanelList  = React.createFactory(require './WorkspacePanelList')
WorkspaceSidebar    = React.createFactory(require './components/sidebar/WorkspaceSidebar')
{div}               = React.DOM

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  propTypes:
    sidebarVisible: PropTypes.bool

  mixins: [Observe()]

  componentWillMount: ->
    @execute new LoadAllKindsRequest()

  render: ->
    div {className: 'workspace screen'}, [
      WorkspaceSidebar {key: 'sidebar'} if @props.sidebarVisible
      WorkspacePanelList {key: 'panels'}
    ]

}

module.exports = WorkspaceScreen

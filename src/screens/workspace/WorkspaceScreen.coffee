_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
LoadAllKindsRequest = require 'requests/LoadAllKindsRequest'
Modal               = React.createFactory(require 'common/Modal')
WorkspacePanelList  = React.createFactory(require './WorkspacePanelList')
WorkspaceSidebar    = React.createFactory(require './components/sidebar/WorkspaceSidebar')
{div}               = React.DOM

WorkspaceScreen = React.createClass {

  displayName: 'WorkspaceScreen'

  mixins: [Observe()]

  componentWillMount: ->
    @execute new LoadAllKindsRequest()

  render: ->
    div {className: 'workspace screen'}, [
      WorkspaceSidebar {key: 'sidebar'}
      WorkspacePanelList {key: 'panels'}
    ]

}

module.exports = WorkspaceScreen

React                      = require 'react'
Router                     = require 'react-router'
Observe                    = require 'mixins/Observe'
JoinPresenceChannelRequest = require 'requests/JoinPresenceChannelRequest'
JoinUserChannelRequest     = require 'requests/JoinUserChannelRequest'
LoadCurrentUserRequest     = require 'requests/LoadCurrentUserRequest'
LoadMyOrgsRequest          = require 'requests/LoadMyOrgsRequest'
Frame                      = React.createFactory(require 'common/Frame')
ShellHeader                = React.createFactory(require './components/ShellHeader')
RouteHandler               = React.createFactory(Router.RouteHandler)
{div}                      = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    Router.State
    Observe('connectedUsers', 'orgs', 'users')
  ]

  getInitialState: ->
    {sidebarVisible: true}

  sync: (stores) ->
    return {
      connectedUsers: stores.connectedUsers.getAll()
      currentUser:    stores.users.getCurrentUser()
      currentOrg:     stores.orgs.get(@getParams().orgid)
      orgs:           stores.orgs.getAll()
    }

  componentWillMount: ->
    AppContext.orgid = @getParams().orgid
    @execute new JoinPresenceChannelRequest()
    @execute new JoinUserChannelRequest()
    @execute new LoadCurrentUserRequest()
    @execute new LoadMyOrgsRequest()

  isReady: ->
    @state.currentUser? and @state.currentOrg?

  render: ->
    Frame {@isReady, className: 'shell'}, [
      ShellHeader  {key: 'header', currentOrg: @state.currentOrg, currentUser: @state.currentUser, @toggleSidebar}
      RouteHandler {key: 'screen', sidebarVisible: @state.sidebarVisible}
    ]

  toggleSidebar: ->
    @setState {sidebarVisible: !@state.sidebarVisible}
    
}

module.exports = Shell

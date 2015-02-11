React                      = require 'react'
Router                     = require 'react-router'
Observe                    = require 'framework/mixins/Observe'
Url                        = require 'framework/Url'
JoinPresenceChannelRequest = require 'requests/JoinPresenceChannelRequest'
JoinUserChannelRequest     = require 'requests/JoinUserChannelRequest'
LoadCurrentUserRequest     = require 'requests/LoadCurrentUserRequest'
LoadMyOrgsRequest          = require 'requests/LoadMyOrgsRequest'
Frame                      = React.createFactory(require 'ui/common/Frame')
ShellHeader                = React.createFactory(require 'ui/shell/ShellHeader')
RouteHandler               = React.createFactory(Router.RouteHandler)

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    Router.State
    Observe('connectedUsers', 'orgs', 'users')
  ]

  componentDidMount: ->
    AppContext.orgid = @getParams().orgid
    @execute new JoinPresenceChannelRequest()
    @execute new JoinUserChannelRequest()
    @execute new LoadCurrentUserRequest()
    @execute new LoadMyOrgsRequest()

  sync: (stores) ->
    return {
      connectedUsers: stores.connectedUsers.getAll()
      currentUser:    stores.users.getCurrentUser()
      currentOrg:     stores.orgs.get(@getParams().orgid)
      orgs:           stores.orgs.getAll()
    }

  isReady: ->
    @state.currentUser? and @state.currentOrg?

  render: ->
    
    url = new Url(this)
    Frame {@isReady, className: 'shell'},
      ShellHeader  {currentOrg: @state.currentOrg, currentUser: @state.currentUser}
      RouteHandler {sidebar: url.sidebar}
    
}

module.exports = Shell

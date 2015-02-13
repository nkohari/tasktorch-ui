React                      = require 'react/addons'
Router                     = require 'react-router'
Observe                    = require 'framework/mixins/Observe'
Url                        = require 'framework/Url'
JoinPresenceChannelRequest = require 'requests/JoinPresenceChannelRequest'
JoinUserChannelRequest     = require 'requests/JoinUserChannelRequest'
LoadCurrentUserRequest     = require 'requests/LoadCurrentUserRequest'
LoadMyOrgsRequest          = require 'requests/LoadMyOrgsRequest'
Frame                      = React.createFactory(require 'ui/common/Frame')
ShellHeader                = React.createFactory(require 'ui/shell/header/ShellHeader')
ShellFooter                = React.createFactory(require 'ui/shell/footer/ShellFooter')
RouteHandler               = React.createFactory(Router.RouteHandler)
CSSTransitionGroup         = React.createFactory(React.addons.CSSTransitionGroup)

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
      CSSTransitionGroup {component: 'div', className: 'shell-main', transitionName: 'navigate'},
        RouteHandler {key: url.screen, currentOrg: @state.currentOrg, currentUser: @state.currentUser, sidebar: url.sidebar}
      ShellFooter  {currentOrg: @state.currentOrg, currentUser: @state.currentUser}
    
}

module.exports = Shell

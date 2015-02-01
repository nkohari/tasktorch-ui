React                      = require 'react/addons'
Observe                    = require 'mixins/Observe'
JoinPresenceChannelRequest = require 'requests/JoinPresenceChannelRequest'
JoinUserChannelRequest     = require 'requests/JoinUserChannelRequest'
LoadCurrentUserRequest     = require 'requests/LoadCurrentUserRequest'
LoadMyOrgsRequest          = require 'requests/LoadMyOrgsRequest'
TopCorner                  = React.createFactory(require './components/TopCorner')
BottomCorner               = React.createFactory(require './components/BottomCorner')
CSSTransitionGroup         = React.createFactory(React.addons.CSSTransitionGroup)
{div}                      = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    Observe('connectedUsers', 'orgs', 'users')
  ]

  sync: (stores) ->
    return {
      connectedUsers: stores.connectedUsers.getAll()
      currentUser:    stores.users.getCurrentUser()
      currentOrg:     stores.orgs.get(@props.params.orgId)
      orgs:           stores.orgs.getAll()
    }

  componentWillMount: ->
    AppContext.orgId = @props.params.orgId
    @execute new JoinPresenceChannelRequest()
    @execute new JoinUserChannelRequest()
    @execute new LoadCurrentUserRequest()
    @execute new LoadMyOrgsRequest()

  isReady: ->
    @state.currentUser? and @state.currentOrg?

  render: ->

    unless @isReady()
      return div {className: 'loading'}, []

    Screen = @props.activeRouteHandler
    div {className: 'shell'}, [
      TopCorner {key: 'top-corner', currentOrg: @state.currentOrg, currentUser: @state.currentUser, orgs: @state.orgs, connectedUsers: @state.connectedUsers}
      Screen {key: 'screen'}
      BottomCorner {key: 'bottom-corner'}
    ]
    
}

module.exports = Shell

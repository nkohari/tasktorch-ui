React                      = require 'react/addons'
Observe                    = require 'mixins/Observe'
JoinPresenceChannelRequest = require 'requests/JoinPresenceChannelRequest'
LoadCurrentUserRequest     = require 'requests/LoadCurrentUserRequest'
LoadMyOrganizationsRequest = require 'requests/LoadMyOrganizationsRequest'
TopCorner                  = React.createFactory(require './components/TopCorner')
BottomCorner               = React.createFactory(require './components/BottomCorner')
CSSTransitionGroup         = React.createFactory(React.addons.CSSTransitionGroup)
{div}                      = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    Observe('connectedUsers', 'organizations', 'users')
  ]

  sync: (stores) ->
    return {
      connectedUsers:      stores.connectedUsers.getAll()
      currentUser:         stores.users.getCurrentUser()
      currentOrganization: stores.organizations.get(@props.params.organizationId)
      organizations:       stores.organizations.getAll()
    }

  componentWillMount: ->
    AppContext.organizationId = @props.params.organizationId
    @execute new JoinPresenceChannelRequest()
    @execute new LoadCurrentUserRequest()
    @execute new LoadMyOrganizationsRequest()

  isReady: ->
    @state.currentUser? and @state.currentOrganization?

  render: ->

    unless @isReady()
      return div {className: 'loading'}, []

    Screen = @props.activeRouteHandler
    div {className: 'shell'}, [
      TopCorner {key: 'top-corner', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser, organizations: @state.organizations, connectedUsers: @state.connectedUsers}
      Screen {key: 'screen'}
      BottomCorner {key: 'bottom-corner'}
    ]
    
}

module.exports = Shell

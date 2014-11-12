React                      = require 'react/addons'
Observe                    = require 'mixins/Observe'
JoinPresenceChannelRequest = require 'requests/JoinPresenceChannelRequest'
LoadCurrentUserRequest     = require 'requests/LoadCurrentUserRequest'
LoadMyOrganizationsRequest = require 'requests/LoadMyOrganizationsRequest'
ShellHeader                = React.createFactory(require './components/ShellHeader')
{div}                      = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    Observe('organizations', 'presence')
  ]

  getStateFromStores: (stores) ->
    return {
      currentUser:         stores.presence.currentUser
      currentOrganization: stores.organizations.getOrganization(@props.params.organizationId)
      organizations:       stores.organizations.getAllOrganizations()
      connectedUsers:      stores.presence.getConnectedUsers()
    }

  componentWillMount: ->
    @execute new JoinPresenceChannelRequest()
    @execute new LoadCurrentUserRequest()
    @execute new LoadMyOrganizationsRequest()

  render: ->

    unless @state.currentUser? and @state.currentOrganization?
      return div {className: 'shell loading'}, []

    Screen = @props.activeRouteHandler
    div {className: 'shell'}, [
      ShellHeader {key: 'header', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser, organizations: @state.organizations, connectedUsers: @state.connectedUsers}
      Screen {key: 'screen'}
    ]

}

module.exports = Shell

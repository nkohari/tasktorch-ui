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

  isReady: ->
    @state.currentUser? and @state.currentOrganization?

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'shell'}, children

  renderChildren: ->
    Screen = @props.activeRouteHandler
    return [
      TopCorner {key: 'top-corner', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser, organizations: @state.organizations, connectedUsers: @state.connectedUsers}
      Screen {key: 'screen'}
      BottomCorner {key: 'bottom-corner'}
    ]
    
}

module.exports = Shell

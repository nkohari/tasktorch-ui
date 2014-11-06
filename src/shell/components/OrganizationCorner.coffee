React          = require 'react'
Flux           = require '../../mixins/Flux'
MenuTrigger    = React.createFactory(require '../../common/MenuTrigger')
PresenceWidget = React.createFactory(require './PresenceWidget')
{div}          = React.DOM

OrganizationCorner = React.createClass {

  displayName: 'OrganizationCorner'

  mixins: [
    Flux('organizations', 'presence')
  ]

  getStateFromStores: (stores) ->
    return {
      organizations:  stores.organizations.getAllOrganizations()
      connectedUsers: stores.presence.getConnectedUsers()
    }

  render: ->

    unless @props.currentOrganization?
      return div {className: 'organization loading'}

    div {className: 'organization-corner'}, [
      div {key: 'organization'}, [
        div {key: 'name', className: 'organization-name'}, [@props.currentOrganization.name]
        MenuTrigger {key: 'trigger'}
      ]
      div {key: 'widgets', className: 'widgets'}, [
        PresenceWidget {key: 'presence', connectedUsers: @state.connectedUsers}
      ]
    ]

}

module.exports = OrganizationCorner

React          = require 'react'
MenuTrigger    = React.createFactory(require 'common/MenuTrigger')
PresenceWidget = React.createFactory(require './PresenceWidget')
{div}          = React.DOM

OrganizationCorner = React.createClass {

  displayName: 'OrganizationCorner'

  render: ->

    unless @props.currentOrganization?
      return div {className: 'organization loading'}

    div {className: 'organization-corner'}, [
      div {key: 'organization'}, [
        div {key: 'name', className: 'organization-name'}, [@props.currentOrganization.name]
        MenuTrigger {key: 'trigger'}
      ]
      div {key: 'widgets', className: 'widgets'}, [
        PresenceWidget {key: 'presence', connectedUsers: @props.connectedUsers}
      ]
    ]

}

module.exports = OrganizationCorner

React              = require 'react'
Observe            = require 'mixins/Observe'
OrganizationCorner = React.createFactory(require './OrganizationCorner')
NavigationMenu     = React.createFactory(require './NavigationMenu')
UserCorner         = React.createFactory(require './UserCorner')
{div}              = React.DOM

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  mixins: [Observe()]

  render: ->
    div {className: 'shell-header'}, [
      OrganizationCorner {key: 'organization', currentOrganization: @props.currentOrganization, organizations: @props.organizations, connectedUsers: @props.connectedUsers}
      div {key: 'header-bar', className: 'header-bar'}, [
        NavigationMenu {key: 'navigation'}
        UserCorner {key: 'user', currentUser: @props.currentUser}
      ]
    ]

}

module.exports = ShellHeader

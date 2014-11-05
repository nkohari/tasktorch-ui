React              = require 'react'
Flux               = require '../../mixins/Flux'
OrganizationCorner = React.createFactory(require './OrganizationCorner')
NavigationMenu     = React.createFactory(require './NavigationMenu')
UserCorner         = React.createFactory(require './UserCorner')
{div}              = React.DOM

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  mixins: [Flux()]

  render: ->
    div {className: 'shell-header'}, [
      OrganizationCorner {key: 'organization', currentOrganization: @props.currentOrganization}
      div {className: 'header-bar'}, [
        NavigationMenu {key: 'navigation'}
        UserCorner {key: 'user', currentUser: @props.currentUser}
      ]
    ]

}

module.exports = ShellHeader

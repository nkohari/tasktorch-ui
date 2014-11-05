React              = require 'react'
Flux               = require '../../mixins/Flux'
OrganizationWidget = React.createFactory(require './OrganizationWidget')
NavigationWidget   = React.createFactory(require './NavigationWidget')
UserWidget         = React.createFactory(require './UserWidget')
{div}              = React.DOM

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  mixins: [Flux()]

  render: ->
    div {className: 'shell-header'}, [
      OrganizationWidget {key: 'organization', currentOrganization: @props.currentOrganization}
      div {className: 'header-bar'}, [
        NavigationWidget {key: 'navigation'}
        UserWidget {key: 'user', currentUser: @props.currentUser}
      ]
    ]

}

module.exports = ShellHeader

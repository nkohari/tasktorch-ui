React              = require 'react'
OrganizationWidget = React.createFactory(require './OrganizationWidget')
NavigationWidget   = React.createFactory(require './NavigationWidget')
UserWidget         = React.createFactory(require './UserWidget')
{div}              = React.DOM

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  render: ->
    div {className: 'shell-header'}, [
      OrganizationWidget {key: 'organization-widget', organization: @props.currentOrganization}
      NavigationWidget {key: 'navigation-widget'}
      UserWidget {key: 'user-widget', user: @props.currentUser}
    ]

}

module.exports = ShellHeader

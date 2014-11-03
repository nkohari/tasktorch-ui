React              = require 'react'
OrganizationWidget = React.createFactory(require './OrganizationWidget')
NavigationWidget   = React.createFactory(require './NavigationWidget')
UserWidget         = React.createFactory(require './UserWidget')
{div}              = React.DOM

HeaderBar = React.createClass {

  displayName: 'HeaderBar'

  render: ->
    div {className: 'screen-header'}, [
      OrganizationWidget {key: 'organization-widget', organization: @props.currentOrganization}
      NavigationWidget {key: 'navigation-widget'}
      UserWidget {key: 'user-widget', user: @props.currentUser}
    ]

}

module.exports = HeaderBar

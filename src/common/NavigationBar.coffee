React                = require 'react'
OrganizationSelector = React.createFactory(require './OrganizationSelector')
UserWidget           = React.createFactory(require './UserWidget')
{div}                = React.DOM

NavigationBar = React.createClass {

  displayName: 'NavigationBar'

  render: ->
    div {className: 'navigation'}, [
      OrganizationSelector {key: 'organization-selector', organization: @props.currentOrganization}
      UserWidget {key: 'user-widget', user: @props.currentUser}
    ]

}

module.exports = NavigationBar

React                = require 'react'
OrganizationSelector = require './OrganizationSelector'
UserWidget           = require './UserWidget'
{div}                = React.DOM

NavigationBar = React.createClass {

  render: ->
    div {className: 'navigation'}, [
      OrganizationSelector {organization: @props.currentOrganization}
      UserWidget {user: @props.currentUser}
    ]

}

module.exports = NavigationBar

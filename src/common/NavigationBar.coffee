React = require 'react'
OrganizationSelector = require './OrganizationSelector'
UserWidget = require './UserWidget'
{div} = React.DOM

NavigationBar = React.createClass {

  render: ->
    div {className: 'navigation'}, [
      OrganizationSelector {organization: @props.organization}
      UserWidget {user: @props.user}
    ]

}

module.exports = NavigationBar

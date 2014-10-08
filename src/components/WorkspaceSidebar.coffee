_                    = require 'lodash'
React                = require 'react'
Panel                = require './Panel'
StackList            = require './StackList'
OrganizationSelector = require './OrganizationSelector'
UserWidget           = require './UserWidget'
{div}                = React.DOM

WorkspaceSidebar = React.createClass {

  render: ->
    console.log(@props)

    unless @props.organization?
      return div {className: 'workspace sidebar loading'}, []

    div {className: 'workspace sidebar'}, [
      OrganizationSelector {organization: @props.organization}
      StackList {stacks: @props.stacks, teams: @props.teams, openStacks: @props.openStacks}
      UserWidget {user: @props.user}
    ]

}

module.exports = WorkspaceSidebar

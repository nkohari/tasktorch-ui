_                    = require 'lodash'
React                = require 'react'
Panel                = require '../common/Panel'
OrganizationSelector = require '../common/OrganizationSelector'
UserWidget           = require '../common/UserWidget'
StackList            = require './StackList'
{div}                = React.DOM

WorkspaceSidebar = React.createClass {

  render: ->

    unless @props.organization?
      return div {className: 'workspace sidebar loading'}, []

    div {className: 'workspace sidebar'}, [
      OrganizationSelector {organization: @props.organization}
      StackList {stacks: @props.stacks, teams: @props.teams}
      UserWidget {user: @props.user}
    ]

}

module.exports = WorkspaceSidebar

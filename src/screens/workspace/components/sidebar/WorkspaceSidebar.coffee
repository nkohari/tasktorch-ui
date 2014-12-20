_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
LoadMyStacksRequest = require 'requests/LoadMyStacksRequest'
LoadMyTeamsRequest  = require 'requests/LoadMyTeamsRequest'
NavigationMenu      = React.createFactory(require 'common/NavigationMenu')
CreateCardButton    = React.createFactory(require './CreateCardButton')
MyStackList         = React.createFactory(require './MyStackList')
TeamStackList       = React.createFactory(require './TeamStackList')
{div, ul}           = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Observe('teams', 'stacks', 'users')]

  getStateFromStores: (stores) ->
    currentUser = stores.users.getCurrentUser()
    if currentUser?
      teams = stores.teams.getAllByMember(currentUser.id)
      stacks = stores.stacks.getAllByOwner(currentUser.id)
    {currentUser, teams, stacks}

  componentWillMount: ->
    @execute new LoadMyStacksRequest()
    @execute new LoadMyTeamsRequest()

  isReady: ->
    @state.teams? and @state.stacks?

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'workspace sidebar'}, children

  renderChildren: ->

    groups = [
      MyStackList {key: 'me', stacks: @state.stacks}
    ].concat _.map @state.teams, (team) =>
      TeamStackList {key: "team-#{team.id}", team}

    return [
      NavigationMenu {key: 'navigation'}
      CreateCardButton {key: 'create-card-button'}
      div {key: 'menu', className: 'menu'}, groups
    ]

}

module.exports = WorkspaceSidebar

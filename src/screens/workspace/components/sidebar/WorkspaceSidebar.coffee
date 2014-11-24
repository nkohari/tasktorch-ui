_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
LoadMyStacksRequest = require 'requests/LoadMyStacksRequest'
LoadMyTeamsRequest  = require 'requests/LoadMyTeamsRequest'
Navigation          = React.createFactory(require 'common/Navigation')
MyStackList         = React.createFactory(require './MyStackList')
TeamStackList       = React.createFactory(require './TeamStackList')
{div, ul}           = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Observe('teams', 'stacks', 'users')]

  getStateFromStores: (stores) ->
    currentUser = stores.users.getCurrentUser()
    if currentUser?
      teams = stores.teams.getTeamsByMember(currentUser.id)
      stacks = stores.stacks.getStacksByOwner(currentUser.id)
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

    teams = _.map @state.teams, (team) =>
      TeamStackList {key: "team-#{team.id}", team}

    return [
      Navigation {key: 'navigation'}
      MyStackList {key: 'me', stacks: @state.stacks}
    ].concat(teams)

}

module.exports = WorkspaceSidebar

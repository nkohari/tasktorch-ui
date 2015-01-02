_                      = require 'lodash'
React                  = require 'react'
Observe                = require 'mixins/Observe'
MyStacksDisplayedEvent = require 'events/display/MyStacksDisplayedEvent'
MyTeamsDisplayedEvent  = require 'events/display/MyTeamsDisplayedEvent'
NavigationMenu         = React.createFactory(require 'common/NavigationMenu')
CreateCardButton       = React.createFactory(require './CreateCardButton')
MyStackList            = React.createFactory(require './MyStackList')
TeamStackList          = React.createFactory(require './TeamStackList')
{div, ul}              = React.DOM

WorkspaceSidebar = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'WorkspaceSidebar'

  mixins: [Observe('teams', 'stacks', 'users')]

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new MyStacksDisplayedEvent()
    @publish new MyTeamsDisplayedEvent()

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    currentUser = stores.users.getCurrentUser()
    if currentUser?
      teams = stores.teams.getAllByMember(currentUser.id)
      stacks = stores.stacks.getAllByUser(currentUser.id)
    {currentUser, teams, stacks}

  ready: ->
    return {
      teams:  @state.teams?
      stacks: @state.stacks?
    }

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'workspace sidebar'}, @contents()

  children: ->

    groups = [
      MyStackList {key: 'me', stacks: @state.stacks}
    ].concat _.map @state.teams, (team) =>
      TeamStackList {key: "team-#{team.id}", team}

    return [
      NavigationMenu {key: 'navigation'}
      CreateCardButton {key: 'create-card-button'}
      div {key: 'menu', className: 'menu'}, groups
    ]

  #--------------------------------------------------------------------------------
}

module.exports = WorkspaceSidebar

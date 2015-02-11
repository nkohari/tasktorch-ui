_                      = require 'lodash'
React                  = require 'react'
Observe                = require 'framework/mixins/Observe'
MyStacksDisplayedEvent = require 'events/display/MyStacksDisplayedEvent'
MyTeamsDisplayedEvent  = require 'events/display/MyTeamsDisplayedEvent'
Frame                  = React.createFactory(require 'ui/common/Frame')
CreateCardButton       = React.createFactory(require 'ui/screens/workspace/sidebar/CreateCardButton')
MyStackList            = React.createFactory(require 'ui/screens/workspace/sidebar/MyStackList')
TeamStackList          = React.createFactory(require 'ui/screens/workspace/sidebar/TeamStackList')
{div, ul}              = React.DOM

WorkspaceSidebar = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'WorkspaceSidebar'

  mixins: [Observe('teams', 'stacks', 'users')]

  # Lifecycle ---------------------------------------------------------------------

  componentDidMount: ->
    @publish new MyStacksDisplayedEvent()
    @publish new MyTeamsDisplayedEvent()

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    currentUser = stores.users.getCurrentUser()
    if currentUser?
      teams = stores.teams.getAllByMember(currentUser.id)
      stacks = stores.stacks.getAllByUser(currentUser.id)
    {currentUser, teams, stacks}

  isReady: ->
    @state.teams? and @state.stacks?.length > 0

  # Rendering ---------------------------------------------------------------------

  render: ->

    myStacks = MyStackList {key: 'me', stacks: @state.stacks}
    teamStacks = _.map @state.teams, (team) =>
      TeamStackList {key: "team-#{team.id}", team}

    Frame {@isReady, className: 'workspace sidebar'}, [myStacks].concat(teamStacks)

  #--------------------------------------------------------------------------------
}

module.exports = WorkspaceSidebar

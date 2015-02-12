_                      = require 'lodash'
React                  = require 'react'
Observe                = require 'framework/mixins/Observe'
PropTypes              = require 'framework/PropTypes'
MyStacksDisplayedEvent = require 'events/display/MyStacksDisplayedEvent'
MyTeamsDisplayedEvent  = require 'events/display/MyTeamsDisplayedEvent'
Frame                  = React.createFactory(require 'ui/common/Frame')
StackBrowser           = React.createFactory(require 'ui/screens/workspace/sidebar/StackBrowser')
{div, ul}              = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Observe('teams', 'stacks')]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  componentDidMount: ->
    @publish new MyStacksDisplayedEvent()
    @publish new MyTeamsDisplayedEvent()

  sync: (stores) ->
    teams = stores.teams.getAllByMember(@props.currentUser.id)
    stacks = stores.stacks.getAllByUser(@props.currentUser.id)
    {teams, stacks}

  isReady: ->
    @state.teams? and @state.stacks?.length > 0

  render: ->

    Frame {@isReady, className: 'workspace sidebar'},
      StackBrowser {currentUser: @props.currentUser, stacks: @state.stacks, teams: @state.teams}

}

module.exports = WorkspaceSidebar

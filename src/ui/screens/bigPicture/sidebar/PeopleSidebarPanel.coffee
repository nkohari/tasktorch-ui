_           = require 'lodash'
React       = require 'react'
CachedState = require 'ui/framework/mixins/CachedState'
PropTypes   = require 'ui/framework/PropTypes'
Frame       = React.createFactory(require 'ui/common/Frame')
TeamList    = React.createFactory(require 'ui/screens/bigPicture/sidebar/TeamList')

PeopleSidebarPanel = React.createClass {

  displayName: 'PeopleSidebarPanel'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    teams   = cache('teamsByOrg').get(@props.currentOrg.id)
    myTeams = cache('myTeams').get()
    if teams? and myTeams?
      otherTeams = []
      for team in teams
        otherTeams.push(team) unless _.any(myTeams, (t) -> t.id == team.id)
    {myTeams, otherTeams}

  isReady: ->
    @state.myTeams? and @state.otherTeams?

  render: ->

    Frame {@isReady, className: 'content'},
      TeamList {title: 'My Teams',    teams: @state.myTeams}
      TeamList {title: 'Other Teams', teams: @state.otherTeams}

}

module.exports = PeopleSidebarPanel

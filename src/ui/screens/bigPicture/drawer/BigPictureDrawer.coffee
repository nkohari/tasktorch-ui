_           = require 'lodash'
React       = require 'react'
CachedState = require 'ui/framework/mixins/CachedState'
PropTypes   = require 'ui/framework/PropTypes'
KindList    = React.createFactory(require 'ui/screens/bigPicture/drawer/KindList')
TeamList    = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamList')
{div}       = React.DOM

BigPictureDrawer = React.createClass {

  displayName: 'BigPictureDrawer'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    kinds   = cache('kindsByOrg').get(@props.currentOrg.id)
    teams   = cache('teamsByOrg').get(@props.currentOrg.id)
    myTeams = cache('myTeams').get()
    if teams? and myTeams?
      otherTeams = []
      for team in teams
        otherTeams.push(team) unless _.any(myTeams, (t) -> t.id == team.id)
    {kinds, myTeams, otherTeams}

  render: ->

    div {className: 'big-picture drawer'},
      KindList {kinds: @state.kinds}
      TeamList {title: 'My Teams',    teams: @state.myTeams}
      TeamList {title: 'Other Teams', teams: @state.otherTeams}

}

module.exports = BigPictureDrawer

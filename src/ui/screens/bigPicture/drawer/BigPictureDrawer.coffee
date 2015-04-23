_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
ShellContext = require 'ui/framework/mixins/ShellContext'
KindList     = React.createFactory(require 'ui/screens/bigPicture/drawer/KindList')
TeamList     = React.createFactory(require 'ui/screens/bigPicture/drawer/TeamList')
{div}        = React.DOM

BigPictureDrawer = React.createClass {

  displayName: 'BigPictureDrawer'

  mixins: [CachedState, ShellContext]

  getCachedState: (cache) ->
    org     = @getCurrentOrg()
    kinds   = cache('kindsByOrg').get(org.id)
    teams   = cache('teamsByOrg').get(org.id)
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
